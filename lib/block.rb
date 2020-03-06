# require_relative 'room'
# require_relative 'date_range'
# require_relative 'reservation'


# module Hotel
#   class Block < Reservation

#     def initialize(date_range, room_id, block)  
#       super(date_range,room_id)
  
#       @block = block
#     end
#   end
# end
    
# Scenario 1:
# Block < Reservation
# Coordinator#find_available_rooms:
# loop through each room
# status = true #room is available
# loop through each reservation per room
# if rs.class == Hotel::Block
#   if date_range overlap && rs.date_range is not the exact given date_range
#     status = false
#     break
#   end
# else
#   if rs.date_range overlaps
#     status = false
#   end 
# end
# unavailables << room if status == false

# Scenario 2:
# Reservation Class add extra attribute @block
# Coordinator#find_available_rooms:
# loop through each room
# status = true #room is available
# if room.bookings.empty? == false
#   loop through each reservation per room
#   if rs.block < 0
#     if rs.date_range overlap && rs.date_range is not the exact given date_range
#       status = false
#       break
#     end
#   else
#     if rs.date_range overlaps
#       status = false
#     end 
#   end
#   unavailables << room if status == false
# end




    ##method## I can check whether a given block has any rooms available
    # def check_block_vacancy
    
    # A block can contain a maximum of 5 rooms
    # date_range has to be exactly the same

    #I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate

    # A block can contain a maximum of 5 rooms
    # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
    # All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations




# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate
# I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve that specific room for that specific date, because it is unavailable
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot create another hotel block that includes that specific room for that specific date, because it is unavailable
# I can check whether a given block has any rooms available
# I can reserve a specific room from a hotel block
# I can only reserve that room from a hotel block for the full duration of the block
# I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)