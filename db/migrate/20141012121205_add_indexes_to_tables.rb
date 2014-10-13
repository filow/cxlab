class AddIndexesToTables < ActiveRecord::Migration
  def change
    
    add_index :admins,:uid,unique: true
    
    add_index :configs,:key,unique: true
    add_index :configs,:config_type_id
    
    add_index :nodes,:name,unique: true
    add_index :nodes,:sort,order: {sort: :asc}

    add_index :students,:stuid,unique: true
    add_index :students,:name

  end
end
