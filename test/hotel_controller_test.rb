# needs to test the creation of the 20 rooms
# test whether the ids of the room are correct

require_relative 'test_helper'

describe Hotel::Controller do
  describe "initialize" do
    let(:hotel_controller) {Hotel::Controller.new}

    it "is an instance of HotelController" do
      expect(hotel_controller).must_be_kind_of Hotel::Controller
    end

    it "creates an Array for Rooms to be stored" do
      expect(hotel_controller.rooms).must_be_kind_of Array
    end

    it "creates Rooms" do
      hotel_controller.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "creates 20 Rooms" do
      expect(hotel_controller.rooms.length).must_equal 20
    end

    it "creates the correct ids for each room" do
      expect(hotel_controller.rooms[0].room_id).must_equal 1
      expect(hotel_controller.rooms[19].room_id).must_equal 20
      expect(hotel_controller.rooms[20]).must_be_nil
    end

  end
end