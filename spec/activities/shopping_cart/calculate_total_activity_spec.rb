require 'rails_helper'

RSpec.describe ShoppingCart::CalculateTotalActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    context 'when arguments are provided' do
      subject do
        described_class.call(cart: cart)
      end
      before do
        create(:line_item, cart: cart, product: product)
      end
      context 'with one line item' do
        it 'returns total amount' do
          subject
          expect(cart.total).to eq(product.price)
        end
      end
      context 'with two line items' do
        let(:product2) { create(:product) }

        before do
          create(:line_item, cart: cart, product: product2)
        end

        it 'returns total amount' do
          subject
          expect(cart.total).to eq(product.price * 2)
        end
      end
    end

    context 'when arguments are not provided' do
      it 'raises ArgumentError exception' do
        expect { described_class.call }.to raise_error(ArgumentError)
      end
    end
  end
end
