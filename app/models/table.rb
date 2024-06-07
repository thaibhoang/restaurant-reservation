class Table < ApplicationRecord
  belongs_to :business
  belongs_to :seating_option

  validates :number, presence: true, uniqueness: { scope: :business_id }, numericality: { greater_than: 0 }
  validates :seats, presence: true, numericality: { greater_than: 0, only_integer: true }

  def self.fetch_available_table(business_id, party_size)
    where(business_id: business_id)
      .where("seats > ?", party_size).includes(:seating_option)
      .order(:id)
      .order(:seats)
  end

  def self.validate_bulk_base_info(number_of_tables, starting_number, seats)
    positive_int?(number_of_tables) && positive_int?(starting_number) && positive_int?(seats)
  end

  def self.positive_int?(number)
    number.to_s.match?(/\A\d+\z/) && number.to_i > 0
  end

  def self.create_bulk(number_of_tables, starting_number, seats, seating_option, business)
    available_numbers = find_available_number(number_of_tables, starting_number, business)
    records = records_for_insert_all(available_numbers, seats, seating_option, business)
    insert_all(records)
  end

  def self.find_available_number(quantity, starting, business)
    used_numbers = business.tables.pluck(:number)
    result = []
    while quantity > 0 do
      unless used_numbers.include?(starting)
        result << starting
        quantity -= 1
      end
      starting += 1
    end
    result
  end

  def self.records_for_insert_all(numbers_array, seats, seating_option, business)
    numbers_array.map do |number|
      { number: number, seats: seats, seating_option_id: seating_option.id, business_id: business.id }
    end
  end

  def self.insert_all(records)
    normalized = normalize(records)
    super(normalized)
  end

  def self.normalize(records)
    records.each do |rec|
      add_timestamp(rec)
    end
  end

  def self.add_timestamp(record)
    time = Time.now.utc
    record['created_at'] = time
    record['updated_at'] = time
  end
end
