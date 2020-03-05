require_relative 'date_range'

module Hotel
  class Reservation
    attr_reader :id, :start_date, :end_date, :date_range, :room_id

    @@next_id = 1

    def initialize(date_range, room_id)  
      @date_range = date_range
      @start_date = date_range.start_date
      @end_date = date_range.end_date
    
      @room_id = room_id
      #do i want to also know about the room instance?

      @id = @@next_id
      @@next_id += 1

      # @hotel_block_id = -1
    end
  end
end


# attr_reader :id, :start_date, :end_date, :date_range, :room_id

# @@next_id = 1

# def initialize(start_date, end_date, room_id)  
#   raise ArgumentError.new("Please pass in Date class instances.") if !(start_date.is_a? Date) || !(end_date.is_a? Date)
#   raise ArgumentError.new("Live in the present! Dates should not be prior to today.") if start_date < Date.today
#   raise ArgumentError.new("End date should not be earlier than or the same day as start date.")  if end_date <= start_date
#   @start_date = start_date
#   @end_date = end_date
#   @date_range = DateRange.new(start_date, end_date)
#   @room_id = room_id

#   @id = @@next_id
#   @@next_id += 1
#   # @hotel_block_id
# end

# def  get_price
#   price = date_range.count_nights * 200.00 #should require relative room and take room.cost
#   return price
# end