class FixAttributesName < ActiveRecord::Migration
  def change
    rename_column :products, :attributes, :properties
  end
end
