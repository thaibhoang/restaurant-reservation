class CreateSeatingOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :seating_options do |t|
      t.string :name
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end

    add_index :seating_options, [:business_id, :name], unique: true
  end
end
