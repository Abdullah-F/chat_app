class ChatWorker
  include Sidekiq::Worker

  def perform(params)
  end
end
