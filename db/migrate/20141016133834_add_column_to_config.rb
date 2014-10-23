class AddColumnToConfig < ActiveRecord::Migration
  def change
    add_column :configs, :edit_flag, :boolean,default: false
  end
end
