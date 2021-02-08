module Chats
  module Commands
    class SimpleFactory
      def self.create_command(params)
        if params.fetch('command') == 'create_chat'
          return CreateChat.new(params.fetch('payload'))
        end
      end
    end
  end
end
