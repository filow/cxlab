class CreateXforms < ActiveRecord::Migration
  def change
    create_table :xforms,options:"charset=utf8" do |t|
      t.string :name,null:false
      t.string :field_type,null:false
      t.string :default_val
      t.integer :length_limit
      t.string :data
      t.text :message
      t.string :value_range
      t.integer :sort,default:1
      t.belongs_to :section
    end
  end
end
