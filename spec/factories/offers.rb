FactoryBot.define do
  factory :offer do
    association :product
    buy_one_get_one_free

    trait :buy_one_get_one_free do
      association :offerable, factory: :offer_buy_one_get_one_free
    end

  end
end
