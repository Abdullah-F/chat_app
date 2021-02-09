module Chats
  module Commands
    class UpdateMessage
      def initialize(params)
        @params = params
      end

      def execute
        Message.find_by!(chat: chat, order: @params['order']).update!(
          body: @params['body'],
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
