module Chats
  class Create < BaseService
    def execute
      order = fetch_order_from_redis
      create_chat_async(order)
      success(order: order)
    end

    private

    def fetch_order_from_redis
      if !RedisClient.exists?(redis_key)
        RedisClient.set(redis_key, chats_count)
      end
      RedisClient.incr(redis_key)
    end

    def redis_key
      @params[:subject_token]
    end
    alias :token :redis_key

    def chats_count
      Subject.find_by(token: token).chats_count
    end

    def create_chat_async(order)
      ChatWorker.perform_async({
        command: :create_chat,
        payload: { order: order, subject_token: token }
      })
    end
  end
end
