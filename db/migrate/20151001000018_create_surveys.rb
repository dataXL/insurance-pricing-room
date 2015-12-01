class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|

      ## References
      t.references :product, index: true

      ## Properties
      t.string :product
      t.integer :answer

      ## Timestamps
      t.timestamps null: false
    end

    ## Foreign Keys
    add_foreign_key :surveys, :products
  end
end
