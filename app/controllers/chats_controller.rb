class ChatsController < ApplicationController
  def create
    result = Chats::Create.execute(params)
    if result.success?
      render json: result.order, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end
end
