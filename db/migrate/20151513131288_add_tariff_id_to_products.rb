class AddTariffIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :brand, :string
    add_column :products, :tariff_id, :integer
    add_foreign_key :products, :tariffs
  end
end
