class Menu < ApplicationRecord
  belongs_to :business

  validates :name, presence: true, length: { maximum: 300 }
end
