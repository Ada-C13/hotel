require_relative 'test_helper'

describe "Room Class" do
  let (:room) {
    Hotel::Room.new("5")
  }
  
  it "instantiates room objects" do 
    expect(room).must_be_instance_of Hotel::Room
    expect(room.room_number).must_equal "5"
    expect(room.reservations).must_be_kind_of Array
    expect(room.cost).must_equal 200
  end
end