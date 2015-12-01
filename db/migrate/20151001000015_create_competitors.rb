class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|

      ## References
      t.references :tariff, index: true

      ## Properties
      t.string :insurer
      t.float :premium

      ## Timestamps
      t.timestamps null: false
    end

    ## Foreign Keys
    add_foreign_key :competitors, :tariffs
  end
end
