class SeatingOption < ApplicationRecord
  belongs_to :business
  has_many :tables, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :business_id }
end
