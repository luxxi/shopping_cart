module ShoppingCart
  class AddLineItemActivity
    class << self
      def call(cart:, product_id:)
        new(cart: cart, product_id: product_id).call
      end
    end
    
    attr_accessor :cart, :product_id
  
    def initialize(cart:, product_id:)
      @cart = cart
      @product_id = product_id
    end
  
    def call
      Cart::LineItem.create(cart: cart, product: product, price: product.price)
    end
  
    private  
    def product
      product ||= Product.find(product_id)
    end
  end  
end
