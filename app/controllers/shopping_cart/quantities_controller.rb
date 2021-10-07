module ShoppingCart
  class QuantitiesController < ApplicationController
    def increase
      @line_item = ShoppingCart::LineItem::IncreaseQuantityActivity.call(
        cart: @current_cart,
        line_item: line_item
      )
      render template: 'shopping_cart/line_items/update'
    end

    def decrease
      @line_item = ShoppingCart::LineItem::DecreaseQuantityActivity.call(
        cart: @current_cart,
        line_item: line_item
      )
      render template: 'shopping_cart/line_items/update'
    end

    private
    def line_item
      line_item ||= @current_cart.line_items.find(params[:line_item_id])
    end
  end
end
