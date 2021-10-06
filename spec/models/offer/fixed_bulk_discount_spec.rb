require 'rails_helper'

RSpec.describe Offer::FixedBulkDiscount, type: :model do
  it { should have_one(:offer) }
end
