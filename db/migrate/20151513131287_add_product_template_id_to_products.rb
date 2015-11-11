class AddProductTemplateIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_template_id, :integer
    add_foreign_key :products, :product_templates
  end
end
