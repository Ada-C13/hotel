require 'date'

module Hotel
  class DateRange
    attr_reader :arrive, :depart
    
    # parameters must be objects of class Date
    def initialize(arrive, depart)
      @arrive = arrive
      @depart = depart
    end

    def nights
      @depart - @arrive
    end

    def self.get_all_dates(arrive, depart)
      return [arrive] if arrive == depart
      return (arrive..depart).map { |date| date }
    end
  end
end
