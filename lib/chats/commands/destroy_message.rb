module Chats
  module Commands
    class DestroyMessage
      def initialize(params)
        @params = params
      end

      def execute
        Message.find_by!(chat: chat, order: @params['order']).destroy!
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
