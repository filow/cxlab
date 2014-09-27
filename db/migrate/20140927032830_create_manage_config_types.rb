class CreateManageConfigTypes < ActiveRecord::Migration
  def change
    create_table :config_types,options:"charset=utf8" do |t|
      t.string :name
    end
  end
end
