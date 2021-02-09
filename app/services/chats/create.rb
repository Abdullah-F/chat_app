module Chats
  class Create < BaseService
    def execute
      order = Chats::OrderTracking::ChatOrderCalculator.new(subject_token: @params[:subject_token]).calculate
      create_chat_async(order)
      success(order: order)
    rescue ActiveRecord::RecordNotFound => e
      failure(error: e.message)
    end

    private

    def create_chat_async(order)
      ChatWorker.perform_async({
        command: :create_chat,
        payload: { subject_token: @params[:subject_token], order: order }
      })
    end
  end
end
