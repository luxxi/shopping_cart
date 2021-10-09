require 'rails_helper'

RSpec.describe "ShoppingCart::LineItems", type: :request do
  describe "POST /line_items" do
    let(:product) { create(:product) }

    context 'line item does not exist' do
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

    context 'line item does exist' do
      let(:cart) { create(:cart) }
      let(:line_item) { create(:line_item, cart: cart) }

      before do
        allow_any_instance_of(ShoppingCart::RemoveLineItemActivity)
          .to receive(:line_item)
          .and_return(line_item)
        ShoppingCart::LineItemsController
          .instance_variable_set(:@current_cart, cart)
      end

      it "returns http success" do
        delete "/shopping_cart/line_items/#{line_item.id}", xhr: true
        expect(response).to have_http_status(:success)
      end
    end
  end
end
