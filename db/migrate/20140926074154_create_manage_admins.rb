class CreateManageAdmins < ActiveRecord::Migration
  def change
    create_table :admins,options:"charset=utf8" do |t|
      t.string :uid,null:false
      t.string :nickname,null:false
      t.string :password,limit:64,null:false
      t.string :email
      t.text :desc
      t.boolean :is_enabled,default:true

      t.timestamps
    end
  end
end
