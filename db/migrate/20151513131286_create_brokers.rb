class CreateBrokers < ActiveRecord::Migration
  def change
    create_table :brokers do |t|

      ## Properties
      t.string :name
      t.jsonb :fields, null: false, default: '{}'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index :brokers, :fields, using: :gin
  end
end
