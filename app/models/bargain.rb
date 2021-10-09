class Bargain < ApplicationRecord
  belongs_to :line_item, class_name: 'Cart::LineItem'
  belongs_to :offer
end
