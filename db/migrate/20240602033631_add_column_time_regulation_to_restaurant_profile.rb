class AddColumnTimeRegulationToRestaurantProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurant_profiles, :dining_duration, :integer, null: false, default: 180  # Default to 120 minutes (2 hours)
  end
end
