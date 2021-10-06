class CreateCartLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_line_items do |t|
      t.references :cart, type: :uuid, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :price, precision: 10, scale: 2, default: nil

      t.timestamps
    end
  end
end
