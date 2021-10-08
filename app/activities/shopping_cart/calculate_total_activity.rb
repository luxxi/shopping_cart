module ShoppingCart
  class CalculateTotalActivity
    class << self
      def call(cart:)
        new(cart: cart).call
      end
    end
    
    attr_accessor :cart
  
    def initialize(cart:)
      @cart = cart
    end
  
    def call
      cart.update(total: total)
    end

    private
    def total
      cart.line_items.sum("price * quantity")
    end
  end  
end
