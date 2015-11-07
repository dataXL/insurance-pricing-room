class CreateCoefficients < ActiveRecord::Migration
  def change
    create_table :coefficients do |t|
      t.string :coefficient
      t.float :value
      t.integer :product_template_id

      t.timestamps null: false
    end

    add_index  :coefficients, :product_template_id
  end
end
