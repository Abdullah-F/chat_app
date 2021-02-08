module Messages
  class Destroy < BaseService
    def execute
      destroy_message_async
      success
    end

    private

    def destroy_message_async
      ChatWorker.perform_async({
        command: :destroy_message,
        payload: {
          subject_token: @params[:subject_token],
          chat_order: @params[:chat_order],
          order: @params[:order],
        }
      })
    end
  end
end
