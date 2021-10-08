module ApplicationHelper
  def currency(amount)
    number_to_currency(amount.round / 100.0)
  end
end
