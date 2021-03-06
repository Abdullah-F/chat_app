class Chat < ApplicationRecord
  belongs_to :subject, foreign_key: :subject_token, primary_key: :token,
    counter_cache: true
  has_many :messages, dependent: :destroy
end
