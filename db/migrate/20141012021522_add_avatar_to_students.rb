class AddAvatarToStudents < ActiveRecord::Migration
  def change
    add_column :students, :avatar, :string
  end
end
