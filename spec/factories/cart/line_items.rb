FactoryBot.define do
  factory :line_item, class: Cart::LineItem do
    association :cart
    association :product
    quantity { 1 }
    price { 500.0 }
  end
end
