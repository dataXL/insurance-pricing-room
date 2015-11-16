class CreateUtilities < ActiveRecord::Migration
  def change
    create_table :utilities do |t|

      ## Timestamps
      t.timestamps null: false
    end
  end
end
