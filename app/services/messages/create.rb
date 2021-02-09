module Messages
  class Create < BaseService
    def execute
      order = fetch_order_from_redis
      create_message_async(order)
      success(order: order)
    rescue ActiveRecord::RecordNotFound => e
      failure(error: e.message)
    end

    private

    def fetch_order_from_redis
      return redis_client.incr(redis_key) if redis_client.exists?(redis_key)
      chat = Chat.find_by!(subject_token: token, order: chat_order)
      chat.transaction do
        return redis_client.incr(redis_key) if redis_client.exists?(redis_key)
        redis_client.set(redis_key, chat.messages_count)
        redis_client.incr(redis_key)
      end
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
