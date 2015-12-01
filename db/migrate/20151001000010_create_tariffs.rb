class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|

      ## Properties
      t.jsonb   :properties, null: false, default: '{}'
      t.integer :segment, null: false, default: '1'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index   :tariffs, :properties, using: :gin
  end
end
