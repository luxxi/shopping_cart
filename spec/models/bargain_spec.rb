require 'rails_helper'

RSpec.describe Bargain, type: :model do
  it { should belong_to(:line_item) }
  it { should belong_to(:offer) }
end
