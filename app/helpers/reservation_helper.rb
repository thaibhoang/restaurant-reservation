module ReservationHelper
  def party_size_choices
    (1..20).map do |i|
      [pluralize(i, "person"), i]
    end
  end

  def time_choices
    times = []
    time = Time.parse("12:00 AM")

    48.times do  # 24 hours * 2 = 48 half-hour intervals
      times << [time.strftime("%I:%M %p"), time.strftime("%H:%M")]
      time += 30.minutes
    end

    times
  end
end