require 'date'

class Calendar

  def initialize (calendar)
    @calendar = calendar
  end

  calendar = {}

  def add_to_calendar(reservation)
  
    if !calendar.key?(reservation[:start_date])
      reservation[:total_nights].times do |i|
        i += 0 
        calendar[(Date.parse(reservation[:start_date]) + i).iso8601] = []
        calendar[(Date.parse(reservation[:start_date]) + i).iso8601] << reservation 
      end
  
    elsif calendar.key?(reservation[:start_date])
      reservation[:total_nights].times do |i|
        i += 0 

        if !calendar.key?((Date.parse(reservation[:start_date]) + i).iso8601)
          calendar[(Date.parse(reservation[:start_date]) + i).iso8601]= []
          calendar[(Date.parse(reservation[:start_date]) + i).iso8601] << reservation 

        else 
          if reservation[:start_date].length == 20
            raise NoRoomError.new ("There are no available rooms for the duration of specified dates.")
          end
          calendar[(Date.parse(reservation[:start_date]) + i).iso8601] << reservation 
        end

      end
    end
  end
end