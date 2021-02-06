class Subject < ApplicationRecord
  has_many :chats, foreign_key: :subject_token, primary_key: :token,
    dependent: :destroy
  after_initialize { self.token = SecureRandom.uuid }
end
