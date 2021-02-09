module Chats
  class Create < BaseService
    def execute
      order = calculator.calculate
      create_chat_async(order)
      success(order: order)
    rescue ActiveRecord::RecordNotFound => e
      failure(error: e.message)
    end

    private

    def calculator
      Chats::OrderTracking::BaseCalculator.calculator_for(
        :chat_order,
        { subject_token: @params[:subject_token] }
      )
    end

    def create_chat_async(order)
      ChatWorker.perform_async({
        command: :create_chat,
        payload: { subject_token: @params[:subject_token], order: order }
      })
    end
  end
end
