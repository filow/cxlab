class RemoveXformIdFromSection < ActiveRecord::Migration
  def change
    remove_column :sections,:xform_id
  end
end
