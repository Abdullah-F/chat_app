module Chats
  class Create < BaseService
    def execute
      order = fetch_order
      create_chat_async(order)
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
      subject = Subject.find_by!(token: token)
      subject.lock!
      subject.chats_count
    end

    def set_order_on_redis(current_order)
      redis_client.set(redis_key, current_order)
      redis_client.incr(redis_key)
    end

    def redis_client
      RedisClient
    end

    def redis_key
      @params[:subject_token]
    end
    alias :token :redis_key

    def create_chat_async(order)
      ChatWorker.perform_async({
        command: :create_chat,
        payload: { subject_token: @params[:subject_token], order: order }
      })
    end
  end
end
