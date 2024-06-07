class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.integer :party_size
      t.datetime :time
      t.string :status, default: "holded"
      t.string :cancel_log
      t.integer :occation
      t.string :special_request
      t.references :user, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
