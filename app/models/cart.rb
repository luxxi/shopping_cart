class Cart < ApplicationRecord
  has_many :line_items, class_name: 'Cart::LineItem'
end
