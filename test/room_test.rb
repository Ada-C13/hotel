require_relative 'test_helper'

describe "initialize" do
  it "can be created" do
    expect(Hotel::Room.new(1, 200)).must_be_instance_of Hotel::Room
  end

  it "will have integers as an id and cost" do
    my_room = Hotel::Room.new(1, 200)

    expect(my_room.id).must_be_instance_of Integer
    expect(my_room.cost).must_be_instance_of Float
  end

  it "will throw an error if you give non-integer arguments" do
    expect{
      Hotel::Room.new(1, "this")
    }.must_raise ArgumentError

    expect{
      Hotel::Room.new("that", 200)
    }.must_raise ArgumentError

    expect{
      Hotel::Room.new("this", "that")
    }.must_raise ArgumentError
  end
end