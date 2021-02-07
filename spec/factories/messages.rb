FactoryBot.define do
  sequence(:order) { |n| n }
  factory :message do
    order
    body { "body" }
  end
end
