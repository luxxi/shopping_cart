class Offer < ApplicationRecord
  belongs_to :product

  has_many :bargains
  has_many :line_items, through: :bargains, class_name: 'Cart::LineItem'

  delegated_type :offerable,
    types: %w[Offer::BuyOneGetOneFree Offer::FixedBulkDiscount Offer::VariableBulkDiscount],
    dependent: :destroy

  delegate :name, :apply, :remove, to: :offerable
end
