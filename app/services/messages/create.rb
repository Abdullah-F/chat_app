module Messages
  class Create < BaseService
    def execute
      order = fetch_order
      create_message_async(order)
      success(order: order)
    rescue ActiveRecord::RecordNotFound => e
      failure(error: e.message)
    end

    private

    def fetch_order
      ActiveRecord::Base.transaction do
        order = fetch_order_from_redis_if_exists
        return order if order.present?
        order = fetch_order_from_sidekiq_pending_jobs
        order = fetch_order_from_db if order.nil?
        set_order_on_redis(order)
      end
    end

    def fetch_order_from_redis_if_exists
      redis_client.incr(redis_key) if redis_client.exists?(redis_key)
    end

    def fetch_order_from_sidekiq_pending_jobs

    end

    def fetch_order_from_db
      chat = Chat.find_by!(subject_token: token, order: chat_order)
      chat.lock!
      chat.messages_count
    end

    def set_order_on_redis(current_order)
      redis_client.set(redis_key, current_order)
      redis_client.incr(redis_key)
    end

    def redis_client
      RedisClient
    end

    def redis_key
      "#{token}:#{chat_order}"
    end

    def token
      @params[:subject_token]
    end

    def chat_order
      @params[:chat_order]
    end

    def create_message_async(order)
      ChatWorker.perform_async({
        command: :create_message,
        payload: {
          subject_token: token,
          chat_order: chat_order,
          order: order,
          body: @params[:body]
        }
      })
    end
  end
end
