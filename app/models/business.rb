class Business < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :restaurant_profile, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :seating_options, dependent: :destroy
  has_many :tables, dependent: :destroy

  after_create :create_default_seating_option

  private

  def create_default_seating_option
    seating_options.create(name: 'Default', indestructible: true)
  end

end
