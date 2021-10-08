class AddFreebieQuantityToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_line_items, :freebie_quantity, :integer, default: 0
  end
end
