class Subject < ApplicationRecord
  before_create { self.token = SecureRandom.uuid }
end
