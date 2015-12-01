class CreateCoefficients < ActiveRecord::Migration
  def change
    create_table :coefficients do |t|

      ## References
      t.references :product_template, index: true

      ## Properties
      t.float :intercept
      t.jsonb :coefficients, null: false, default: '{}'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index :coefficients, :coefficients, using: :gin

    ## Foreign Keys
    add_foreign_key :coefficients, :product_templates
  end
end
