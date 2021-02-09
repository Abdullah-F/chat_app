require 'sidekiq/api'
module Messages
  class Create < BaseService
    def execute
      order = Chats::OrderTracking::MessageOrderCalculator.new(subject_token: token, chat_order: chat_order).calculate
      create_message_async(order)
      success(order: order)
    rescue ActiveRecord::RecordNotFound => e
      failure(error: e.message)
    end

    private

    def token
      @params[:subject_token]
    end

    def chat_order
      @params[:chat_order]
    end

    def create_message_async(order)
      ChatWorker.perform_async({
        command: :create_message,
        payload: {
          subject_token: token,
          chat_order: chat_order,
          order: order,
          body: @params[:body]
        }
      })
    end
  end
end
