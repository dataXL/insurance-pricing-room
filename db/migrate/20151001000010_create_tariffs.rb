class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|

      ## Foreign keys
      t.references :insurer_id

      ## Properties
      t.jsonb   :properties, null: false, default: '{}'
      t.integer :segment, null: false, default: '1'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index   :tariffs, :insurer_id
    add_index   :tariffs, :properties, using: :gin
  end
end
