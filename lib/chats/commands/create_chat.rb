module Chats
  module Commands
    class CreateChat
      def initialize(params)
        @params = params
      end

      def execute
        Chat.create!(@params)
      end
    end
  end
end
