class AddFieldsToRisks < ActiveRecord::Migration
  def change
    add_column :risks, :covariates, :jsonb, null: false, default: '{}'
    add_column :risks, :exposition, :integer
    add_column :risks, :frequency, :integer
    add_column :risks, :risk, :integer
    add_column :risks, :cost, :float
    add_index  :risks, :covariates, using: :gin
  end
end
