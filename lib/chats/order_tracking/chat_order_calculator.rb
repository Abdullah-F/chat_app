module Chats
  module OrderTracking
    class ChatOrderCalculator < BaseCalculator
      def initialize(params)
        @subject_token = params.fetch(:subject_token)
      end

      private

      def pending_commands_in(queue)
        queue.map do |worker|
          worker.args.first if relevant_worker?(worker)
        end.compact
      end

      def relevant_worker?(worker)
        worker.args.first['command'] == 'create_chat' &&
          worker.args.first['payload']['subject_token'] == @subject_token
      end

      def fetch_order_from_db
        subject = Subject.find_by!(token: @subject_token)
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
        @subject_token
      end
    end
  end
end
