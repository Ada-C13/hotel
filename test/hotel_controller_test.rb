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
      it "when there is no reservation, retrun a empty reservation list for a specified room and a given date range" do
        room = Hotel::Room.new(1, 200)
        start_date = Date.today
        end_date = start_date + 3
        date_range = Hotel::DateRange.new(start_date,end_date)
        reservations_list = @hotel_controller.reservations_list_room_and_date(room,date_range)

        expect(reservations_list).must_equal []
      end
      it "return a reservation list for a specified room and a given date range" do
        # reservation with date_range1
        room = Hotel::Room.new(1, 200)
        start_date1 = Date.new(2017, 01, 03)
        end_date1 = start_date1 + 3
        date_range1 = Hotel::DateRange.new(start_date1,end_date1) 
        reservation1 = Hotel::Reservation.new(1, date_range1,room)  
        @hotel_controller.add_reservation(reservation1)

        puts
        # reservation with data_range2
        room = Hotel::Room.new(1, 200)
        start_date2 = Date.new(2017, 01, 10)
        end_date2 = start_date2 + 4
        date_range2 = Hotel::DateRange.new(start_date2,end_date2)
        reservation2 = Hotel::Reservation.new(1, date_range2,room)
        @hotel_controller.add_reservation(reservation2)
        print @hotel_controller.reservations
        puts
        puts
        puts @hotel_controller.reservations.length
        # test_date_range
        test_start_date = Date.new(2017, 01, 01)
        test_end_date = test_start_date + 30
        test_date_range = Hotel::DateRange.new(test_start_date,test_end_date)
        # we expect to return a list of reservations of the same rooms with different date_ranges
        reservations_list_of_given_room_date_range = @hotel_controller.reservations_list_room_and_date(room, test_date_range)
        # print reservations_list_of_given_room_date_range

        print reservations_list_of_given_room_date_range

        expect(reservations_list_of_given_room_date_range).must_be_kind_of Array
        reservations_list_of_given_room_date_range.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end

        expect(reservations_list_of_given_room_date_range.length).must_equal 1    ########need to come back and check this 
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

      it "raise ArgumentError when there is no room avoalable" do 
        start_date = Date.today
        end_date = start_date + 4

        num_room = 0
        while num_room < 20 do
          @hotel_controller.reserve_room(start_date, end_date)
          num_room +=1 
        end

        expect{(@hotel_controller.reserve_room(start_date, end_date))}.must_raise ArgumentError 
    end


    end

    describe "total_cost" do
      it "return a total cost of a given reservation" do
        start_date = Date.today
        end_date = start_date + 4
        reservation = @hotel_controller.reserve_room(start_date, end_date)
        expect(reservation.cost).must_equal 800
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
      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
      end
      # I can view a list of rooms that are not reserved for a given date range, 
      # so that I can see all available rooms for that day
      it "take a two dates and re"


    end
  end
end
