class RestaurantProfile < ApplicationRecord
  belongs_to :business

  validates :name, presence: true, length: { minimum: 3, maximum: 200 }
  validates :description, presence: true, length: { minimum: 3, maximum: 600 }
  validates :phone, presence: true, length: { minimum: 3, maximum: 200 }
  validates :address, presence: true, length: { minimum: 3, maximum: 200 }
  validates :hours_of_operation, presence: true, length: { minimum: 3, maximum: 600 }
  validates :price, presence: true, length: { minimum: 3, maximum: 200 }
  validates :cuisine, presence: true, length: { minimum: 3, maximum: 200 }
  validates :dining_style, length: { maximum: 200 }
  validates :dress_code, length: { maximum: 200 }
  validates :parking_details, length: { maximum: 200 }
  validates :payment_options, length: { maximum: 200 }
  validates :executive_chef, length: { maximum: 200 }
  validates :website, length: { maximum: 200 }
  validates :catering, length: { maximum: 600 }
  validates :private_party_facilities, length: { maximum: 600 }
  validates :additional, length: { maximum: 600 }
end
