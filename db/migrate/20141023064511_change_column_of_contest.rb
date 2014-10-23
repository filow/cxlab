class ChangeColumnOfContest < ActiveRecord::Migration
  def change
    change_table :contests do |t|
        t.remove :summary
        t.column :summary, :text
    end
  end
end
