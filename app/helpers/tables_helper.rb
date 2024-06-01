module TablesHelper
  def table_size(number_of_seats)
    case number_of_seats
    when 1..2
      "small"
    when 3..5
      "medium"
    when 6..8
      "large"
    else
      "xlarge"
    end
  end
end
