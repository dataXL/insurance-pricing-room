class AddTariffIdToRisks < ActiveRecord::Migration
  def change
    add_column :risks, :tariff_id, :integer
    add_index  :risks, :tariff_id
  end
end
