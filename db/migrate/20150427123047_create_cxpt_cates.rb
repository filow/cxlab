class CreateCxptCates < ActiveRecord::Migration
  def change
    create_table :cxpt_cates,options:"charset=utf8" do |t|
      t.string :name

      t.index :name
    end
  end
end
