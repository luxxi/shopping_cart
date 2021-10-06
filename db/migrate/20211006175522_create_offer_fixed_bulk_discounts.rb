class CreateOfferFixedBulkDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_fixed_bulk_discounts do |t|
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
