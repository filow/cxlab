class AddDescriptionToConfigs < ActiveRecord::Migration
  def change
    add_column :configs, :description, :text
    add_column :configs, :name, :string
  end
end
