class CreateManageCompetes < ActiveRecord::Migration
  def change
    create_table :competes do |t|
      t.date :start_time,null: false
      t.date :end_time,null: false
      t.belongs_to :admin,null: false
      t.belongs_to :contest,null: false
      t.boolean :is_deleted,default: false
    end
  end
end
