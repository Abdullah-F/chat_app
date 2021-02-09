module Chats
  module OrderTracking
    class MessageOrderCalculator < BaseCalculator
      def initialize(params)
        @subject_token = params.fetch(:subject_token)
        @chat_order = params.fetch(:chat_order)
      end

      private

      def relevant_worker?(worker)
        worker.args.first['command'] == 'create_message' &&
          worker.args.first['payload']['subject_token'] == @subject_token &&
          worker.args.first['payload']['chat_order'] == @chat_order
      end

      def fetch_order_from_db
        chat = Chat.find_by!(subject_token: @subject_token, order: @chat_order)
        chat.lock!
        chat.messages_count
      end


      def redis_key
        "#{@subject_token}:#{@chat_order}"
      end
    end
  end
end
