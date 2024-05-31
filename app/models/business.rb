class Business < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :restaurant_profile, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :seating_options, dependent: :destroy
  has_many :tables, dependent: :destroy

end
