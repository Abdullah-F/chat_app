class ChatsController < ApplicationController
  # was lazy to seriously Serialze the responses using a library, so I accepted
  # this simple manual searliaztion I did for the sake of this task, which is NOT DRY of course.
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

  def search
    result = Chats::Search.new(params).execute
    render json: messages_json(result.records), status: :ok
	end

  def show
    chat = Chat.eager_load(:messages).find_by!(
      subject_token: params[:subject_token],
      order: params[:order]
    )
    render json: chat_with_messages_json(chat), status: :ok
  end

  private

  def chat_with_messages_json(chat)
    chat.as_json(except:['id'])
      .merge(messages: messages_json(chat.messages))
  end

  def messages_json(messages)
    messages.map{ |m| m.as_json(except: [:id, :chat_id]) }
  end
end
