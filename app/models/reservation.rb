class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :table

  STATUSES = %w[holded booked canceled]
  enum occation: {
    birthday: 0,
    anniversary: 1,
    date_night: 2,
    business_Meal: 3,
    celebration: 4
  }

  validates :status, inclusion: { in: STATUSES }
  validate :time_divisible_by_15_minutes
  validates :time, :party_size, presence: true
  validates :party_size, numericality: { greater_than: 0, only_integer: true }
  validate :not_conflict


  SEARCH_RADIUS = 30

  def self.find_availabale_tables(business_id, party_size, time, duration, seating_option_ids)
    time_slots = find_time_slots(time)
    time_slots_with_seating_options = time_slots.product(seating_option_ids)
    available_tables = {}

    tables = Table.fetch_available_table(business_id, party_size)
    table_ids = tables.pluck(:id)
    all_reserved_slots = find_reserved_slots(time, duration, table_ids)

    tables.each do |table|
      reserved_slots = all_reserved_slots[table.id]
      free_slots = filter_conflict_slots(reserved_slots, time_slots, duration)
      unless free_slots.empty?
        free_slots.each do |free_slot|
          seating_option_id = table.seating_option.id
          available_tables[free_slot] ||= {}  # Initialize if not already
          available_tables[free_slot][seating_option_id] ||= table.id
          time_slots_with_seating_options -= [free_slot, seating_option_id]
        end
        break if time_slots_with_seating_options.empty?
      end
    end
    
    available_tables
  end

  def self.filter_conflict_slots(reserved_slots, slots, duration)
    slots.reject do |slot|
      reserved_slots.any? do |reserved_slot|
        conflict?(reserved_slot, slot, duration)
      end
    end
  end

  def self.conflict?(reserved_slot, slot, duration)
    (reserved_slot >= slot && (reserved_slot - slot) < duration.minutes) ||
      (reserved_slot <= slot && (slot - reserved_slot) < duration.minutes)
  end

  def self.find_reserved_slots(time, duration, table_ids)
    reservations = where(table_id: table_ids).where('time >= ? AND time <= ?', (time - (duration + 30).minutes), (time + (duration + 30).minutes)).pluck(:table_id, :time)

    # turn the array of arrays to a hash
    result = Hash.new { |hash, key| hash[key] = [] }
    reservations.each do |table_id, time|
      result[table_id] << time
    end
    result
  end

  def self.find_time_slots(time)
    time_slots = []
    current_time = time - SEARCH_RADIUS.minutes

    while current_time <= time + SEARCH_RADIUS.minutes
      time_slots << current_time
      current_time += 15.minutes
    end

    time_slots
  end

  private

  def time_divisible_by_15_minutes
    if time.present? && (time.min % 15 != 0)
      errors.add(:time, 'must be divisible by 15 minutes')
    end
  end

  def not_conflict
    return unless self.new_record?

    # Lock the table to prevent other transactions from modifying it
    table = Table.lock.find(table_id)
    duration = table.business.restaurant_profile.dining_duration.to_i
    reservations = Reservation.where(table_id: table_id).where('time > ? AND time < ?', time - duration.minutes, time + duration.minutes )
    unless reservations.blank?

      errors.add(:base, 'It seems like someone is holding this table, go back to see other options')
    end
  end
end
