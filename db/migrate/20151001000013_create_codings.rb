class CreateCodings < ActiveRecord::Migration
  def change
    create_table :codings do |t|

      ## Properties
      t.jsonb :properties, null: false, default: '{}'

      ## Timestamps
      t.timestamps null: false
    end

    ## Indexes
    add_index  :codings, :properties, using: :gin
  end
end
