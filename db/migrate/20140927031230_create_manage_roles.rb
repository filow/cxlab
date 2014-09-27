class CreateManageRoles < ActiveRecord::Migration
  def change
    create_table :roles,options:"charset=utf8" do |t|
      t.string :name,null:false
      t.boolean :is_enabled,default:true
      t.string :remark
    end
  end
end
