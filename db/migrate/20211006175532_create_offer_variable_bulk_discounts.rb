class CreateOfferVariableBulkDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_variable_bulk_discounts do |t|

      t.timestamps
    end
  end
end
