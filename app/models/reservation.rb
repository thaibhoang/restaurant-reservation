class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :table

  STATUSES = %w[booked canceled]
  enum occation: {
    Birthday: 0,
    Anniversary: 1,
    Date_night: 2,
    Business_Meal: 3,
    Celebration: 4
  }

  validates :status, inclusion: { in: STATUSES }

end
