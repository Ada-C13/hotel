# module Hotel
#   class Reservation
#     attr_reader :id, :start_date, :end_date, :room
#     def initialize(id: , start_date: , end_date: , room: )
#       @id = id
#       @start_date = start_date
#       @end_date = end_date
#       @room = room
#     end
#   end
# end


module Hotel
  class Reservation
    # Feel free to change this method signature as needed. Make sure to update the tests!
    def initialize(start_date, end_date, room)
    end

    def cost
      return 200
    end
  end
end