class RemoveStartTimeFromSection < ActiveRecord::Migration
  def change
    remove_column :sections,:start_time
  end
end
