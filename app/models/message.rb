class Message < ApplicationRecord
  searchkick text_middle: [:body]
  belongs_to :chat, counter_cache: true

	scope :search_import, -> { includes(chat: [:subject]) }

  def search_data
    {
      subject: chat.subject.token.to_s,
      chat: chat.order.to_s,
      body: body
    }
  end
end
