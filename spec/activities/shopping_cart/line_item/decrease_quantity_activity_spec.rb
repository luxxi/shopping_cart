require 'rails_helper'

RSpec.describe ShoppingCart::LineItem::DecreaseQuantityActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:line_item) { create(:line_item, cart: cart) }

    context 'when line item quantity is 2' do
      let(:line_item) { create(:line_item, cart: cart, quantity: 2) }

      subject do
        described_class.call(cart: cart, line_item: line_item)
      end

      it 'decrements line item quantity to 1' do
        expect{ subject }.to change{ line_item.quantity }.from(2).to(1)
      end
    end

    context 'when arguments are not provided' do
      it 'raises ArgumentError exception' do
        expect { described_class.call }.to raise_error(ArgumentError)
      end
    end
  end
end
