class AddColumnToStudent < ActiveRecord::Migration
  def change
    add_column :students, :is_email_checked, :boolean,default:false
    add_column :students, :is_phone_checked, :boolean,default:false
  end
end
