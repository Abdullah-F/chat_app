module Chats
  module OrderTracking
    class BaseCalculator
      def self.calculator_for(type, params)
        if type == :message_order
          MessageOrderCalculator.new(params)
        elsif type == :chat_order
          ChatOrderCalculator.new(params)
        end
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

      protected

      def fetch_order_from_redis_if_exists
        redis_client.incr(redis_key) if redis_client.exists?(redis_key)
      end

      def fetch_order_from_sidekiq_pending_jobs
        max(max_order_in(default_queue), max_order_in(retry_set))
      end
    end
  end
end