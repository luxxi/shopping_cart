module ShoppingCart
  class AddLineItemActivity
    class << self
      prepend ShoppingCartUpdatable

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
      if line_item.previously_new_record?
        update_discounts
      else
        increase_quantity
      end
    end
  
    private
    def increase_quantity
      ShoppingCart::LineItem::IncreaseQuantityActivity.call(
        cart: cart,
        line_item: line_item
      )
    end

    def update_discounts
      ShoppingCart::LineItem::UpdateBargainsActivity.call(
        cart: cart,
        line_item: line_item,
        previous_quantity: line_item.quantity.pred
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
