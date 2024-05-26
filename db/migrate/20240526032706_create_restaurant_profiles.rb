class CreateRestaurantProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_profiles do |t|
      t.string :name
      t.text :description
      t.string :phone
      t.string :address
      t.text :hours_of_operation
      t.string :price
      t.string :cuisine
      t.string :dining_style
      t.string :dress_code
      t.string :parking_details
      t.string :payment_options
      t.string :executive_chef
      t.string :website
      t.text :catering
      t.text :private_party_facilities
      t.text :additional
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
