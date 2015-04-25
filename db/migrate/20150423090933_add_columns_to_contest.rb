class AddColumnsToContest < ActiveRecord::Migration
  def change
    add_column :contests, :is_single, :boolean,default: true
    add_column :contests, :is_group, :boolean,default: false
    add_column :contests, :group_member_limit, :integer,null: true

    add_index :contests, :is_single
    add_index :contests, :is_group
  end
end
