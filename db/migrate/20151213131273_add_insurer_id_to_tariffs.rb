class AddInsurerIdToTariffs < ActiveRecord::Migration
  def change
    add_column :tariffs, :insurer_id, :integer
    add_index  :tariffs, :insurer_id
  end
end
