class AddFieldsToCodings < ActiveRecord::Migration
  def change
    add_column :codings, :properties, :jsonb, null: false, default: '{}'
    add_index  :codings, :properties, using: :gin
  end
end
