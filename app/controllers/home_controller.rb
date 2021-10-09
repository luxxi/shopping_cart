class HomeController < ApplicationController
  def index
    @products = Product.all
    @line_items = @current_cart.line_items.includes(:offers).order(:created_at)
  end
end
