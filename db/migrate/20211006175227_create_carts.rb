class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.decimal :total, default: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
