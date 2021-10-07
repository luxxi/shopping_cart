require 'rails_helper'

RSpec.describe "ShoppingCart::QuantitiesController", type: :request do
  describe "POST /line_items/:line_item_id/quantities/increase" do
    let(:cart) { create(:cart) }
    let(:line_item) { create(:line_item, cart: cart) }

    before do
      allow_any_instance_of(ShoppingCart::QuantitiesController)
        .to receive(:line_item)
        .and_return(line_item)
      ShoppingCart::QuantitiesController
        .instance_variable_set(:@current_cart, cart)
    end

    it "returns http success" do
      post "/shopping_cart/line_items/#{line_item.id}/quantities/increase",
        xhr: true
      expect(response).to have_http_status(:success)
    end
  end
end
