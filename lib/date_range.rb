require "date"

#  - I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
#   - I can make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range
#   - I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, so that I cannot make two reservations for the same room that overlap by date

class Date_Range
  attr_reader :check_in_date, :check_out_date

  # this is were we will handle the date, taking in the check in date and out date
  # if the check out date is more higher that checking in date the date is invalide
  # Example 2001,2 3 > 2001 2,4
  def initialize(check_in_date, check_out_date)
    unless check_out_date > check_in_date
      raise ArgumentError, "These dates are invalid."
    end
    @check_in_date = check_in_date
    @check_out_date = check_out_date
  end

  # every time Date_Range is called it takes in check in and out dates as parms
  # setting check_in and check_out allows me to compare two date ranges for overlap
  # if there is no overlap then return false
  # Example 2001,2 3 2001 2,4
  def overlaps_in_reservations?(new_date_range)
    if (new_date_range.check_in_date >= @check_out_date) || (new_date_range.check_out_date <= @check_in_date)
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
