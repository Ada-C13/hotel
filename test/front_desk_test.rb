require_relative "test_helper"
# to do: refactor for more clarity - ex - @fd & @front_desk
describe Hotel::FrontDesk do
  before do
    @front_desk = Hotel::FrontDesk.new
    @date = Date.parse("2020-08-04")
  end

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

    it "successfully reserves a room when all rooms have at least one reservation" do
      (1..20).each do
        @front_desk.reserve_room(Date.new(2020, 01,01), Date.new(2020,01,03))
      end
      reservation21 = @front_desk.reserve_room(Date.new(2020, 01,03), Date.new(2020,01,04))
      room_with_21 = @front_desk.rooms.find {|room| room.reservations.length == 2}
      expect(room_with_21.reservations[1]).must_equal reservation21
    end

    it "raises argument error when no rooms are available" do
      (1..20).each do
        @front_desk.reserve_room(Date.new(2020, 01,01), Date.new(2020,01,03))
      end
      expect{@front_desk.reserve_room(Date.new(2020, 01,01), Date.new(2020,01,03))}.must_raise ArgumentError
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


  describe "get_reservations" do
    before do
      @date = Date.new(2020, 01, 05)
      @fd = Hotel::FrontDesk.new
      @res1 = @fd.reserve_room(Date.new(2020, 01, 01), Date.new(2020, 01, 06))
      @res2 = @fd.reserve_room(Date.new(2020, 01, 02), Date.new(2020, 01, 07))
      @res3 = @fd.reserve_room(Date.new(2020, 01, 03), Date.new(2020, 01, 10))
      @res4 = @fd.reserve_room(Date.new(2020, 02, 04), Date.new(2020, 02, 05))
    end

    it "takes a Date and returns a list of Reservations" do
      reservation_list = @front_desk.get_reservations(@date)
      expect(reservation_list).must_be_kind_of Array

      reservation_list.each do |res|
        expect(res).must_be_kind_of Hotel::Reservation
      end
    end

    it "includes reservations that include specified date" do
      
      reservation_list = @fd.get_reservations(@date)
      expect(reservation_list.include?(@res1)).must_equal true
      expect(reservation_list.include?(@res2)).must_equal true
      expect(reservation_list.include?(@res3)).must_equal true
      expect(reservation_list.include?(@res4)).must_equal false
    end

    it "excludes reservations with end_date equal to specified date" do
      date = Date.new(2020, 01, 07)
      reservation_list = @fd.get_reservations(date)
      expect(reservation_list.include?(@res2)).must_equal false
      expect(reservation_list.include?(@res3)).must_equal true
    end

  end

end

