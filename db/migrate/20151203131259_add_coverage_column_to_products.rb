class AddCoverageColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :coverage, :string
  end
end
