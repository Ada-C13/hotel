require "date"
require_relative "test_helper"

describe "HotelController class" do
  before do
    @controller = Hotel::HotelController.new(rooms: (1..20).to_a, reservations: [])
    @a = Date.new(2020, 2, 24)
    @b = Date.new(2020, 2, 25)
    @controller.make_reservation(@a, @b)
    @reservations = @controller.reservations
    @controller.make_block(@a, @b, [3, 4, 5], 180)
    @blocks = @controller.blocks
    @list_available_rooms = @controller.find_available_rooms(@a, @b)
    @all_rooms = @controller.show_all_rooms
    @res = @reservations[0]
    @blocks[0].reserve_room(3)
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

  describe "make_reservation" do
    it "creates instance of Reservation" do
      expect(@reservations[0]).must_be_kind_of Hotel::Reservation
    end
  end

  describe "make_block" do
    it "creates instance of Block" do
      expect(@blocks[0]).must_be_kind_of Hotel::Block
    end
  end

  describe "find_available_rooms" do
    it "returns array of available rooms" do
      expect(@list_available_rooms).must_be_kind_of Array
      expect(@list_available_rooms.length).must_equal 16
    end
    it "excludes rooms in block" do
      expect(@list_available_rooms.include?(3)).must_equal false
    end
    it "Raises exception if there are no available rooms" do
      @controller2 = Hotel::HotelController.new(rooms: [1], reservations: [])
      @controller2.make_reservation(@a, @b)
      expect { @controller2.make_reservation(@a, @b) }.must_raise StandardError
    end
  end
  describe "find_by_date" do
    it "returns array of reservations for that date, including reservations from block" do
      expect(@controller.find_by_date(@a)).must_be_kind_of Array
      expect(@controller.find_by_date(@a).length).must_equal 2
    end
  end

  describe "find_by_date_and_room(room, date)" do
    it "returns array of reservations for that date and room" do
      expect(@controller.find_by_date_and_room(1, @a)).must_be_kind_of Array
      expect(@controller.find_by_date_and_room(1, @a).length).must_equal 1
    end
  end

  describe "show_all_rooms" do
    it "returns array of all rooms" do
      expect(@all_rooms).must_be_kind_of Array
      expect(@all_rooms.length).must_equal 20
    end
  end

  describe "show_reservation_cost" do
    it "returns correct number" do
      expect(@controller.show_reservation_cost(@res)).must_equal 200
    end
  end
end

# The final project submission should have 95% code coverage using simplecov
