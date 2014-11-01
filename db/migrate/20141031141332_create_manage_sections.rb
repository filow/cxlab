class CreateManageSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name,null:false
      t.datetime :start_time
      t.datetime :end_time
      t.integer :xform_id
      t.belongs_to :compete
    end
  end
end
