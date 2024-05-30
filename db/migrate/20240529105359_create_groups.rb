class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
