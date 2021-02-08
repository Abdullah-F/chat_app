module Chats
  module Commands
    class DestroyChat
      def initialize(params)
        @params = params
      end

      def execute
        Chat.find_by!(@params).destroy!
      end
    end
  end
end
