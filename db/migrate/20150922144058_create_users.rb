class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :picture

      t.timestamps
    end
    #User.create(name: "Jorge Pereira", emai: "jahpereira@gmail.com", password_digest: "<%= User.digest('foobar') %>")
  end
end
