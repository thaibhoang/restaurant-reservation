class ServeSize < ApplicationRecord
  belongs_to :dish

  validates :name, presence: true, length: { maximum: 100 }
  validates :price, presence: true, numericality: { greater_than: 0 }

end
