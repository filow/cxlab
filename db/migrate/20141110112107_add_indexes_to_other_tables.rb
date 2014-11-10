class AddIndexesToOtherTables < ActiveRecord::Migration
  def change
    add_index :competes,:end_time
    add_index :competes,:start_time

    add_index :contests,:is_deleted

    add_index :news, :publish_at, order: {publish_at: :desc}
    add_index :news, :is_draft
    add_index :news, :is_deleted
    add_index :news, :contest_id

    add_index :professions,:pid

    add_index :sections, :start_time
    add_index :sections, :end_time

    add_index :xforms,:sort,order:{sort: :desc}

  end
end
