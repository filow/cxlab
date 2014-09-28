class CreateManageNodes < ActiveRecord::Migration
  def change
    create_table :nodes,options:"charset=utf8" do |t|
      t.string :name,null:false,limit:30
      t.string :title,null:false
      t.string :remark,null:true
      t.text :extra_data,null:true
      t.integer :sort,default:0
      t.integer :pid,default:0
    end
  end
end
