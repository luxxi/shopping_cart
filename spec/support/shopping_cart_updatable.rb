shared_examples "shopping cart updatable" do
  it 'should call recalculate activity' do
    expect(ShoppingCart::CalculateTotalActivity)
      .to receive(:call)
      .at_least(:once)
    subject
  end
end
