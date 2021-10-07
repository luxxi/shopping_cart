module ShoppingCart
  module LineItem
    class DecreaseQuantityActivity
      class << self
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
        
        unless line_item.quantity.positive?
          remove_line_item
        else
          line_item
        end
      end

      private
      def remove_line_item
        ShoppingCart::RemoveLineItemActivity.call(
          cart: line_item.cart,
          line_item_id: line_item.id
        )
      end
    end
  end
end
