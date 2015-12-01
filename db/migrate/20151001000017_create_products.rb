class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      ## References
      t.references :competitor, index: true
      t.references :product_template, index: true

      ## Properties
      t.string :name,                    default: 'default'
      t.string :properties, array: true, default: []
      t.float :utility,                  default: '0.00'
      t.float :logit_e,                  default: '0.00'

      ## Timestamps
      t.timestamps null: false
    end

    ## Foreign Keys
    add_foreign_key :products, :competitors
    add_foreign_key :products, :product_templates
  end
end
