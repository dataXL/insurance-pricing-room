class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|

      ## Foreign keys
      t.references :tariff, index: true

      ## Properties
      t.float :exposition
      t.float :frequency
      t.float :risk # Product of exposition and frequency
      t.float :cost

      ## Timestamps
      t.timestamps null: false
    end

    ## Foreign Keys
    add_foreign_key :risks, :tariffs
  end
end
