require_relative "test_helper"

describe "HotelManager" do
  before do
    @hotel_manager = Hotel::HotelManager.new
  end

  describe "initialize" do
    it "creates an instance of HotelManager" do
      expect(@hotel_manager).must_be_kind_of Hotel::HotelManager
      expect(@hotel_manager).must_respond_to :rooms
      expect(@hotel_manager).must_respond_to :total_reservations
    end
  end

  describe "list_rooms" do
    it "returns an array" do
      @hotel_manager.rooms.push("this is a room")
      rooms = @hotel_manager.list_rooms

      expect(rooms).must_be_kind_of Array
    end

    it "contains Room objects within the array" do
      #TODO after Room class has been created
    end

    it "returns empty array if there are no rooms" do
      @hotel_manager.rooms.empty?()
      rooms = @hotel_manager.list_rooms

      expect(rooms).must_equal []
    end
  end

  describe "reserve_room" do
    it "creates a Reservation instance" do
      daterange = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
      reservation = @hotel_manager.reserve_room(daterange)

      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "adds 1 to total_reservations" do
      current_reservations = @hotel_manager.total_reservations

      daterange = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
      reservation = @hotel_manager.reserve_room(daterange)

      expect(@hotel_manager.total_reservations).must_equal current_reservations + 1
    end

    it "raises ArgumentError if invalid date is provided" do
      expect{(
        @hotel_manager.reserve_room(
          Hotel::DateRange.new(
            Date.new(2020,5,10), Date.new(2020,5,9)
          )
        )
      )}.must_raise ArgumentError 
    end

  end
end