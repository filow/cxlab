class AddPidToCxptCate < ActiveRecord::Migration
  def change
    add_column :cxpt_cates, :pid, :integer
    add_column :cxpt_cates, :edit_flag, :boolean
  end
end
