require 'rails_helper'

RSpec.describe ShoppingCart::AddLineItemActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    context 'when arguments are provided' do
      subject do
        described_class.call(cart: cart, product_id: product.id)
      end

      it_behaves_like "shopping cart updatable"

      it 'returns line item' do
        expect(subject.class).to be(Cart::LineItem)
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

    context 'line item does not exist yet' do
      subject do
        described_class.call(cart: cart, product_id: product.id)
      end

      it 'adds line item to cart' do
        expect(subject.cart.line_items.count).to eq(1)
      end

      it 'should not increase quantity' do
        expect(ShoppingCart::LineItem::IncreaseQuantityActivity)
          .to_not receive(:call)
        subject
      end

      it 'sets line item price' do
        expect(subject.price).to eq(product.price)
      end
    end

    context 'line item does exist' do
      before do
        create(:line_item, cart: cart, product: product)
      end

      subject do
        described_class.call(cart: cart, product_id: product.id)
      end

      it 'updates quantity on line item' do
        expect(subject.quantity).to eq(2)
      end

      it 'does not create new line item' do
        expect(subject.cart.line_items.count).to eq(1)
      end

      it 'should increase quantity' do
        expect(ShoppingCart::LineItem::IncreaseQuantityActivity)
          .to receive(:call)
        subject
      end
    end
  end
end
