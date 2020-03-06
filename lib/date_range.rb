require "date"

#  - I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
#   - I can make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range
#   - I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, so that I cannot make two reservations for the same room that overlap by date

class Date_Range
  attr_reader :check_in_date, :check_out_date

  def initialize(check_in_date, check_out_date)
    unless check_out_date > check_in_date
      raise ArgumentError, "These dates are invalid."
    end
    @check_in_date = check_in_date
    @check_out_date = check_out_date
  end

  # - The last day of a reservation is the checkout day, so the guest should not be charged for that night
  def overlaps_in_reservations?(new_date_range)
    if (new_date_range.check_out_date <= @check_in_date) || (new_date_range.check_in_date >= @check_out_date)
      return false
    else
      return true
    end
  end

  def number_of_nights?
    return @check_out_date - @check_in_date
  end
end

# def contains(date)
#   if date >= @check_in_date && date < @check_out_date
#     return true
#   else
#     return false
#   end
# end
