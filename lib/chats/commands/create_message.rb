module Chats
  module Commands
    class CreateMessage
      def initialize(params)
        @params = params
      end

      def execute
        Message.create!(
          body: @params['body'],
          order: @params['order'],
          chat: chat
        )
      end

      private

      def chat
        Chat.find_by!(
          subject_token: @params['subject_token'],
          order: @params['chat_order']
        )
      end
    end
  end
end
