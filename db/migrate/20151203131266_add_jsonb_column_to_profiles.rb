class AddJsonbColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :properties, :jsonb, null: false, default: '{}'
    add_index  :profiles, :properties, using: :gin
  end
end
