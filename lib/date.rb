require 'date'

require_relative 'frontdesk.rb'
require_relative 'reservation.rb'

module Hotel
  class DateRange

      def contains(date)
        (date >= @start_date && date < @end_date) ? true : false
      end
  
      def no_conflict?(new_start, new_end)
        if @end_date == new_start || new_start > @end_date || new_end < @start_date || new_end == @start_date
          return true
        elsif new_start >= @start_date && new_start < @end_date || new_end > @start_date
          return false
        end
      end
      
  end
end