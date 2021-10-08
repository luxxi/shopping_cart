require 'rails_helper'

RSpec.describe ShoppingCart::LineItem::UpdateDiscountsActivity do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:line_item) { create(:line_item, cart: cart) }

    context 'when arguments are provided' do
      context 'previous quantity is lower than current quantity' do
        subject do
          described_class.call(
            cart: cart,
            line_item: line_item,
            previous_quantity: line_item.quantity.pred
          )
        end
        
        it_behaves_like "shopping cart updatable"

        context 'when offer buy one get one free applied to product' do
          before do
            create(:offer, :buy_one_get_one_free, product: line_item.product)
          end

          it 'should apply discount' do        
            expect_any_instance_of(Offer::BuyOneGetOneFree).to receive(:apply)
            subject
          end
        end
      end

      context 'previous quantity is higher than current quantity' do
        context 'when offer buy one get one free applied to product' do
          before do
            create(:offer, :buy_one_get_one_free, product: line_item.product)
          end

          subject do
            described_class.call(
              cart: cart,
              line_item: line_item,
              previous_quantity: line_item.quantity.succ
            )
          end

          it 'should remove discount' do        
            expect_any_instance_of(Offer::BuyOneGetOneFree).to receive(:remove)
            subject
          end
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
