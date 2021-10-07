require 'rails_helper'

RSpec.describe ShoppingCart::AddLineItemActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    subject do
      described_class.call(cart: cart, product_id: product.id)
    end

    it 'adds line item to cart' do
      expect(subject.cart.line_items.count).to eq(1)
    end

    context 'when arguments are not provided' do
      it 'raises ArgumentError exception' do
        expect { described_class.call }.to raise_error(ArgumentError)
      end
    end
  end
end
