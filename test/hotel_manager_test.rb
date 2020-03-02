require_relative "test_helper"

describe "HotelManager" do
  before do
    @hotel_manager = Hotel::HotelManager.new
  end

  describe "initialize" do
    it "creates an instance of HotelManager" do
      expect(@hotel_manager).must_be_kind_of Hotel::HotelManager
      expect(@hotel_manager).must_respond_to :rooms
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

  # describe "reserve_room" do
  #   it "creates a Reservation instance" do
  #     #TODO after Reservation class has been created
  #   end

  #   it ""
  # end
end