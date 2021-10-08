module ShoppingCartUpdatable
  def call(cart:, **args)
    super.tap do
      recalculate_total!(cart)
    end
  end

  def recalculate_total!(cart)
    ShoppingCart::CalculateTotalActivity.call(cart: cart)
  end
end
