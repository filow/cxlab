class AddCoverToCxptMnews < ActiveRecord::Migration
  def change
    add_column :cxpt_news, :cover, :string
  end
end
