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

  describe "initialize_rooms" do
    before do
      @hotel_manager.initialize_rooms(20)
    end

    it "creates an array" do
      expect(@hotel_manager.rooms).must_be_kind_of Array
      expect(@hotel_manager.rooms.length).must_equal 20
    end

    it "should contain Room objects" do
      @hotel_manager.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "raises ArgumentError if non-integer is provided" do
      expect{@hotel_manager.initialize_rooms("twenty")}.must_raise ArgumentError
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
      @hotel_manager.rooms.clear()
      rooms = @hotel_manager.list_rooms

      expect(rooms).must_equal []
    end
  end

  describe "reserve_room" do
    let(:reservation) {
      daterange = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
      reservation = @hotel_manager.reserve_room(daterange)
    }

    it "creates a Reservation instance" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "adds 1 to total_reservations" do
      current_reservations = @hotel_manager.total_reservations
      reservation

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