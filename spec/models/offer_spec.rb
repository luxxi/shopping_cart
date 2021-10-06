require 'rails_helper'

RSpec.describe Offer, type: :model do
  it { should belong_to(:product) }
end
