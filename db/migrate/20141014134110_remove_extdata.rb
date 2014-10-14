class RemoveExtdata < ActiveRecord::Migration
  def change
    remove_columns :nodes_roles,:extra_data
    remove_columns :nodes,:field_type
    remove_columns :nodes,:extra_data
  end
end
