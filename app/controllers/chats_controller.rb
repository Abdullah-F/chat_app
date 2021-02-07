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
    chat = Chat.eager_load(:messages).find_by!(subject_token: params[:subject_token], order: params[:order])
    render json: chat_with_messages_json(chat), status: :ok
  end

  private

  def chat_with_messages_json(chat)
    chat.as_json(except:['id'])
      .merge(messages: chat.messages.map{ |m| m.as_json(except: ['id']) })
  end
end
