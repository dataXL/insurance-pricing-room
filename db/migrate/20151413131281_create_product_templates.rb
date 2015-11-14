class CreateProductTemplates < ActiveRecord::Migration
  def change
    create_table :product_templates do |t|
      t.string :name
      t.string :tag
      t.jsonb :properties, null: false, default: '{}'

      t.timestamps
    end

    add_index :product_templates, :properties, using: :gin
  end
end
