require_relative "test_helper"
require 'date'

describe "Room" do
  describe "#initialize" do 
    it 'Create an instance of Room' do
      room = Hotel::Room.new(1, 200)
      room.must_be_kind_of Hotel::Room 
    end

    it 'Keeps track of room_id' do
      id = 1
      room = Hotel::Room.new(id, 200)
      room.must_respond_to :id
      room.id.must_equal id
    end

    it 'Keeps track of cost' do
      id = 1
      cost = 200
      room = Hotel::Room.new(id, cost)
      room.must_respond_to :cost
      room.cost.must_equal cost
    end
    
    it 'raise ArgumentError when id is a negative number' do
      expect{Hotel::Room.new(-2, 200)}.must_raise ArgumentError
    end
  end
end


