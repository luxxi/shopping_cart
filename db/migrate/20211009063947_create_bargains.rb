class CreateBargains < ActiveRecord::Migration[7.0]
  def change
    create_table :bargains do |t|
      t.references :line_item, null: false, foreign_key: {
        to_table: :cart_line_items
      }
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
