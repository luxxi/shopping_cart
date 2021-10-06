class CreateOfferBuyOneGetOneFrees < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_buy_one_get_one_frees do |t|

      t.timestamps
    end
  end
end
