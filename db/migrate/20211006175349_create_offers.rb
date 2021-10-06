class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :offerable_type
      t.bigint :offerable_id
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
