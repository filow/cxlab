class CreateCxptCates < ActiveRecord::Migration
  def change
    create_table :cxpt_cates,options:"charset=utf8" do |t|
      t.string :name,null:false
      t.string :display, limit:20
      t.index :name
    end
  end
end
