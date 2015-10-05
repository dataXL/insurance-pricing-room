class AddPropertiesOnProducts < ActiveRecord::Migration
  def change
    #enable_extension "hstore"
    #add_column :products, :properties, :hstore
    #add_index :products, :properties, using: :gin
  end
end
