class CreateInsurers < ActiveRecord::Migration
  def change
    create_table :insurers do |t|
      t.string :name
      t.string :timezone
      t.string :address
      t.string :city
      t.string :zip

      t.timestamps
    end
  end
end
