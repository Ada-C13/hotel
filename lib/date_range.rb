require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out
    def initialize(check_in, check_out)
      @check_in = Date.new(check_in) unless !Date.valid_date?(check_in)
      @check_out = Date.new(check_out) unless !Date.valid_date?(check_out)
      @duration = Integer.new
      @days = []

      @days = find_days(check_in, check_out)
    end

    def find_days(check_in, check_out)
      #take the start and the end, if start.next.to_s is same as end.next.to_s, total_days gets [Date.new(start), Date.new(end)]. Else, do some logic to 
      return total_days
    end
  end
end