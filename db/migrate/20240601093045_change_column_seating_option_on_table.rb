class ChangeColumnSeatingOptionOnTable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tables, :seating_option_id, false
  end
end
