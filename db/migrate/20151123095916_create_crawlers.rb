class CreateCrawlers < ActiveRecord::Migration
  def change
    create_table :crawlers do |t|

      ## Properties
      t.string :name
      t.string :tag
      t.string :image_tag
      t.jsonb :fields, null: false, default: '{}'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index :crawlers, :fields, using: :gin
  end
end
