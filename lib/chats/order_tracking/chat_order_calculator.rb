module Chats
  module OrderTracking
    class ChatOrderCalculator
      def initialize(params)
        @subject_token = params.fetch(:subject_token)
      end

      def calculate
        ActiveRecord::Base.transaction do
          order = fetch_order_from_redis_if_exists
          return order if order.present?
          order = fetch_order_from_sidekiq_pending_jobs
          order = fetch_order_from_db if order == 0
          set_order_on_redis(order)
        end
      end

      private

      def fetch_order_from_redis_if_exists
        redis_client.incr(redis_key) if redis_client.exists?(redis_key)
      end

      def fetch_order_from_sidekiq_pending_jobs
        max(max_order_in(default_queue), max_order_in(retry_set))
      end

      def max(*values)
        values.max
      end

      def retry_set
        Sidekiq::RetrySet.new
      end

      def default_queue
        Sidekiq::Queue.new
      end

      def max_order_in(queue)
        command = command_with_max_order_in(queue)
        return command['payload']['order'].to_i if command.present?
        0
      end

      def command_with_max_order_in(queue)
        pending_commands_in(queue).max_by do |command|
          command['payload']['order'].to_i
        end
      end

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
