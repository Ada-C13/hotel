class Reservation
  attr_accessor :room, :start_date, :end_date

  def initialize(room, start_date, end_date)
    @room = room
    @start_date = start_date
    @end_date = end_date
  end

  # take in the Room class add_res method, converts date range into number of nights, each night * $200 less the one night

  def total
    total_cost_for_stay = number_of_nights? * 200
    return total_cost_for_stay
  end

  def number_of_nights?
    @room.add_reservation(start_date, end_date)
    date_range = end_date - start_date
    num_of_nights = date_range.to_i - 1
    return num_of_nights
  end
end
