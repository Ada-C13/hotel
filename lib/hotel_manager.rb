module Hotel
  class HotelController
    # Wave 1
    attr_reader :rooms
    def rooms
      # You might want to replace this method with an attr_reader
      # array of hashes for rooms
      rooms = []

      room_base = []
      20.times do |i|
        room_base << ("room#{i+1}").to_sym
      end

      @rooms = []
      @rooms << room_base.each_with_object({}) do
          |key, h| h[key] = {:date => [], :reservation => []} 
          # may need to modify what's in my hash
          # on the right track but need to modify
          # just need reservation objects?
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
      return Reservation.new(start_date, end_date, nil)
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
      return []
    end

    # Wave 2
    def available_rooms(start_date, end_date)
      # start_date and end_date should be instances of class Date
      return []
    end
  end
end
