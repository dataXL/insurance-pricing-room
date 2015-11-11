class CreateBrokers < ActiveRecord::Migration
  def change
    create_table :brokers do |t|
      t.string :name
      t.jsonb :fields, null: false, default: '{}'

      t.timestamps null: false
    end

    add_index :brokers, :fields, using: :gin
  end
end
