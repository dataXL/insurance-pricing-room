class AddTagsToCrawlers < ActiveRecord::Migration
  def change
    add_column :crawlers, :tag, :string
    add_column :crawlers, :image_tag, :string
  end
end
