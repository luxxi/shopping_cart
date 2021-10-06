require 'rails_helper'

describe Cart::LineItem, type: :model do
  it { should belong_to(:cart) }
  it { should belong_to(:product) }
end
