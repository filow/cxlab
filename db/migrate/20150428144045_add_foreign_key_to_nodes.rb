class AddForeignKeyToNodes < ActiveRecord::Migration
  def change
    add_foreign_key :nodes_roles,:nodes
    add_foreign_key :nodes_roles,:roles
  end
end
