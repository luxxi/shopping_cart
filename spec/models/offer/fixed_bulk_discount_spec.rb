require 'rails_helper'

RSpec.describe Offer::FixedBulkDiscount, type: :model do
  it { should have_one(:offer) }

  let(:fixed_bulk_discount_offer) { build(:offer, :fixed_bulk_discount) }

  it 'expect FixedBulkDiscount offer responds to required methods' do
    expect(fixed_bulk_discount_offer).to respond_to(:apply)
    expect(fixed_bulk_discount_offer).to respond_to(:remove)
  end

  it 'expect FixedBulkDiscount offer is correct class' do
    expect(fixed_bulk_discount_offer.offerable_class)
      .to eq(Offer::FixedBulkDiscount)
  end

  let(:offer) { create(:offer, :fixed_bulk_discount) }
  describe '.apply' do
    subject do
      offer.apply(
        line_item: line_item,
        previous_quantity: line_item.quantity.pred
      )
    end
    context 'when quantity is 2' do
      let(:line_item) { create(:line_item, quantity: 2, price: 500.0) }

      it 'should not update price' do
        expect { subject }.to_not change { line_item.price }
      end
    end
    context 'when quantity is 3' do
      let(:line_item) { create(:line_item, quantity: 3, price: 500.0) }

      it 'should update price' do
        expect { subject }.to change { line_item.price }.from(500.0).to(450.0)
      end
    end
    context 'when quantity is 4' do
      let(:line_item) { create(:line_item, quantity: 4, price: 500.0) }

      it 'should not update price' do
        expect { subject }.to_not change { line_item.price }
      end
    end
  end

  describe '.remove' do
    let(:product) { create(:product) }
    subject do
      offer.remove(
        line_item: line_item,
        previous_quantity: line_item.quantity.succ
      )
    end
    context 'when quantity is 1' do
      let(:line_item) { create(:line_item, quantity: 1, price: 450.0) }

      it 'should not update price' do
        expect { subject }.to_not change { line_item.price }
      end
    end
    context 'when quantity is 2' do
      let(:line_item) { create(:line_item, quantity: 2, price: 450.0) }

      it 'should update price' do
        expect { subject }.to change { line_item.price }.from(450.0).to(500.0)
      end
    end
    context 'when quantity is 3' do
      let(:line_item) { create(:line_item, quantity: 3, price: 450.0) }

      it 'should not update price' do
        expect { subject }.to_not change { line_item.price }
      end
    end
  end
end
