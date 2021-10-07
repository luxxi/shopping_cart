FactoryBot.define do
  factory :offer do
    association :product
    buy_one_get_one_free

    trait :buy_one_get_one_free do
      association :offerable, factory: :offer_buy_one_get_one_free
    end

    trait :fixed_bulk_discount do
      association :offerable, factory: :offer_fixed_bulk_discounts, price: 450.0
    end

    trait :variable_bulk_discount do
      association :offerable, factory: :offer_variable_bulk_discounts
    end
  end
end
