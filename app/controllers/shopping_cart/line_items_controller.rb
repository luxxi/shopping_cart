module ShoppingCart
  class LineItemsController < ApplicationController
    def create
      @line_item = ShoppingCart::AddLineItemActivity.call(
        cart: @current_cart,
        product_id: params[:product_id]
      )
    end

    def destroy
      @line_item = ShoppingCart::RemoveLineItemActivity.call(
        cart: @current_cart,
        line_item_id: params[:id]
      )
    end
  end
end
