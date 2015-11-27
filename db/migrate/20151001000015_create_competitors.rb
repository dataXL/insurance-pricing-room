class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|

      ## Foreign keys
      t.references :tariff_id

      ## Properties
      t.string :name
      t.float :premium

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index  :competitors, :tariff_id
  end
end
