class ChangeTariffsName < ActiveRecord::Migration
  def change
    rename_table :tariffs, :products
  end
end
