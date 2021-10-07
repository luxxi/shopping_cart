class Offer::BuyOneGetOneFree < ApplicationRecord
  include Offerable

  def apply(line_item:, previous_quantity:)
    return line_item unless eligible(line_item, previous_quantity)

    line_item.increment!(:quantity)
  end

  def remove(line_item:, previous_quantity:)
    return line_item unless not_eligible(line_item, previous_quantity)

    line_item.decrement!(:quantity)
  end

  private
  def eligible(line_item, previous_quantity)
    line_item.quantity > previous_quantity &&
    line_item.quantity == 1
  end

  def not_eligible(line_item, previous_quantity)
    line_item.quantity < previous_quantity &&
    line_item.quantity == 1
  end
end
