require_relative "test_helper"

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end
  describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        rooms = @hotel_controller.rooms
        expect(rooms).must_be_kind_of Array
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date,1)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end

      it "start_date and end_date should be instances of class Date" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date,1)

        expect(reservation.end_date).must_be_kind_of Date
        expect(reservation.start_date).must_be_kind_of Date
      end
    end

    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Reservation
        end
      end
      it "takes a Date and returns a list of Reservations" do
        reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10",1)
        reservation2 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",2)
        reservation3 = @hotel_controller.reserve_room("2020-08-09", "2020-08-12",3)

        reservation_list = @hotel_controller.reservations("2020-08-04")

        expect(reservation_list).must_be_kind_of Array
        expect(reservation_list[0].start_date).must_be_kind_of Date
        expect(reservation_list[0].start_date).must_equal Date.parse("2020-08-04")
        expect(reservation_list[0].end_date).must_equal Date.parse("2020-08-10")
        expect(reservation_list[1].start_date).must_equal Date.parse("2020-08-04")
        expect(reservation_list[1].end_date).must_equal Date.parse("2020-08-08")
        
        reservation_list1 = @hotel_controller.reservations("2020-08-11")
        expect(reservation_list1[0].start_date).must_equal Date.parse("2020-08-09")
        expect(reservation_list1[0].end_date).must_equal Date.parse("2020-08-12")
      end
    end

    describe "reservation_by_room_date" do
      it "takes a date and room and returns a list of Reservations" do
        reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10",1)
        reservation2 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",2)
        reservation3 = @hotel_controller.reserve_room("2020-08-09", "2020-08-12",3)

        reservation_list2 = @hotel_controller.reservation_by_date_room(@date,1)
        expect(reservation_list2[0].start_date).must_equal Date.parse("2020-08-04")
      end
      

      it "takes a date and room and returns the correct reservation and room" do
        reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10",1)
        reservation2 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",2)
        reservation3 = @hotel_controller.reserve_room("2020-08-09", "2020-08-12",3)

        reservation_list3 = @hotel_controller.reservation_by_date_room(@date,2)

        expect(reservation_list3[0].start_date).must_equal Date.parse("2020-08-04")
        expect(reservation_list3[0].end_date).must_equal Date.parse("2020-08-08")
        expect(reservation_list3[0].room).must_equal 2
        expect(reservation_list3.length).must_equal 1
        
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
    
      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list[0]).must_equal 1
      end

      it "takes two dates and returns a list all available rooms" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list.length).must_equal 20
      end

      it "takes two dates and returns the correct rooms" do
        reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10",1)
        reservation2 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",2)
        reservation3 = @hotel_controller.reserve_room("2020-08-09", "2020-08-12",3)

        start_date = @date #2020-08-04
        end_date = start_date + 10

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list.length).must_equal 17
        expect(room_list).must_equal [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
      end

      it "Returns Argument error for bad dates" do
        reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",1)
        
        start_date = @date #2020-08-04
        end_date = start_date - 10

        expect{@hotel_controller.available_rooms(start_date, end_date)}.must_raise ArgumentError
      end

      it "Returns Argument error for no rooms available" do
        reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",1)
        reservation2 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",2)
        reservation3 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",3)
        reservation4 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",4)
        reservation5 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",5)
        reservation6 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",6)
        reservation7 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",7)
        reservation8 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",8)
        reservation9 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",9)
        reservation10 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",10)
        reservation11 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",11)
        reservation12 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",12)
        reservation13 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",13)
        reservation14 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",14)
        reservation15 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",15)
        reservation16 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",16)
        reservation17 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",17)
        reservation18 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",18)
        reservation19 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",19)
        reservation20 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08",20)

        start_date = @date #2020-08-04
        end_date = start_date +3

        expect{@hotel_controller.available_rooms(start_date, end_date)}.must_raise ArgumentError
      end

    end
  end
end