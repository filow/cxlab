class CreateJoinTableRoleNode < ActiveRecord::Migration
  def change
    create_join_table :roles, :nodes do |t|
      t.index [:role_id, :node_id]
      # t.index [:node_id, :role_id]
    end
    add_column :nodes_roles,:extra_data,:text,null: true
  end
end
