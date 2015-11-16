class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|

      ## Properties
      t.string :product_name
      t.integer :answer
      t.integer :product_id

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index  :surveys, :product_id
  end
end
