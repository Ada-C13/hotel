require 'date'

class Calendar

  def initialize (calendar)
    @calendar = calendar
  end

  calendar = {}

  def add_to_calendar(reservation)
  
    if !calendar.key?(reservation[:start_date])
      calendar[reservation[:start_date]] = []
      calendar[reservation[:start_date]] << reservation
    elsif @calendar.key?(reservation[:start_date])
      if calendar[reservation[:start_date]].length == 20
        raise NoRoomError.new ("There are no available rooms for the duration of specified dates.")
      end
      calendar[reservation[:start_date]] << reservation
    end
  
  end

end