class AddColumnsToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :field_type, :string
  end
end
