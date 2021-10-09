module ShoppingCart
  module LineItem
    class DecreaseQuantityActivity
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
        line_item.decrement!(:quantity)
        line_item = update_discounts
        
        unless line_item.quantity.positive?
          remove_line_item
        else
          line_item
        end
      end

      private
      def update_discounts
        ShoppingCart::LineItem::UpdateBargainsActivity.call(
          cart: cart,
          line_item: line_item,
          previous_quantity: line_item.quantity.succ
        )
      end

      def remove_line_item
        ShoppingCart::RemoveLineItemActivity.call(
          cart: line_item.cart,
          line_item_id: line_item.id
        )
      end
    end
  end
end
