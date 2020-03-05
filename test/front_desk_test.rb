require_relative "test_helper"

describe Hotel::FrontDesk do
  before do
    @front_desk = Hotel::FrontDesk.new
    @date = Date.parse("2020-08-04")
  end
  describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        rooms = @front_desk.rooms
        expect(rooms).must_be_kind_of Array
      end
    end
    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation, adds reservation to room" do
        start_date = @date
        end_date = start_date + 3

        reservation = @front_desk.reserve_room(start_date, end_date)
        expect(reservation).must_be_kind_of Hotel::Reservation
        room = @front_desk.rooms.find {|room| room.reservations.length > 0}
        expect(room.reservations.include? reservation).must_equal true
      end
    end

    xdescribe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @front_desk.reservations(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Reservation
        end
      end
    end
  end

  xdescribe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @front_desk.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
      end
    end
  end
end
