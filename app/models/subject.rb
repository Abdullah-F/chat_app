class Subject < ApplicationRecord
  has_many :chats, foreign_key: :subject_token, primary_key: :token,
    dependent: :destroy
  before_create { self.token = SecureRandom.uuid }
end
