require 'rails_helper'

RSpec.describe ShoppingCart::LineItem::DecreaseQuantityActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:line_item) { create(:line_item, cart: cart) }

    subject do
      described_class.call(cart: cart, line_item: line_item)
    end

    context 'when arguments are provided' do      
      it_behaves_like "shopping cart updatable"
    end

    context 'when line item quantity is 2' do
      let(:line_item) { create(:line_item, cart: cart, quantity: 2) }

      it 'decrements line item quantity to 1' do
        expect{ subject }.to change{ line_item.quantity }.from(2).to(1)
      end

      it 'should update discounts' do
        expect(ShoppingCart::LineItem::UpdateDiscountsActivity)
          .to receive(:call)
          .and_return(line_item)
        subject
      end
    end

    context 'when line item quantity is 1' do
      let(:line_item) { create(:line_item, cart: cart, quantity: 1) }

      it 'removes line item' do
        expect(subject.cart.line_items.count).to eq(0)
      end

      it 'should remove line item' do
        expect(ShoppingCart::RemoveLineItemActivity).to receive(:call)
        subject
      end

      it 'should update discounts' do
        expect(ShoppingCart::LineItem::UpdateDiscountsActivity)
          .to receive(:call)
          .and_return(line_item)
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
