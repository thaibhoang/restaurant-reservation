class AddIndestructibleToSeatingOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :seating_options, :indestructible, :boolean, default: false
  end
end
