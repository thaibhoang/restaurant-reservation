class Menu < ApplicationRecord
  belongs_to :business
  has_many :groups, dependent: :destroy

  validates :name, presence: true, length: { maximum: 300 }
end
