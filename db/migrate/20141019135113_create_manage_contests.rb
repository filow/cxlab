class CreateManageContests < ActiveRecord::Migration
  def change
    create_table :contests,options:"charset=utf8" do |t|
      t.string :name,null:false
      t.text :description
      t.string :summary
      t.string :level
      t.string :organizer
      t.belongs_to :admin
      t.timestamps
    end
  end
end
