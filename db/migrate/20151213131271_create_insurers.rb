class CreateInsurers < ActiveRecord::Migration
  def change
    create_table :insurers do |t|

      ## Properties
      t.string :name
      t.string :timezone
      t.string :address
      t.string :city
      t.string :zip

      ## Timestamps
      t.timestamps null: false
    end
  end
end
