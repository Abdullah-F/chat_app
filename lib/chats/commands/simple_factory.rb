module Chats
  module Commands
    class SimpleFactory
      def self.create_command(params)
        case(params.fetch('command'))
        when 'create_chat'
          return CreateChat.new(params.fetch('payload'))
        when 'destroy_chat'
          return DestroyChat.new(params.fetch('payload'))
        when 'create_message'
          return CreateMessage.new(params.fetch('payload'))
        when 'destroy_message'
          return DestroyMessage.new(params.fetch('payload'))
        when 'update_message'
          return UpdateMessage.new(params.fetch('payload'))
        end
      end
    end
  end
end
