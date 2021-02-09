module Messages
  class Update < BaseService
    def execute
      update_message_async
      success
    end

    private

    def update_message_async
      ChatWorker.perform_async({
        command: :update_message,
        payload: {
          subject_token: @params[:subject_token],
          chat_order: @params[:chat_order],
          order: @params[:order],
          body: @params[:body],
        }
      })
    end
  end
end
