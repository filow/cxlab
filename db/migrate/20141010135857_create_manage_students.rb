class CreateManageStudents < ActiveRecord::Migration
  def change
    create_table :students,options:"charset=utf8" do |t|
      t.string :stuid,limit:20
      t.string :name,null:false
      t.string :password,null:false,limit:64
      t.string :email,null:true
      t.string :phone,null:true
      t.belongs_to :profession
      t.integer :grade

      t.timestamps
    end
  end
end
