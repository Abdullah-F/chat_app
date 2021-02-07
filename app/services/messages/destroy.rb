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
  end
end
