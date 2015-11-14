class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :product_name
      t.integer :answer
      t.integer :product_id

      t.timestamps null: false
    end

    add_index  :surveys, :product_id
  end
end
