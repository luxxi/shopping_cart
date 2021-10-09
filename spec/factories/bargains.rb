FactoryBot.define do
  factory :bargain do
    association :line_item
    association :offer
  end
end
