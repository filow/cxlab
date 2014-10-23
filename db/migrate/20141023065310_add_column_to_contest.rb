class AddColumnToContest < ActiveRecord::Migration
  def change
    add_column :contests, :fullname, :string
    add_column :contests, :website_url, :string
    add_column :contests, :is_deleted, :boolean, default: false
  end
end
