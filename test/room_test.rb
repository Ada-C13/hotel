require_relative "test_helper"

describe "Room" do
  describe "Initialize" do
    it "Create instance of Room" do
      room = Hotel::Room.new(1)
      expect(room).must_be_kind_of Hotel::Room
    end 

    it "Room id tracker" do
      room = Hotel::Room.new(1)
      expect(room).must_respond_to :id
    end

    it "Rooms numbers 1 - 20 only" do
      expect(Hotel::Room.new(1).id).must_equal 1
      expect(Hotel::Room.new(20).id).must_equal 20
    end

    it "Raises an ArgumentError if id is outside of 1 - 20" do
      expect{Hotel::Room.new(0)}.must_raise ArgumentError
      expect{Hotel::Room.new(21)}.must_raise ArgumentError
    end

    it "Same nightly cost for all" do
      room = Hotel::Room.new(1)
      expect(room.nightly_rate).must_equal 200
    end

    it "Reservations is an empty array" do
      room = Hotel::Room.new(1)
      expect(room.reservations).must_be_kind_of Array
      expect(room.reservations).must_equal []
    end   
  end
  describe "self.all" do
    it "Returns an array of 20 room objects" do
      all_rooms = Hotel::Room.all
      expect(all_rooms).must_be_kind_of Array
      expect(all_rooms.length).must_equal 20

      all_rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end

      expect(all_rooms.first.id).must_equal 1
      expect(all_rooms.last.id).must_equal 20      
    end
  end
end