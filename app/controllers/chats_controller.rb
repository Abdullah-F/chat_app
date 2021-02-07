class ChatsController < ApplicationController
  def create
    result = Chats::Create.execute(params)
    if result.success?
      render json: result.order, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def destroy
    result = Chats::Destroy.execute(params)
    if result.success?
      render json: result.order, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def show
    chat_json = Chat.eager_load(:messages).find_by(subject_token: params[:subject_token], order: params[:order])
    render json: chat_json, status: :ok
  end
end
