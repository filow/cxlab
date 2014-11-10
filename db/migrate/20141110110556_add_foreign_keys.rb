class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :configs, :config_types, dependent: :delete
    add_foreign_key :competes, :contests, dependent: :delete
    add_foreign_key :sections, :competes, dependent: :delete
    add_foreign_key :xforms, :sections, dependent: :delete
  end

end
