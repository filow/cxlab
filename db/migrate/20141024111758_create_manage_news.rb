class CreateManageNews < ActiveRecord::Migration
  def change
    create_table :news,options:"charset=utf8" do |t|
      t.string :title,null:false
      t.string :author
      t.text :content
      t.text :pure_content
      t.boolean :is_draft,default: true
      t.boolean :is_deleted,default: false
      t.datetime :publish_at
      t.belongs_to :contest
      t.belongs_to :admin
      t.timestamps
    end
  end
end
