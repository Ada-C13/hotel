# I need a hotel_controller to be able to:
# control the business logic of adding/ finding reservations
# creating the 20 rooms, setting the costs/ discounts for rooms

module Hotel
  class Hotel::Controller
    attr_reader :rooms
    def initialize
      create_rooms
    end

    private

    def create_rooms
      @rooms = (1..20).map do |id|
        Hotel::Room.new(id)
      end
    end



    
  end
end

