class ChatWorker
  include Sidekiq::Worker

  def perform(params)
    command = Chats::Commands::SimpleFactory.create_command(params.with_indifferent_access)
    command.execute
  end
end
