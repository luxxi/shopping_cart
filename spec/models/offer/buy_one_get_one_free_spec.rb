require 'rails_helper'

RSpec.describe Offer::BuyOneGetOneFree, type: :model do
  it { should have_one(:offer) }
end
