class AddForeignKeysToProducts < ActiveRecord::Migration
  def change
    add_column :products, :name, :string
    add_column :products, :tariff_id, :integer
    add_index  :products, :tariff_id
    add_column :products, :insurer_id, :integer
    add_index  :products, :insurer_id
    add_foreign_key :products, :tariffs
    add_foreign_key :products, :insurers
  end
end
