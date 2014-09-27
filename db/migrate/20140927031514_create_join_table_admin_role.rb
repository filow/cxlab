class CreateJoinTableAdminRole < ActiveRecord::Migration
  def change
    create_join_table :admins, :roles do |t|
      t.index [:admin_id, :role_id]
      # t.index [:role_id, :admin_id]
    end
  end
end
