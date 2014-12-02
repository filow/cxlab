class ChangeMails < ActiveRecord::Migration
  def change
     change_table :mails do |t|
      t.rename :stuid , :sid
    end
  end
end
