require 'test_helper.rb'

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
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
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)
        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end

    describe "reservations" do
      before do
        @rooms = @hotel_controller.rooms
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)
        @rooms[0][:room1] << reservation
      end
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        puts reservation_list
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
    end
  end

end