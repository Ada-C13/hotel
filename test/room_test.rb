require_relative 'test_helper'

describe "Room Class" do
  let (:room) {
    Hotel::Room.new("5")
  }
  
  it "instantiates room objects" do 
    expect(room).must_be_instance_of Hotel::Room
    expect(room.room_number).must_equal "5"
    expect(room.room_number).must_be_kind_of String
    expect(room.reservations).must_be_kind_of Array
  end
end

describe "Room Number Validation" do
  it "raises an argument error for invalid room numbers" do
    expect{ Hotel::Room.new("0") }.must_raise ArgumentError
    expect{ Hotel::Room.new("string")}.must_raise ArgumentError
  end
end