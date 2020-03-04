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
  
  it "returns correct number of rooms for one room" do
    front_desk = Hotel::FrontDesk.new(1)
    expect(front_desk.rooms.length).must_equal 1
  end
    
end

describe "valid_number_of_rooms" do
  
  it "raises an argument error for room values less than 0" do
    expect{ Hotel::FrontDesk.new(-5) }.must_raise ArgumentError
  end
  
end

describe "initialize builds a collection of rooms" do
  let (:front_desk) { 
    Hotel::FrontDesk.new(5)
  }
  
  it "builds a room object" do
    expect(front_desk.rooms[0]).must_be_instance_of Hotel::Room
  end
  
  it "builds correct number of room objects" do
    expect(front_desk.rooms.length).must_equal 5
  end
  
  it "stores room number as a string" do
    expect(front_desk.rooms[1].room_number).must_equal "2"
  end
  
end

describe "given room number, return room object" do
  let (:front_desk) { 
    Hotel::FrontDesk.new(5)
  }
  
  it "finds the correct room object" do 
    expect(front_desk.find_room_by_number("4")).must_be_instance_of Hotel::Room 
    expect(front_desk.find_room_by_number("4").room_number).must_equal "4"
  end
end

describe "reserve a room" do
  front_desk = Hotel::FrontDesk.new(5)
  front_desk.reserve_room(("2020-02-03"), ("2020-02-04"))
  front_desk.reserve_room(("2020-02-03"), ("2020-02-04"))

end

# this is not done at all
# describe "available rooms by date_range" do
#   let (:front_desk) {
#     Hotel::FrontDesk.new(5)
#   }
#   reserve_room(Hotel::DateRange.new(("2020-03-03"),("2020-03-06")))
#   reserve_room(Hotel::DateRange.new(("2020-04-03"),("2020-04-07")))
#   reserve_room(Hotel::DateRange.new(("2020-05-07"),("2020-05-12")))
  
  
#   it "returns an array of room objects" do
    
#   end
  
#   it "returns available rooms" do
    
#   end
  
#   it "does not return unavailable rooms" do
    
#   end
  
#   it "returns nil in the case there are no rooms available for that date_range" do
    
#   end
  
# end



