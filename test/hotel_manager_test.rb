require 'test_helper.rb'

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.new(2020, 8, 4)
  end
  describe "wave 1" do
    describe "rooms" do
      before do
        @rooms = @hotel_controller.rooms
      end
      
      it "returns a list" do
        expect(@rooms).must_be_kind_of Array
      end

      it "has 20 rooms" do
        expect(@rooms.size).must_equal 20
      end
    end

    describe "reserve_room" do
      before do
        @rooms = @hotel_controller.rooms
        reservation = Hotel::Reservation.new(@date, (@date + 3))
        @rooms[0][:room1] << reservation
        @rooms[3][:room4] << reservation
      end
      
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)
        expect(reservation).must_be_kind_of Hotel::Reservation
      end

      it "is an an error for negative-length ranges" do
        start_date = Date.new(2017, 02, 01)
        end_date = Date.new(2017, 01, 01) 
  
        expect{@hotel_controller.reserve_room(start_date, end_date)}.must_raise ArgumentError, "Cannot have negative length for a date range"
      end
  
      it "is an error to create a 0-length range" do
        start_date = Date.new(2017, 01, 01)
        end_date = Date.new(2017, 01, 01)
        
        expect{@hotel_controller.reserve_room(start_date, end_date)}.must_raise ArgumentError, "Cannot have 0 length date range"
      end

    end

    describe "reservations" do
      before do
        @rooms = @hotel_controller.rooms
        reservation = Hotel::Reservation.new(@date, (@date + 3))
        @rooms[0][:room1] << reservation
        @rooms[3][:room4] << reservation
      end

      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end

      it "raises an error when an Date object is not provided provided" do
        expect{@hotel_controller.reservations("768")}.must_raise ArgumentError
      end

      it "returns an empty array if no match" do
        expect(@hotel_controller.reservations(Date.new(2020, 9, 4))).must_equal []
      end
    end

    describe  "reservations_by_room" do
      before do
        @rooms = @hotel_controller.rooms
        reservation = Hotel::Reservation.new(@date, (@date + 3))
        @rooms[4][:room5] << reservation
      end

      it "takes a room and date and returns a list of reservations" do
        reservation_list = @hotel_controller.reservations_by_room(:room5, Date.new(2020, 8, 5))
        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end

      it "raises an error when an Date object is not provided" do
        expect{@hotel_controller.reservations_by_room("898", "98")}.must_raise ArgumentError
      end

      it "returns an empty array if no match" do
        reservation_list = @hotel_controller.reservations_by_room(:room5, Date.new(2020, 9, 4))
        expect(@hotel_controller.reservations_by_room(:room5, Date.new(2020, 9, 4))).must_equal []
      end
    end
  end

  describe "wave 2" do
    describe "available_rooms" do
      #TODO add more tests
      before do
        @rooms = @hotel_controller.rooms
        reservation = Hotel::Reservation.new(@date, (@date + 3))
    
        @rooms[0][:room1] << reservation
        @rooms[3][:room4] << reservation
      end

      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
      end

      it "returns the correct available rooms" do
        room_list = @hotel_controller.available_rooms(@date, (@date + 3))
        available_rooms = ["room2", "room3", "room5", "room6", "room7", "room8", "room9", "room10", "room11", "room12", "room13", "room14", "room15", "room16", "room17", "room18", "room19", "room20"]
        
        expect(room_list).must_equal available_rooms
      end

      it "returns an empty array if there are no available rooms" do
        
      end

      it "raises an error if an invalid date range is provided" do
        
      end
    end
  end

end