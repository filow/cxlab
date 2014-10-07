class AddColumnToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :edit_flag, :boolean,default: false
  end
end
