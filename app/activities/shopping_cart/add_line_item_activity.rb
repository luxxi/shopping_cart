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
      return line_item if line_item.previously_new_record?
      increase_quantity
    end
  
    private
    def increase_quantity
      ShoppingCart::LineItem::IncreaseQuantityActivity.call(
        cart: cart,
        line_item: line_item
      )
    end
  
    def line_item
      line_item ||= Cart::LineItem
        .find_or_create_by(line_item_id) do |line_item|
          line_item.price = product.price
        end
    end
  
    def product
      product ||= Product.find(product_id)
    end

    def line_item_id
      {
        cart: cart,
        product: product
      }
    end
  end  
end
