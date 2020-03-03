require_relative 'test_helper'

describe "FrontDesk Class" do
  let (:front_desk) {
    Hotel::FrontDesk.new(20)
  }
  it "instantiates an instance of a frontdesk" do
    expect(front_desk).must_be_instance_of Hotel::FrontDesk
  end
  
  it "returns an array of rooms" do
    expect(front_desk.rooms).must_be_kind_of Array 
  end
  
  it "correctly states how many rooms there are" do
    expect(front_desk.num_rooms).must_equal 20
  end
  
  it "returns correct number of rooms for zero" do
    front_desk = Hotel::FrontDesk.new(0)
    expect(front_desk.rooms).must_be_empty
  end
  
  it "returns correct number of rooms for one" do
    front_desk = Hotel::FrontDesk.new(1)
    expect(front_desk.rooms.length).must_equal 1
  end
  
  it "returns an array of reservations" do
    expect(front_desk.reservations).must_be_kind_of Array
  end
   
end


describe "build rooms" do
  let (:front_desk) { 
    Hotel::FrontDesk.new(5)
  }
  
  it "builds a room object" do
    expect(front_desk.rooms[0]).must_be_instance_of Hotel::Room
  end
  
  it "builds correct number of rooms" do
    expect(front_desk.rooms.length).must_equal 5
  end

end





