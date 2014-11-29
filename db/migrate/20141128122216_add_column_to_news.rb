class AddColumnToNews < ActiveRecord::Migration
  def change
    add_column :news, :summary, :string
  end
end
