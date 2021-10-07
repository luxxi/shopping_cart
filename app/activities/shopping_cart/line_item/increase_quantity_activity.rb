module ShoppingCart
  module LineItem
    class IncreaseQuantityActivity
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
        line_item.increment!(:quantity)
      end
    end
  end
end
