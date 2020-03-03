module Hotel
  class Reservation < DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)  #is a third item needed here an id?
     super(start_date, end_date)
    end

    def cost
      cost = nights * 200
      return cost.to_i
    end
  end
end