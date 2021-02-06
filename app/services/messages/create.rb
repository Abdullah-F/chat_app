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
      if !RedisClient.exists?(redis_key)
        RedisClient.set(redis_key, messages_count)
      end
      RedisClient.incr(redis_key)
    end

    def redis_key
      "#{token}:#{chat_order}"
    end

    def messages_count
      Chat.find([token, chat_order]).messages_count
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
        payload: { order: order, chat_order: chat_order }
      })
    end
  end
end
