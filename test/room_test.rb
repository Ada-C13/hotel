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

# describe "Add to Reservation Collection" do
# before do
#   @room = Hotel::Room.new("3")
# end

#   it "adds reservation object to the collection of reservations" do
#     range = Hotel::DateRange.new(Date.new(2020,3,3), Date.new(2020,3,6))
#     reservation = Hotel::Reservation.new(range)
#     add_to = @room.add_to_reservation_collection(reservation)

#     expect(@room.reservations.last).must_equal reservation
#     expect(@room.reservations.last.room_number).must_equal "3"
#   end
# end