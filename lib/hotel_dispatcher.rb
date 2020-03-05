require_relative 'room'

module Hotel
  class HotelDispatcher
    attr_accessor :reservations, :rooms

    def initialize

      @reservations = []
      create_rooms
    end #initialize end

    def create_rooms
      @rooms = []
        
        (1..20).each do |room_num|
          room = Hotel::Room.new(room_num: 1)
          room.room_num = room_num
          @rooms << room
        end
        return @rooms
    end # create rooms end


    def make_reservation(start_date, end_date)
      room = create_rooms[0]
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, room: room)
      @reservations << new_reservation
      return @reservations
    end


    def find_all_res_for_room(room_num)
      found_reservations = []
        @reservations.each  do |reservation| 
           if reservation.room.room_num == room_num
            found_reservations << reservation
           end
        end
        return found_reservations
    end




    

   

    # def find_available_rooms(start_date, end_date)
    #   @reservations.each do |reservation|

    #   end
    # return []
    # end


  end # class end
end # module end



# def all_reservations(date)
# all_reservations_by_date = []
# return all_reservations_by_date
# end








