module ShoppingCart
  class RemoveLineItemActivity
    class << self
      prepend ShoppingCartUpdatable

      def call(cart:, line_item_id:)
        new(cart: cart, line_item_id: line_item_id).call
      end
    end
    
    attr_accessor :cart, :line_item_id
  
    def initialize(cart:, line_item_id:)
      @cart = cart
      @line_item_id = line_item_id
    end
  
    def call
      line_item.destroy!
    end
  
    private
    def line_item
      line_item ||= cart.line_items.find(line_item_id)
    end
  end
end
