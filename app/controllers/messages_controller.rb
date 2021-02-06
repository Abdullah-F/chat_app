class MessagesController < ApplicationController
  def create
    render json: 1, status: :ok
  end
end
