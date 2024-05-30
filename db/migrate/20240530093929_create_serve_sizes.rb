class CreateServeSizes < ActiveRecord::Migration[7.1]
  def change
    create_table :serve_sizes do |t|
      t.string :name
      t.decimal :price, precision: 7, scale: 2
      t.references :dish, null: false, foreign_key: true

      t.timestamps
    end
  end
end
