class AddJsonbColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :properties, :jsonb, null: false, default: '{}'
    add_index  :products, :properties, using: :gin
  end
end
