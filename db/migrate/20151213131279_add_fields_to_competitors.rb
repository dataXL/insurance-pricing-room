class AddFieldsToCompetitors < ActiveRecord::Migration
  def change
    add_column :competitors, :name, :string
    add_column :competitors, :premium, :float
    add_column :competitors, :tariff_id, :integer
    add_index  :competitors, :tariff_id
  end
end
