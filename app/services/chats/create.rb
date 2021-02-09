module Chats
  class Create < BaseService
    def execute
      order = fetch_order_from_redis
      create_chat_async(order)
      success(order: order)
    rescue ActiveRecord::RecordNotFound => e
      failure(error: e.message)
    end

    private

    def fetch_order_from_redis
      return redis_client.incr(redis_key) if redis_client.exists?(redis_key)
      subject = Subject.find_by!(token: token)
      subject.transaction do
        return redis_client.incr(redis_key) if redis_client.exists?(redis_key)
        redis_client.set(redis_key, subject.chats_count)
        redis_client.incr(redis_key)
      end
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
