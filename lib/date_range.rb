module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date: , end_date: )
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)      

      raise ArgumentError.new("End date cannot be equal to or come before start date.") if @end_date <= @start_date
      #TODO: validate dates' input
    end

    # def initialize(start_date: nil, end_date: nil)
    #   start_date == nil ? @start_date = start_date : @start_date = Date.parse(start_date)
    #   end_date == nil ? @end_date = end_date : @end_date = Date.parse(end_date)

    #   if @end_date != nil && @start_date != nil && @end_date <= @start_date
    #     raise ArgumentError.new("End date cannot be equal to or come before start date.") 
    #   end
    # end

    def overlap?(date_range)
      raise ArgumentError.new("Must provide a date range.") unless date_range.is_a? DateRange 
      # raise ArgumentError.new("Must provide start and end dates.") if (date_range.start_date == nil || date_range.end_date == nil)
      start_date < date_range.end_date && end_date > date_range.start_date
    end

    def nights
      (end_date - start_date).to_i
    end

  end
end

# if end_date == nil
#   start_date = Date.parse(start_date)
#   reservations = room.reservations.select { |reservation| 
#     start_date < reservation.end_date
#   }
# elsif start_date == nil
#   end_date = Date.parse(end_date)
#   reservations = room.reservations.select { |reservation| 
#     end_date > reservation.start_date 
#   }
# else
#   start_date = Date.parse(start_date)
#   end_date = Date.parse(end_date)
#   # date_range = (start_date..end_date)
#   reservations = room.reservations.select { |reservation| 
#     start_date < reservation.end_date && end_date > reservation.start_date 
#   }
# end

########
# if start_date == nil
#   end_date > date_range.start_date
# end

# if start_date == nil && date_range.start_date == nil
#   true
# end