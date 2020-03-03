require_relative 'test_helper'

describe "ReservationManager class" do
  
  describe "Initializer" do

    before do 
      @reservation_manager = Hotel::ReservationManager.new(20)
    end

    it "is an instance of ReservationManager" do
      expect(@reservation_manager).must_be_kind_of Hotel::ReservationManager
    end

    it "initializes correct number of rooms" do
      expect(@reservation_manager.rooms.length).must_equal 20
    end

    it "populates valid room objects" do
      expect(@reservation_manager.rooms[1]).must_be_kind_of Hotel::Room
    end

    it "initializes with zero reservations" do
      expect(@reservation_manager.reservations.length).must_equal 0
    end

    it "manages a hotel with 0 rooms" do
      reservation_manager = Hotel::ReservationManager.new(0)
      expect(reservation_manager.rooms.length).must_equal 0

    end
    
  end

  describe "create reservation" do
    before do
      @date = Hotel::DateRange.new(Date.new, Date.new + 2)
      @occupancy = {:room => Hotel::Room.new(12), :guest => "Picchu"}
      @reservation = Hotel::Reservation.new("single", @date, @occupancy)
    end

    it "creates an instance of Reservation object" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

  end
end