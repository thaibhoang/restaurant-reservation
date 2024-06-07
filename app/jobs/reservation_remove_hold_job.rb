class ReservationRemoveHoldJob < ApplicationJob
  queue_as :default

  def perform(reservation_id)
    # Do something later
    reservation = Reservation.find(reservation_id)
    if reservation.status == "holded" && Time.current > reservation.created_at + 5.minutes
      reservation.destroy
    end
  end
end
