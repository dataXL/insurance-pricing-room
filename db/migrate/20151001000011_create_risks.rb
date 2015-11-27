class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|

      ## Foreign keys
      t.references :tariff

      ## Properties
      t.float :exposition
      t.float :frequency
      t.float :risk # Product of exposition and frequency
      t.float :cost

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index  :risks, :tariff_id
  end
end
