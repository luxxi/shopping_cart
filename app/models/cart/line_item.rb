class Cart::LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  has_many :bargains, dependent: :destroy
  has_many :offers, through: :bargains

  def total_quantity
    quantity - freebie_quantity
  end
end
