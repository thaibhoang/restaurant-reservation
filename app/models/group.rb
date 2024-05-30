class Group < ApplicationRecord
  belongs_to :menu
  has_many :dishes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 200 }

  def business
    self.menu.business
  end
end
