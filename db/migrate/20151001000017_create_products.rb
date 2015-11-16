class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      ## Foreign keys
      t.integer :product_template_id
      t.integer :tariff_id

      ## Properties
      t.string :name
      t.string :brand
      t.jsonb :properties, null: false, default: '{}'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index :products, :properties, using: :gin
    add_index :products, :product_template_id
    add_index :products, :tariff_id

    ## Restrictions
    add_foreign_key :products, :product_templates
    # add_foreign_key :products, :tariffs
  end
end
