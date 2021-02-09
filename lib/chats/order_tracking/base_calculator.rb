module Chats
  module OrderTracking
    class BaseCalculator
      def self.calculator_for(type, params)
        if type == :message_order
          MessageOrderCalculator.new(params)
        elsif type == :chat_order
          ChatOrderCalculator.new(params)
        end
      end
    end
  end
end
