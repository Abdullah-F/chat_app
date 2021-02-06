class Message < ApplicationRecord
  belongs_to :chat, foreign_key: [:subject_token, :chat_order], counter_cache: true
end
