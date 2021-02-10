module Chats
  module Commands
    class SimpleFactory
      def self.create_command(params)
        command_class(params).new(params.fetch(:payload))
      end

      private

      def self.command_class(params)
        Commands.const_get(params.fetch(:command).camelize)
      end
    end
  end
end
