class Group < ApplicationRecord
  belongs_to :menu

  validates :name, presence: true, length: { maximum: 200 }
end
