require 'rails_helper'

RSpec.describe Offer::BuyOneGetOneFree, type: :model do
  it { should have_one(:offer) }

  let(:buy_one_get_one_free_offer) { build(:offer, :buy_one_get_one_free) }

  it 'expect BuyOneGetOneFree offer responds to required methods' do
    expect(buy_one_get_one_free_offer).to respond_to(:apply)
    expect(buy_one_get_one_free_offer).to respond_to(:remove)
  end

  it 'expect BuyOneGetOneFree offer is correct class' do
    expect(buy_one_get_one_free_offer.offerable_class)
      .to eq(Offer::BuyOneGetOneFree)
  end

  let(:offer) { create(:offer, :buy_one_get_one_free) }
  describe '.apply' do
    subject do
      offer.apply(
        line_item: line_item,
        previous_quantity: line_item.quantity.pred
      )
    end
    context 'when quantity is 1' do
      let(:line_item) { create(:line_item, quantity: 1) }

      it 'should increment quantity' do
        expect { subject }.to change { line_item.quantity }.from(1).to(2)
      end

      it 'should increment freebie quantity' do
        expect { subject }.to change { line_item.freebie_quantity }.from(0).to(1)
      end
    end
    context 'when quantity is 2' do
      let(:line_item) { create(:line_item, quantity: 2, freebie_quantity: 1) }

      it 'should not increment quantity' do
        expect { subject }.to_not change { line_item.quantity }
      end

      it 'should not increment freebie quantity' do
        expect { subject }.to_not change { line_item.freebie_quantity }
      end
    end
  end

  describe '.remove' do
    subject do
      offer.remove(
        line_item: line_item,
        previous_quantity: line_item.quantity.succ
      )
    end
    context 'when quantity is 2' do
      let(:line_item) { create(:line_item, quantity: 2, freebie_quantity: 1) }

      it 'should not decrement quantity' do
        expect { subject }.to_not change { line_item.quantity }
      end

      it 'should not decrement freebie quantity' do
        expect { subject }.to_not change { line_item.freebie_quantity }
      end

    end
    context 'when quantity is 1' do
      let(:line_item) { create(:line_item, quantity: 1, freebie_quantity: 1) }

      it 'should decrement quantity' do
        expect { subject }.to change { line_item.quantity }.from(1).to(0)
      end

      it 'should decrement freebie quantity' do
        expect { subject }.to change { line_item.freebie_quantity }.from(1).to(0)
      end
    end
  end
end
