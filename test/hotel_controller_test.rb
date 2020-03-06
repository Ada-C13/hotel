require_relative "test_helper"

describe Hotel::HotelController do 
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end
  describe "wave 1" do
    describe "initializer" do
      it "Creates an instance of hotel controler" do
        @hotel_controller.must_be_kind_of Hotel::HotelController
      end

      it "create the rooms" do
        rooms = @hotel_controller.rooms
        expect(rooms).must_be_kind_of Array
      end

      it "create 20 rooms" do
        rooms = @hotel_controller.rooms
        expect(rooms.length).must_equal 20
      end
    end
    describe "reservations_list_room_and_date" do
      it "return a reservation list for a specified room and a given date range" do
        room = Hotel::Room.new(1, 200)
        start_date = Date.today
        end_date = start_date + 3
        date_range = Hotel::DateRange.new(start_date,end_date) 
        # @reservation = Hotel::Reservation.new(1, date_range,room)    
        reservations_list_of_given_room_date_range = @hotel_controller.reservations_list_room_and_date(room, date_range)

        expect(reservations_list_of_given_room_date_range).must_be_kind_of Array
        reservations_list_of_given_room_date_range.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end

      it "The ability to reserve room when there are reservations with the same start_date and end_date" do
        #Arrange 
        start_date = Date.today
        end_date = start_date + 4
        reservation1 = @hotel_controller.reserve_room(start_date, end_date)
        
        # Action 
        reservation2 = @hotel_controller.reserve_room(start_date, end_date)


        # Assertion 
        expect(@hotel_controller.reservations.length).must_equal 2
        expect(reservation2.room.id).must_equal 2
      end 

      it " ########" do 
        start_date = Date.today
        end_date = start_date + 4

        num_room = 0
        while num_room < 20 do
          @hotel_controller.reserve_room(start_date, end_date)
          num_room +=1 
        end
      
        # Action 
        # reservation21 = @hotel_controller.reserve_room(start_date, end_date)
        # p reservation21.room

        expect{(@hotel_controller.reserve_room(start_date, end_date))}.must_raise ArgumentError
      
    end


    end

    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations_list(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end
    end
  end

  describe "wave 2" do
    describe "available_rooms" do
      xit "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
      end
    end
  end
end
