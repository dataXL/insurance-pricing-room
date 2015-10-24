class RenameProfilesTable < ActiveRecord::Migration
  def change
    rename_table :profiles, :tariffs
  end
end
