require_relative "test_helper"

describe "HotelManager" do
  before do
    @hotel_manager = Hotel::HotelManager.new
  end

  describe "initialize" do
    it "creates an instance of HotelManager" do
      expect(@hotel_manager).must_be_kind_of Hotel::HotelManager
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

    it "returns nil if there are no rooms" do
      @hotel_manager.rooms.empty?()
      rooms = @hotel_manager.list_rooms

      expect(rooms).must_be_nil
    end
  end
end