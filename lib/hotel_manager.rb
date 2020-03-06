module Hotel
  class HotelController
    # Wave 1
    attr_reader :rooms
    def rooms
      # You might want to replace this method with an attr_reader
      # array of hashes for rooms
      @rooms = []
      20.times do |i|
        @rooms << {(("room#{i+1}").to_sym) => []}
      end

      return @rooms
    end

    def reserve_room(start_date, end_date)
      # start_date and end_date should be instances of class Date
        # covered by having Reservation inherit from DateRange
      # need to keep in mind implementation of room choice

      # room chosen is based on the method! not by the user! (see README.md)
      # if nil, default will then redirect to be first available room
      # add reservation instance to @rooms array based off of room attribute
      # add date instance to @rooms array
      return Reservation.new(start_date, end_date)
    end

    def reservations(date)
      # Purpose: takes a Date and returns a list of Reservations
      
      # input is date that is parsed
      # loop through @rooms hash
        # for each 
       # using .between?
          # date.between?(start_date, end_date)
            # returng reservation.inspect
      # .find/.detect to search through each array of @rooms and return the reservation
      
      #@rooms[each:roomkey][:reservations]

      reservation_list = []
      # if date.between?(#list within rooms)
      #   reservation_list <<

      @rooms.each do |room| # O(20)
        room.each_value do |reservation| # O(20)
          reservation.each do |reservation_instance| # O(n)
            if date.between?(reservation_instance.start_date, reservation_instance.end_date)
              reservation_list << reservation_instance
            end
          end
        end
      end

      # reservation_list = @rooms.map do {}

      
      return reservation_list
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
