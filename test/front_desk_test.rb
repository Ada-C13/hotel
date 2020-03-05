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

# describe "reserve a room" do
#   front_desk = Hotel::FrontDesk.new(5)
#   front_desk.reserve_room((Date.today), (Date.today + 3))
#   front_desk.reserve_room((Date.today), (Date.today + 5))


# end

describe "list available rooms" do
  let (:front_desk) {
    Hotel::FrontDesk.new(5)
  } # there are only five rooms in this hotel!
  

  it "returns an array of 5 room objects if there are no reservations in a given daterange" do
    front_desk.reserve_room(Date.new(2020,2,1), Date.new(2020,2,3), 1)
    front_desk.reserve_room(Date.new(2020,2,4),Date.new(2020,2,6), 2)
    front_desk.reserve_room(Date.new(2020,2,7), Date.new(2020,2,9), 3)
    front_desk.reserve_room(Date.new(2020,2,10), Date.new(2020,2,12), 4)
    front_desk.reserve_room(Date.new(2020,2,14), Date.new(2020,2,17), 5)

    available_rooms = front_desk.list_available_rooms(Date.new(2020,1,1), Date.new(2020,1,4))
    
    expect(available_rooms).must_be_instance_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 5
  end
  
  it "returns an array of many rooms if there are rooms with reservations in a given daterange" do
    front_desk.reserve_room(Date.new(2020,2,1), Date.new(2020,2,3), 1)
    front_desk.reserve_room(Date.new(2020,2,4),Date.new(2020,2,6), 2)
    front_desk.reserve_room(Date.new(2020,2,7), Date.new(2020,2,9), 3)
    front_desk.reserve_room(Date.new(2020,2,10), Date.new(2020,2,12), 4)
    front_desk.reserve_room(Date.new(2020,2,14), Date.new(2020,2,17), 5)

    available_rooms = front_desk.list_available_rooms(Date.new(2020,2,1), Date.new(2020,2,3))

  end
  
  it "returns an empty array if all rooms have reservations in a given daterange" do
    # if all rooms have reservations for given range of dates
    # expect empty array
  end
end


# describe "reservations on a single date" do

#   it 'returns zero reservations on dates without reservations' do
#     # if i call frontdesk.reservations_on_date and pass a single date, I expect an empty array
#   end  

#   it 'returns one reservation on dates with 1 reservation' do
#     # if i call frontdesk.reservations_on_date and pass a single date, I expect an array of 1 reservation (length = 1)
#     # I also expect that I can get the room id of that reservation (reservation.room_number, reservation.date_range)
#   end

#   it 'returns many reservations on dates with many reservations' do
#     # if i call frontdesk.reservations_on_date and pass a single date, I expect an array of multiple reservations (length equal to the number of reservations on that date)
#     # i can access the first res and last res information
#   end

# end

