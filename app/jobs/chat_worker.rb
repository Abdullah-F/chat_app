class ChatWorker
  include Sidekiq::Worker

  def perform(params)
    command = Chats::Commands::SimpleFactory.create_command(params)
    command.execute
  end
end
