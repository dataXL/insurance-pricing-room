class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|

      ## Foreign keys
      t.references :product_id

      ## Properties
      t.string :product
      t.integer :answer

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index  :surveys, :product_id
  end
end
