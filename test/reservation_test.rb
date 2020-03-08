require_relative 'test_helper'

describe "Reservation class" do
  before do
    @date = Date.parse("2020-02-01")
    @room = Hotel::Room.new(10,200)
    @reservation = Hotel::Reservation.new(1, @date, 10, "confirmed", @room)

    date2 = Date.parse("2020-02-15")
    room = Hotel::Room.new(10,200)
    @reservation2 = Hotel::Reservation.new(1, date2, 10, "confirmed", @room)

    date3 = Date.parse("2020-02-05")
    room = Hotel::Room.new(10,200)
    @reservation3 = Hotel::Reservation.new(1, date3, 10, "confirmed", @room)

    @confirmed_reservations = [@reservation, @reservation2, @reservation3]
    
    temp_date1 = Date.parse("2020-01-29")
    @reservation_request1 = Hotel::Reservation.new(1, temp_date1, 3)

    temp_date2 = Date.parse("2020-01-31")
    @reservation_request2 = Hotel::Reservation.new(1, temp_date2, 3)

    temp_date3 = Date.parse("2020-02-02")
    @reservation_request3 = Hotel::Reservation.new(1, temp_date3, 3)

    temp_date4 = Date.parse("2020-02-09")
    @reservation_request4 = Hotel::Reservation.new(1, temp_date4, 3)

    temp_date5 = Date.parse("2020-02-11")
    @reservation_request5 = Hotel::Reservation.new(1, temp_date5, 3)
  end

  describe "Reservation Instantiation" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "validates check in date" do
      expect{Hotel::Reservation.new(1, "date", 10, "confirmed", @room)}.must_raise ArgumentError
    end

    it "validates number of days" do
      expect{Hotel::Reservation.new(1, @date, -1, "confirmed", @room)}.must_raise ArgumentError
    end

    it "assigns room" do
      expect(@reservation.room.room_number).must_equal 10
    end

    it "assigns room number to the room" do
      expect(@reservation.room_number).must_equal 10
    end

    it "creates a reservation request" do
      expect(@reservation_request1.status).must_equal :pending
      assert_nil(@reservation_request1.room)
      assert_nil(@reservation_request1.room_number)
    end
  end #initialize

  describe "total cost method" do
    it "returns nil for reservation requests" do
      assert_nil(@reservation_request1.total_cost())
    end

    it "returns the total cost for reservation" do
      expect(@reservation.total_cost()).must_equal 2000
    end
  end

  describe "is within stay method" do
    it "checks if aDate is within the check in and check out, returns a boolean" do
      expect(@reservation_request1.is_within_stay(Date.parse("2020-12-01"))).must_equal false
      expect(@reservation_request1.is_within_stay(Date.parse("2020-01-31"))).must_equal true
    end
  end

  describe "is overlap method" do
    it "is a helper method to determine if this self.reservation overlaps with a reservation request" do
      expect(@reservation_request1.is_overlapped(@reservation)).must_equal false #chkout/chkin same day
      expect(@reservation_request2.is_overlapped(@reservation)).must_equal true #chkout overlaps chkin
      expect(@reservation_request3.is_overlapped(@reservation)).must_equal true #totally within
      expect(@reservation_request4.is_overlapped(@reservation)).must_equal true #chkout overlaps chkin
      expect(@reservation_request5.is_overlapped(@reservation)).must_equal false #chkout/chkin same day
    end
  end

  describe "are reservations overlapped method" do
    it "check is self reservation overlaps with an array of reservations" do
      expect(@reservation_request1.are_reservations_overlapped(@confirmed_reservations)).must_equal false
      expect(@reservation_request2.are_reservations_overlapped(@confirmed_reservations)).must_equal true
      expect(@reservation_request5.are_reservations_overlapped(@confirmed_reservations)).must_equal true
    end
  end

  describe "load_all_reservations method test" do
    it "loads correct number of reservations" do
      expect(Hotel::Reservation.load_all_reservations().length).must_equal 10
    end
  end
end #class