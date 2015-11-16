class CreateProductTemplates < ActiveRecord::Migration
  def change
    create_table :product_templates do |t|

      ## Properties
      t.string :name
      t.string :tag
      t.jsonb :properties, null: false, default: '{}'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index :product_templates, :properties, using: :gin
  end
end
