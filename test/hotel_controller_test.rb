require "date"
require_relative "test_helper"

describe "HotelController class" do
  before do
    @controller = Hotel::HotelController.new(rooms: (1..20).to_a, reservations: [])
    a = Date.new(2020, 2, 24)
    b = Date.new(2020, 2, 25)
    @controller.make_reservation(a, b)
    @reservations = @controller.reservations
    @list_available_rooms = @controller.find_available_rooms(Date.new(2020, 2, 24), Date.new(2020, 2, 25))
    @all_rooms = @controller.show_all_rooms
  end

  describe "Initializer" do
    it "is an instance of HotelController" do
      expect(@controller).must_be_kind_of Hotel::HotelController
    end

    it "establishes the base data structures when instantiated" do
      expect(@controller.rooms).must_be_kind_of Array
      expect(@controller.rooms.length).must_equal 20
      expect(@controller.reservations).must_be_kind_of Array
    end
  end
  # tests for each method, with tests for ArgumentErrors/exceptions
  describe "make_reservation" do
    it "creates instance of Reservation" do
      expect(@reservations[0]).must_be_kind_of Hotel::Reservation
    end
  end
  describe "find_available_rooms" do
    it "returns array of available rooms" do
      expect(@list_available_rooms).must_be_kind_of Array
      expect(@list_available_rooms.length).must_equal 20 # change
    end
  end
  describe "show_all_rooms" do
    it "returns array of all rooms" do
      expect(@all_rooms).must_be_kind_of Array
      expect(@all_rooms.length).must_equal 20
    end
  end
  # tests for find_by_date method(s)
end

# The final project submission should have 95% code coverage using simplecov
