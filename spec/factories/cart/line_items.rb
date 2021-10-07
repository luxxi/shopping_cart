FactoryBot.define do
  factory :line_item, class: Cart::LineItem do
    association :cart
    association :product
  end
end
