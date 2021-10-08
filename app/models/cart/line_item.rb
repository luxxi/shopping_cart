class Cart::LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_quantity
    quantity - freebie_quantity
  end
end
