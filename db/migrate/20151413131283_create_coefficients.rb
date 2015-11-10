class CreateCoefficients < ActiveRecord::Migration
  def change
    create_table :coefficients do |t|
  #    t.string :coefficient
  #    t.float :value
  #    t.integer :product_template_id
      t.float :intercept
      t.jsonb :coefficients, null: false, default: '{}'
      t.integer :product_template_id

      t.timestamps null: false
    end

      add_index  :coefficients, :product_template_id
      add_index :coefficients, :coefficients, using: :gin
  end
end
