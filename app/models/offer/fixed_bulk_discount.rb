class Offer::FixedBulkDiscount < ApplicationRecord
  include Offerable

  def apply(line_item:, previous_quantity:)
    return line_item unless eligible(line_item, previous_quantity)

    line_item.tap do |l|
      l.update(price: price)
    end
  end

  def remove(line_item:, previous_quantity:)
    return line_item unless not_eligible(line_item, previous_quantity)

    line_item.tap do |l|
      l.update(price: product.price)
    end
  end

  private
  def required_quantity
    3
  end

  def eligible(line_item, previous_quantity)
    previous_quantity < required_quantity &&
    line_item.quantity == required_quantity
  end

  def not_eligible(line_item, previous_quantity)
    previous_quantity >= required_quantity &&
    line_item.quantity < required_quantity
  end

  def product
    product ||= offer.product
  end
end
