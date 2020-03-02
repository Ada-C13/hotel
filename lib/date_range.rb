require 'date'

module Hotel

  class DateRange
    attr_reader :start_date, :end_date
    def initialize(start_date:, end_date:)
      @start_date = Date.new(start_date[0],start_date[1],start_date[2])
      @end_date = Date.new(end_date[0],end_date[1],end_date[2])
    end 
    
  end 
end 