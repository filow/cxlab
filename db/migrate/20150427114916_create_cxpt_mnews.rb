class CreateCxptMnews < ActiveRecord::Migration
  def change
    create_table :cxpt_news,options:"charset=utf8" do |t|
      t.string :title,null:false
      t.text :content,null:false
      t.text :summary,null:false
      t.string :author
      t.boolean :is_draft,default: true
      t.datetime :publish_at
      t.integer :view_count,default: 0
      t.integer :cxpt_cate_id

      t.timestamps

      t.index :title
      t.index :publish_at, order: :desc
      t.index :view_count, order: :desc
    end
  end
end
