class RemoveColumnHourOfOperationFromRestaurantProfile < ActiveRecord::Migration[7.1]
  def change
    remove_column :restaurant_profiles, :hours_of_operation, :text
    add_column :restaurant_profiles, :opening_time, :time
    add_column :restaurant_profiles, :closing_time, :time
  end
end
