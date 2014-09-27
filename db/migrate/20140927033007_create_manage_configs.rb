class CreateManageConfigs < ActiveRecord::Migration
  def change
    create_table :configs,options:"charset=utf8" do |t|
      t.string :key
      t.text :value
      t.belongs_to :config_type
      t.string :field_type
    end
  end
end
