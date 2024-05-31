class Table < ApplicationRecord
  belongs_to :business
  belongs_to :seating_option, optional: true

  validates :number, presence: true, uniqueness: { scope: :business_id }, numericality: { greater_than: 0 }
  validates :seats, presence: true, numericality: { greater_than: 0, only_integer: true }
end
