class Offer < ApplicationRecord
  belongs_to :product
  delegated_type :offerable,
    types: %w[Offer::BuyOneGetOneFree Offer::FixedBulkDiscount Offer::VariableBulkDiscount],
    dependent: :destroy
  delegate :apply, :remove, to: :offerable
end
