class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|

      t.timestamps null: false
    end
  end
end
