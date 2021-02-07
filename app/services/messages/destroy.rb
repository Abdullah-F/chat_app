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
        payload: @params
      })
    end

    def token
      @params[:subject_token]
    end

    def chat_order
      @params[:chat_order]
    end

    def order
      @params[:order]
    end
  end
end
