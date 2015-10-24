class AddTariffIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :tariff_id, :integer
    add_index  :products, :tariff_id
  end
end
