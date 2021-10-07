require 'rails_helper'

RSpec.describe ShoppingCart::LineItem::IncreaseQuantityActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:line_item) { create(:line_item, cart: cart) }

    context 'when arguments are provided' do
      subject do
        described_class.call(cart: cart, line_item: line_item)
      end

      it 'increments line item quantity' do
        expect{ subject }.to change{ line_item.quantity }.by(1)
      end

      it 'should update discounts' do
        expect(ShoppingCart::LineItem::UpdateDiscountsActivity).to receive(:call)
        subject
      end
    end

    context 'when arguments are not provided' do
      it 'raises ArgumentError exception' do
        expect { described_class.call }.to raise_error(ArgumentError)
      end
    end
  end
end
