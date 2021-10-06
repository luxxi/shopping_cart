require 'rails_helper'

RSpec.describe Offer::VariableBulkDiscount, type: :model do
  it { should have_one(:offer) }
end
