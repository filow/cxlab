class CreateManageMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.string :stuid
      t.string :mail_key

      t.timestamps
    end
  end
end
