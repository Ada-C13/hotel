require_relative "test_helper"
require 'hotel_dispatcher'

describe "HotelDispatcher class" do
  def build_test_dispatcher
    HotelDispatcher.new
  end

  describe "Initializer" do
    it "is an instance of HotelDispatcher" do
      dispatcher = build_test_dispatcher
      expect(dispatcher).must_be_kind_of HotelDispatcher
    end
  end
  describe "Instance of Hotel Dispatcher" do
    it "can makes all rooms" do
      hotel_dispatcher = build_test_dispatcher
      room_array = hotel_dispatcher.make_rooms
      expect(room_array.length).must_equal 20
    end
  end
  describe "Checks room for availablility" do
    it "takes in the start and end date" do
      hotel_dispatcher = build_test_dispatcher
      room_check = hotel_dispatcher.check_room_available?("3rd Feb 2001", "5 Feb 2001")
      expect(room_check).must_be_kind_of Date
    end
  end
end
