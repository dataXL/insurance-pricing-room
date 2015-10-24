class AddInsurerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :insurer_id, :integer
    add_index  :users, :insurer_id
  end
end
