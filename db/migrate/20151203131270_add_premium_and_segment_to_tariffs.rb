class AddPremiumAndSegmentToTariffs < ActiveRecord::Migration
  def change
    add_column :tariffs, :premium, :float
    add_column :tariffs, :segment, :integer, null: false, default: '1'
  end
end
