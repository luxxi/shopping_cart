require 'rails_helper'

RSpec.describe Offer, type: :model do
  it { should belong_to(:product) }
  it { should delegate_method(:name).to(:offerable) }
  it { should delegate_method(:apply).to(:offerable) }
  it { should delegate_method(:remove).to(:offerable) }
end
