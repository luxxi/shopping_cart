require 'rails_helper'

RSpec.describe ShoppingCart::RemoveLineItemActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:line_item) { create(:line_item, cart: cart) }

    context 'when arguments are provided' do
      subject do
        described_class.call(cart: cart, line_item_id: line_item.id)
      end

      it 'returns line item' do
        expect(subject.class).to be(Cart::LineItem)
      end

      it 'destroys line item' do
        expect(subject.destroyed?).to be(true)
      end
    end

    context 'when arguments are not provided' do
      it 'raises ArgumentError exception' do
        expect { described_class.call }.to raise_error(ArgumentError)
      end
    end
  end
end
