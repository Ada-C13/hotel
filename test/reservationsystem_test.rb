require_relative 'test_helper'

describe "ReservationSystem class" do
  before do
    @date_noreservation = Date.parse("2020-02-01")
    @date_yesreservation = Date.parse("2020-10-29")
    @ressystem1 = Hotel::ReservationSystem.new
    @room = Hotel::Room.new(1,200)
    @room2 = Hotel::Room.new(9,200)

    temp_date1 = Date.parse("2020-01-29")
    @reservation_request1 = Hotel::Reservation.new(1, temp_date1, 3)

    temp_date2 = Date.parse("2020-10-21")
    @reservation_request2 = Hotel::Reservation.new(1, temp_date2, 3)
  end 

  describe "Reservation System Instantiation" do
    it "is an instance of Reservation System" do
      expect(@ressystem1).must_be_kind_of Hotel::ReservationSystem
      expect(@ressystem1.rooms.length).must_equal 20
      expect(@ressystem1.reservations.length).must_equal 10
    end
  end #initialize

  describe "find reservations by date method" do
    it "validates room number " do
      expect{@ressystem1.find_reservations_by_date(@date_yesreservation, "0")}.must_raise ArgumentError
    end

    it "validates date" do
      expect{@ressystem1.find_reservations_by_date(2020-01-01)}.must_raise ArgumentError
    end

    it "finds reservations by date" do
      expect(@ressystem1.find_reservations_by_date(@date_noreservation).length).must_equal 0
      expect(@ressystem1.find_reservations_by_date(@date_yesreservation).length).must_equal 3
      expect(@ressystem1.find_reservations_by_date(@date_yesreservation, 5).length).must_equal 1
    end
  end

  describe "find room based on room number method" do
    it "validates room number" do
      expect{@ressystem1.find_room("0")}.must_raise ArgumentError
    end

    it "returns a room" do
      expect(@ressystem1.find_room(5).room_number).must_equal 5
      assert_nil(@ressystem1.find_room(100))
    end
  end

  describe "find reservations by room method" do
    it "validates the paramters of a Room" do
      expect{@ressystem1.find_reservations_by_room("0")}.must_raise ArgumentError
    end

    it "returns found reservations" do
      expect(@ressystem1.find_reservations_by_room(@room).length).must_equal 1
      expect(@ressystem1.find_reservations_by_room(@room2).length).must_equal 0
    end
  end

  describe "reserve room based on reservation request method" do
    it "validates parameters of a Reservation" do
      expect{@ressystem1.reserve_room("0")}.must_raise ArgumentError
    end

    it "confirming reservation request" do
      expect(@ressystem1.reserve_room(@reservation_request1).status).must_equal :confirmed
    end

    it "denying reservation request" do
      same_date = Date.parse("2020-01-01")
      #reserving 20 rooms since there are 20 max on the same day
      20.times do |i|
        rr = Hotel::Reservation.new(1, same_date, 1)
        expect(@ressystem1.reserve_room(rr).status).must_equal :confirmed  
      end
      #at 21st request, on same day, there are no rooms, thus denied
      rr_21 = Hotel::Reservation.new(1, same_date, 1)
      expect{@ressystem1.reserve_room(rr_21)}.must_raise Exception
      expect(@ressystem1.rooms_available(rr_21).length).must_equal 0
    end
  end

  describe "find rooms available based on reservation request method" do
    it "validates parameters of a Reservation" do
      expect{@ressystem1.rooms_available("0")}.must_raise ArgumentError
    end

    it "returns rooms available" do
     expect(@ressystem1.rooms_available(@reservation_request1).length).must_equal 20
     expect(@ressystem1.rooms_available(@reservation_request2).length).must_equal 17
    end
  end
end #class