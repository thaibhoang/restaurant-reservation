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
  validate :time_divisible_by_15_minutes
  validates :time, :party_size, presence: true
  validates :party_size, numericality: { greater_than: 0, only_integer: true }


  SEARCH_RADIUS = 30

  def self.find_availabale_tables(table_ids, time, duration)
    time_slots = find_time_slots(time)
    result = []
    table_ids.each do |table_id|
      reserved_slots = find_reserved_slots_of_table(time, duration, table_id)
      free_slots = filter_conflict_slots(reserved_slots, time_slots, duration)
      result += free_slots.map { |free_slot| [free_slot, table_id] } unless free_slots.empty?
      time_slots -= free_slots
      break if time_slots.empty?
    end
    result.sort_by { |time_slot, id| time_slot }
  end

  def self.filter_conflict_slots(reserved_slots, slots, duration)
    slots.reject do |slot|
      reserved_slots.any? do |reserved_slot|
        (reserved_slot >= slot && (reserved_slot - slot) < duration.minutes) || (reserved_slot <= slot && (slot - reserved_slot) < duration.minutes)
      end
    end
  end

  def self.find_reserved_slots_of_table(time, duration, table_id)
    where(table_id: table_id).where('time >= ? AND time <= ?', (time - (duration + 30).minutes), (time + (duration + 30).minutes)).pluck(:time)
  end

  def self.find_time_slots(time)
    time_slots = []
    current_time_slot = time - SEARCH_RADIUS.minutes
    while current_time_slot <= time + SEARCH_RADIUS.minutes
      time_slots << current_time_slot
      current_time_slot += 15.minutes
    end
    time_slots
  end

  private

  def time_divisible_by_15_minutes
    if time.present? && (time.min % 15 != 0)
      errors.add(:time, 'must be divisible by 15 minutes')
    end
  end
end
