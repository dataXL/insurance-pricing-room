class AddJsonbColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :company, :string
    add_column :products, :attributes, :jsonb, null: false, default: '{}'
    add_index  :products, :attributes, using: :gin
    add_column :products, :premium, :float
  end
end
