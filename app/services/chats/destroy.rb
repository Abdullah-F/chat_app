module Chats
  class Destroy < BaseService
    def execute
      destroy_message_async
      success
    end

    private

    def destroy_message_async
      ChatWorker.perform_async({
        command: :destroy_chat,
        payload: {
          subject_token: @params[:subject_token],
          order: @params[:order]
        }
      })
    end
  end
end
