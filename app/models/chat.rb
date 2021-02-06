class Chat < ApplicationRecord
  self.primary_keys = :subject_token, :order
  belongs_to :subject, foreign_key: :subject_token, primary_key: :token,
    counter_cache: true, dependent: :destroy
  has_many :messages, foreign_key: [:subject_token, :order]
end
