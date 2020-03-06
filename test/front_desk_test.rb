require_relative "test_helper"

describe Hotel::FrontDesk do
  before do
    @front_desk = Hotel::FrontDesk.new
    @date = Date.parse("2020-08-04")
  end
  describe "rooms list" do
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

    describe "get_avail_rooms" do
      before do
        @fd = Hotel::FrontDesk.new
        @res1 = @fd.reserve_room(Date.new(2020, 01,01), Date.new(2020,01,03))
        @res2 = @fd.reserve_room(Date.new(2020, 01,03), Date.new(2020,01,04))
        @res3 = @fd.reserve_room(Date.new(2020, 01,04), Date.new(2020,01,05))
        @res4 = @fd.reserve_room(Date.new(2020, 02,04), Date.new(2020,02,05))
      end
      it "returns array of rooms" do
        avail_rooms = @fd.get_avail_rooms(Date.new(2020, 03,01), Date.new(2020,03,31))
        expect(avail_rooms).must_be_kind_of Array
        expect(avail_rooms.any?(Hotel::Room)).must_equal true
        expect(avail_rooms.length).must_equal 20
      end
      it "contains only rooms available at specified dates" do
        rooms = @fd.get_avail_rooms(Date.new(2020, 01,01), Date.new(2020,01,31))
        expect(rooms.length).must_equal 17
        expect(rooms.any? {|room| room.reservations.include?(@res1)}).must_equal false
        expect(rooms.any? {|room| room.reservations.include?(@res2)}).must_equal false
        expect(rooms.any? {|room| room.reservations.include?(@res3)}).must_equal false
        expect(rooms.any? {|room| room.reservations.include?(@res4)}).must_equal true
      end
      it "does not contain rooms with reserv's overlapping the tail end of date range" do
        res5 = @fd.reserve_room(Date.new(2019, 12, 31), Date.new(2020, 01, 05))
        res6 = @fd.reserve_room(Date.new(2020, 01, 29), Date.new(2020, 02, 02))
        rooms = @fd.get_avail_rooms(Date.new(2020, 01,01), Date.new(2020,01,31))
        expect(rooms.any? {|room| room.reservations.include?(res5)}).must_equal false
        expect(rooms.any? {|room| room.reservations.include?(res6)}).must_equal false
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
