class AddAvatarToContests < ActiveRecord::Migration
  def change
    add_column :contests, :cover, :string
  end
end
