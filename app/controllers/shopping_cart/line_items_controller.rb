module ShoppingCart
  class LineItemsController < ApplicationController
    def create
      @line_item = ShoppingCart::AddLineItemActivity.call(
        cart: @current_cart,
        product_id: params[:product_id]
      )
    end
  end
end
