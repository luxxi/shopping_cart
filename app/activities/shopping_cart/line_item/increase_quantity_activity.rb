module ShoppingCart
  module LineItem
    class IncreaseQuantityActivity
      class << self
        prepend ShoppingCartUpdatable

        def call(cart:, line_item:)
          new(cart: cart, line_item: line_item).call
        end
      end
      
      attr_accessor :cart, :line_item
    
      def initialize(cart:, line_item:)
        @cart = cart
        @line_item = line_item
      end
    
      def call
        line_item.increment!(:quantity)
        update_discounts
      end

      private
      def update_discounts
        ShoppingCart::LineItem::UpdateDiscountsActivity.call(
          cart: cart,
          line_item: line_item,
          previous_quantity: line_item.quantity.pred
        )
      end
    end
  end
end
