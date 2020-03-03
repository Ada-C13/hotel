require_relative "test_helper"

describe "Hotel::HotelController" do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end

  describe "wave 1" do
    
    describe "rooms" do
      it "returns a list" do
        expect(@hotel_controller.rooms).must_be_kind_of Array
      end

      it "return 20 rooms" do
        expect(@hotel_controller.rooms.size).must_equal 20
      end

      it "return 20 rooms numbered 1 through 20" do
        (1..20).each do |room|
          expect(@hotel_controller.rooms.include?(room)).must_equal true
        end
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date   = start_date + 3
        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end

  # access the list of reservations for a specific date, so that I can track reservations by date
    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end
    end
  end
  # check whether reservations conflict with each other (this will come in wave 2!)
  describe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        start_date = @date
        end_date   = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date) # DateRange?

        expect(room_list).must_be_kind_of Array
      end
    end
  end
end

  # access the list of reservations for a specified room and a given date range
