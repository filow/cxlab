class CreateManageProfessions < ActiveRecord::Migration
  def change
    create_table :professions,options:"charset=utf8" do |t|
      t.string :name
      t.integer :pid,default: 0
    end
  end
end
