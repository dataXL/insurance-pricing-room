class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|

      ## Foreign keys
      t.integer :tariff_id

      ## Properties
      t.integer :exposition
      t.integer :frequency
      t.integer :risk # Product of exposition and frequency
      t.float :cost

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index  :risks, :tariff_id
  end
end
