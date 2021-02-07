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
        payload: @params
      })
    end
  end
end
