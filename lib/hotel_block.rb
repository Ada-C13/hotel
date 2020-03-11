class Hotel_Block < Date_Range
  attr_accessor :room_info, :check_in_date, :check_out_date, :room_rate

  def initialize(room_ids, check_in_date, check_out_date, room_rate, hotel_block_id)
    # room_info maps a room_id to whether it has been occupied or not. So to begin with, all rooms in a hotel block are not occupied. They are set to a value of false, indicating that they are not occupied.
    @room_info =
      h = Hash[*room_ids.collect { |room_ids| [room_ids, (false)] }.flatten]
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @room_rate = room_rate
    @hotel_block_id = hotel_block_id
  end

  def check_rooms_available
    @room_info.each do |room_id, occupied|
      # If a room has occupied set to false, we know it is available.
      if occupied == false
        return true
      end
    end
    return false
  end
end
