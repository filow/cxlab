class AddColumnToConfigType < ActiveRecord::Migration
  def change
    add_column :config_types, :edit_flag, :boolean,default: false
  end
end
