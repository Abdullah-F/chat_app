module Chats
  module OrderTracking
    class ChatOrderCalculator < BaseCalculator
      def local_initialize(params)
        @subject_token = params.fetch(:subject_token)
      end

      private

      def relevant_worker?(worker)
        worker.args.first['command'] == 'create_chat' &&
          worker.args.first['payload']['subject_token'] == @subject_token
      end

      def fetch_order_from_db
        subject = Subject.find_by!(token: @subject_token)
        subject.lock!
        subject.chats_count
      end

      def redis_key
        @subject_token
      end
    end
  end
end
