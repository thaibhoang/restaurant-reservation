class AddIndexOnSeatsToTables < ActiveRecord::Migration[7.1]
  def change
    add_index :tables, :seats
  end
end
