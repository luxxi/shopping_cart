require 'rails_helper'

RSpec.describe Offer::VariableBulkDiscount, type: :model do
  it { should have_one(:offer) }
  
  let(:variable_bulk_discount_offer) { build(:offer, :variable_bulk_discount) }

  it 'expect VariableBulkDiscount offer responds to required methods' do
    expect(variable_bulk_discount_offer).to respond_to(:name)
    expect(variable_bulk_discount_offer).to respond_to(:apply)
    expect(variable_bulk_discount_offer).to respond_to(:remove)
  end

  it 'expect VariableBulkDiscount offer is correct class' do
    expect(variable_bulk_discount_offer.offerable_class)
      .to eq(Offer::VariableBulkDiscount)
  end

  let(:offer) { create(:offer, :variable_bulk_discount) }
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

      it 'should not add bargain relation' do
        expect(subject.bargains.count).to eq(0)
      end
    end
    context 'when quantity is 3' do
      let(:line_item) { create(:line_item, quantity: 3, price: 500.0) }

      it 'should update price' do
        expect { subject }.to change { line_item.price }.from(500.0).to(333.33)
      end

      it 'should add bargain relation' do
        expect(subject.bargains.count).to eq(1)
      end
    end
    context 'when quantity is 4 and offer applied' do
      let(:line_item) { create(:line_item, quantity: 4, price: 500.0) }

      before do
        create(:bargain, offer: offer, line_item: line_item)
      end

      it 'should not update price' do
        expect { subject }.to_not change { line_item.price }
      end

      it 'should not add another bargain relation' do
        expect(subject.bargains.count).to eq(1)
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
      let(:line_item) { create(:line_item, quantity: 1, price: 333.33) }

      it 'should not update price' do
        expect { subject }.to_not change { line_item.price }
      end

      it 'should remove bargain relation' do
        expect(subject.bargains.count).to eq(0)
      end
    end
    context 'when quantity is 2' do
      let(:line_item) { create(:line_item, quantity: 2, price: 333.33) }

      it 'should update price' do
        expect { subject }.to change { line_item.price }.from(333.33).to(500.0)
      end

      it 'should remove bargain relation' do
        expect(subject.bargains.count).to eq(0)
      end
    end
    context 'when quantity is 3 and offer applied' do
      let(:line_item) { create(:line_item, quantity: 3, price: 333.33) }

      before do
        create(:bargain, offer: offer, line_item: line_item)
      end

      it 'should not update price' do
        expect { subject }.to_not change { line_item.price }
      end

      it 'should not remove bargain relation' do
        expect(subject.bargains.count).to eq(1)
      end
    end
  end
end
