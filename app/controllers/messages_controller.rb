class MessagesController < ApplicationController
  def create
    result = Messages::Create.execute(create_params)
    if result.success?
      render json: result.order, status: :ok
    else
      render json: result.error, status: :unprocessable_entity
    end
  end

  def update
    result = Messages::Update.execute(create_params)
    if result.success?
      render json: result.order, status: :ok
    else
      render json: result.error, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:body)
    params.permit(:body, :subject_token, :chat_order)
  end
end
