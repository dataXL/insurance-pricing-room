class CreateCoefficients < ActiveRecord::Migration
  def change
    create_table :coefficients do |t|

      ## Properties
      t.float :intercept
      t.jsonb :coefficients, null: false, default: '{}'
      t.integer :product_template_id

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index  :coefficients, :product_template_id
    add_index :coefficients, :coefficients, using: :gin
  end
end
