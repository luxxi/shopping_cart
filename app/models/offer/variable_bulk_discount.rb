class Offer::VariableBulkDiscount < ApplicationRecord
  include Offerable

  def name
    "Bulk Discount"
  end

  def apply(line_item:, previous_quantity:)
    return line_item unless eligible(line_item, previous_quantity)

    line_item.tap do |l|
      l.update(price: discounted_price(l))
      l.bargains.create(offer: offer)
    end
  end

  def remove(line_item:, previous_quantity:)
    return line_item unless not_eligible(line_item, previous_quantity)
    
    line_item.tap do |l|
      l.update(price: offer.product.price)
      l.bargains.find_by(offer: offer)&.destroy!
    end
  end

  private
  def required_quantity
    3
  end

  def discount
    2.0/3.0
  end

  def eligible(line_item, previous_quantity)
    previous_quantity < required_quantity &&
    line_item.quantity == required_quantity
  end

  def not_eligible(line_item, previous_quantity)
    previous_quantity >= required_quantity &&
    line_item.quantity < required_quantity
  end

  def discounted_price(line_item)
    line_item.price * discount
  end
end
