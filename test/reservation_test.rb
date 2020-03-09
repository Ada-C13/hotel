require_relative 'test_helper'

describe "initialize" do
  before do
    check_in_time = Date.new(2020, 1, 28)
    check_out_time = Date.new(2020, 1, 30)
    room = Hotel::Room.new(1, 200)
    @reservation = Hotel::Reservation.new(check_in_time, check_out_time, room)
  end

  it "can be called" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end
  
  it "will have the appropriate readable attributes" do
    expect(@reservation).must_respond_to :id
    expect(@reservation.id.to_s).must_match /\d{6}/
    expect{@reservation.id = 5}.must_raise NoMethodError

    expect(@reservation).must_respond_to :room
    expect(@reservation.room).must_be_instance_of Hotel::Room
    expect(@reservation.room.id).must_equal 1
    expect{@reservation.room.id = 5}.must_raise NoMethodError

    expect(@reservation).must_respond_to :dates
    expect(@reservation.dates).must_be_instance_of Hotel::DateRange
    expect(@reservation.dates.check_in_time.mday).must_equal 28
    expect{@reservation.dates.check_in_time = 42}.must_raise NoMethodError
  end
end

describe "cost method" do
  before do
    check_in_time = Date.new(2020, 1, 28)
    check_out_time = Date.new(2020, 1, 30)
    room = Hotel::Room.new(1, 200)
    @reservation = Hotel::Reservation.new(check_in_time, check_out_time, room)
  end

  it "can calculate correct cost" do
    expect(@reservation.cost).must_be_instance_of Float
    expect(@reservation.cost).must_be_close_to 400
  end
end