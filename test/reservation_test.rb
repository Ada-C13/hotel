require_relative 'test_helper'

describe "initialize" do
  before do
    @reservation = Hotel::Reservation.new([2020, 1, 28], [2020, 1, 30], 1)
  end

  it "can be called" do
    expect(@reservation).must_be_instance_of Hotel::Reservation
  end
  
  it "will have the appropriate readable attributes" do
    expect(@reservation).must_respond_to :id
    expect(@reservation).must_respond_to :room_id
    expect(@reservation).must_respond_to :date_range
  end

  it "will have a unique reservation id" do
    
  end

  it "will find a room that didn't have a reservation on it previously" do

  end

  it "will have a DateRange object" do
    expect(@reservation.date_range).must_be_instance_of Hotel::DateRange
  end
end