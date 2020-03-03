require 'test_helper'

describe "Receptionist class" do

  describe "Initializer" do
    it "is an instance of room" do
      room = Hotel::Room.new(id: 34, status: false, reservations: [])
        expect(room).must_be_kind_of Hotel::Room
    end

    it "can return a list of rooms" do
        rooms = Hotel::Room.list_of_rooms
        p rooms
        expect(rooms[0].id).must_equal 1
        expect(rooms[0].status).must_equal true
        expect(rooms[0].reservations).must_be_kind_of Array
    end
  end  
end