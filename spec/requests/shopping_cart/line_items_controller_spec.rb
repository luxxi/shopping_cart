require 'rails_helper'

RSpec.describe "ShoppingCart::LineItems", type: :request do
  describe "POST /line_items" do
    let(:product) { create(:product) }

    before do
      @params = {
        product_id: product.id
      }
    end

    it "returns http success" do
      post "/shopping_cart/line_items", params: @params, xhr: true
      expect(response).to have_http_status(:success)
    end
  end
end
