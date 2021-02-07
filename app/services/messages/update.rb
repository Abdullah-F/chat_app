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
        payload: { order: order, chat_order: chat_order, subject_token: token, body: body }
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

    def body
      @params[:body]
    end
  end
end
