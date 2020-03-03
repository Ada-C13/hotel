require "date"
require_relative "test_helper"

describe "HotelController class" do
  controller = Hotel::HotelController.new(rooms: (1..20).to_a, reservations: [])
  describe "Initializer" do
    it "is an instance of HotelController" do
      expect(controller).must_be_kind_of Hotel::HotelController
    end

    it "establishes the base data structures when instantiated" do
      #   [:trips, :passengers].each do |prop|
      #     expect(controller).must_respond_to prop
      #   end
      expect(controller.rooms).must_be_kind_of Array
      expect(controller.rooms.length).must_equal 20
      expect(controller.reservations).must_be_kind_of Array
    end
  end
  # tests for each method, with tests for ArgumentErrors/exceptions
end
