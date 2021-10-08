class Offer::BuyOneGetOneFree < ApplicationRecord
  include Offerable

  def apply(line_item:, previous_quantity:)
    return line_item unless eligible(line_item, previous_quantity)

    line_item.tap do |l|
      l.increment(:quantity)
      l.increment(:freebie_quantity)
      l.save!
    end
  end

  def remove(line_item:, previous_quantity:)
    return line_item unless not_eligible(line_item, previous_quantity)

    line_item.tap do |l|
      l.decrement(:quantity)
      l.decrement(:freebie_quantity)
      l.save!
    end
  end

  private
  def eligible(line_item, previous_quantity)
    line_item.quantity > previous_quantity &&
    line_item.freebie_quantity.zero?
  end

  def not_eligible(line_item, previous_quantity)
    line_item.quantity < previous_quantity &&
    line_item.quantity == 1
  end
end
