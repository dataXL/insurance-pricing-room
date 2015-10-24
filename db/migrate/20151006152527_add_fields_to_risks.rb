class AddFieldsToRisks < ActiveRecord::Migration
  def change
    add_column :risks, :exposition, :integer
    add_column :risks, :frequency, :integer
    add_column :risks, :risk, :integer
    add_column :risks, :cost, :float
  end
end
