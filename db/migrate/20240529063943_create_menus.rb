class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.text :description
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
