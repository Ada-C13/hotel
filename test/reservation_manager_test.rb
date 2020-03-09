require_relative 'test_helper'

describe "ReservationManager class" do
  before do 
    @reservation_manager = Hotel::ReservationManager.new(20)
  end
  
  describe "Initializer" do
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
      @room = Hotel::Room.new(100)
      @occupancy = [{:room => @room, :guest => "Picchu"}]
      @date = Hotel::DateRange.new(Date.new, Date.new + 2)
      @reservation = @reservation_manager.create_reservation(:SINGLE, @date, @occupancy)
    end

    it "creates an instance of Reservation object" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "creates valid objects inside of a Reservation" do
      expect(@reservation.occupancy).must_be_kind_of Array
    end

  end

  describe "find_reservations_by_date" do
    before do
      date = Hotel::DateRange.new(Date.new, Date.new + 2)
      @reservation_manager.create_reservation(:SINGLE, date, [{:room => Hotel::Room.new(100), :guest => "Elvy"}])
      @reservation_manager.create_reservation(:SINGLE, date, [{:room => Hotel::Room.new(200), :guest => "Picchu"}] )
    end

    it "has accurate number of reservations" do
      expect(@reservation_manager.reservations.length).must_equal 2
    end

    it "finds all reservations for a date" do
      results = @reservation_manager.find_reservations_by_date(Date.new, Date.new + 3)
      expect(results).must_be_kind_of Array
      expect(results.length).must_equal 2
      expect(results[0]).must_be_kind_of Hotel::Reservation
      expect(results[0].occupancy).must_be_kind_of Array
      expect(results[0].occupancy[0]).must_be_kind_of Hash
      expect(results[0].occupancy[0][:room]).must_be_kind_of Hotel::Room
      expect(results[0].occupancy[0][:room].id).must_equal "100"
      expect(results[0].occupancy[0][:guest]).must_equal "Elvy"

    end
  end

  describe "find_by_room" do
    before do
      @room = Hotel::Room.new(100)
      @reservation_manager.create_reservation(
        :SINGLE, 
        Hotel::DateRange.new(Date.new + 5, Date.new + 10), 
        [{:room => @room, :guest => "Picchu"}]
      )
      @reservation_manager.create_reservation(
        :SINGLE, 
        Hotel::DateRange.new(Date.new + 11, Date.new + 15), 
        [{:room => @room, :guest => "Elvy"}]
      )
      @reservation_manager.create_reservation(
        :SINGLE, 
        Hotel::DateRange.new(Date.new + 16, Date.new + 18), 
        [{:room => @room, :guest => "Tater Tot"}]
      )
      @reservation_manager.create_reservation(
        :BLOCK, 
        Hotel::DateRange.new(Date.new + 19, Date.new + 23), 
        [{:room => Hotel::Room.new(300), :guest => "Peaches"},{:room => @room, :guest => "Tater Tot"},{:room => Hotel::Room.new(200), :guest => "Finn"}]
      )
    end

    it "finds all reservations for a given room" do
      results = @reservation_manager.find_reservations_by_room(@room)
      expect(results).must_be_kind_of Array
      expect(results.length).must_equal 4
      expect(results.all? {|result| result.class == Hotel::Reservation}).must_equal true
    end
  end

  describe "list_all_available" do
    before do
      date = Hotel::DateRange.new(Date.new, Date.new + 2)
      @reservation_manager.create_reservation(:SINGLE, date, [{:room => @reservation_manager.rooms[0], :guest => "Elvy"}])
      @reservation_manager.create_reservation(:SINGLE, date, [{:room => @reservation_manager.rooms[1], :guest => "Picchu"}] )
      @reservation_manager.create_reservation(:SINGLE, date, [{:room => @reservation_manager.rooms[2], :guest => "Brom"}] )
    end

    it "returns list of available rooms for a given date range" do
      results = @reservation_manager.list_all_available(Date.new, Date.new + 2)
      expect(results.length).must_equal 17
    end

  end
end
