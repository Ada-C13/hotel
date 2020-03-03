require "date"
require_relative "test_helper"

describe "HotelController class" do
  before do
    @controller = Hotel::HotelController.new(rooms: (1..20).to_a, reservations: [])
    a = Date.new(2020, 2, 24)
    b = Date.new(2020, 2, 25)
    @controller.make_reservation(check_in: a, check_out: b)
    @reservations = @controller.reservations
  end

  describe "Initializer" do
    it "is an instance of HotelController" do
      expect(controller).must_be_kind_of Hotel::HotelController
    end

    it "establishes the base data structures when instantiated" do
      expect(controller.rooms).must_be_kind_of Array
      expect(controller.rooms.length).must_equal 20
      expect(controller.reservations).must_be_kind_of Array
    end
  end
  # tests for each method, with tests for ArgumentErrors/exceptions
  describe "make_reservation" do
    it "creates instance of Reservation" do
      expect(@reservations[0]).must_be_kind_of Hotel::Reservation
    end
  end
end
