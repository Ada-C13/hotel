require_relative 'test_helper'

describe "Reservation class" do
  before do
    date = Date.parse("2020-02-01")
    room = Hotel::Room.new(10,200)
    @reservation = Hotel::Reservation.new(1, date, 10, "confirmed", room)
    
    temp_date = Date.parse("2020-11-07")
    @reservation_request = Hotel::Reservation.new(1, temp_date, 3)
  end

  describe "Reservation Instantiation" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "validates check in date" do
      expect{@reservation.check_in(Date)}.must_raise ArgumentError
    end

    it "validates number of days" do
      expect{@reservation.number_of_days(0)}.must_raise ArgumentError
    end

    it "assigns room" do
      expect(@reservation.room.room_number).must_equal 10
    end

    it "assigns room number to the room" do
      expect(@reservation.room_number).must_equal 10
    end

    it "creates a reservation request" do
      expect(@reservation_request.status).must_equal :pending
      expect(@reservation_request.room).must_equal nil
      expect(@reservation_request.room_number).must_equal nil
    end
  end #initialize

  describe "total cost method" do
    it "returns nil for reservation requests" do
      expect(@reservation_request.total_cost()).must_equal nil
    end

    it "returns the total cost for reservation" do
      expect(@reservation.total_cost()).must_equal 2000
    end
  end

  describe "is within stay method" do
    #TODO
  
  end

  describe "is overlap method" do
    #TODO
  end

  describe "are reservations overlapped method" do
    #TODO
  end

  describe "load all method" do
   #TODO
  end

end #class
