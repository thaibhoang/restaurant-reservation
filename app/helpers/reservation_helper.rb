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

  def create_link_with_available_choices(available_choices, party_size)
    links = []
    session[:reservation] ||= {}
    available_choices.each do |time, seating_options|
      token = SecureRandom.hex(10)
      session[:reservation][token] = {party_size: party_size, seating_options: seating_options, time: time}

      links << link_to( time.strftime("%I:%M %p"), 
                  select_seating_reservations_path(token: token),
                  class: "main-button main-button--red main-button--rectangle")
    end
    links
  end
end