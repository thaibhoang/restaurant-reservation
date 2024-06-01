class SeatingOption < ApplicationRecord
  belongs_to :business
  has_many :tables, dependent: :destroy

  before_destroy :check_indestructible

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :business_id }

  private

  def check_indestructible
    if indestructible?
      errors.add(:base, 'This is the default seating option and is indestructible.')
      throw(:abort) 
    end
  end
end
