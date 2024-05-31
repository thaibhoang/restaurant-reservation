class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tables do |t|
      t.integer :number, null: false
      t.integer :seats, null: false
      t.references :business, null: false, foreign_key: true
      t.references :seating_option, null: true, foreign_key: true

      t.timestamps
    end

    add_index :tables, [:number, :business_id], unique: true
  end
end
