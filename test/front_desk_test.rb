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

describe "list reservations by room number" do
  before do 
    @front_desk = Hotel::FrontDesk.new(5)
    @front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,4))
    @front_desk.create_reservation(Date.new(2020,2,2),Date.new(2020,2,6))
    @front_desk.create_reservation(Date.new(2020,2,7), Date.new(2020,2,9))
    
    @front_desk.create_reservation(Date.new(2020,2,14), Date.new(2020,2,17))
  end
  
  it "returns an array of many reservations" do
    expect(@front_desk.find_reservations_by_room("1").length).must_equal 3
  end
  
  it "returns an array of 1 reservation" do
    expect(@front_desk.find_reservations_by_room("2").length).must_equal 1
  end
  
  it "returns nil if there are no reservations" do
    expect(@front_desk.find_reservations_by_room("3")).must_be_nil
  end
  
end 


describe "list all available rooms" do
  let (:front_desk) {
    Hotel::FrontDesk.new(5)
  }
  
  it "returns an array of all room objects if there are no reservations in a given daterange" do
    front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
    front_desk.create_reservation(Date.new(2020,2,4),Date.new(2020,2,6))
    front_desk.create_reservation(Date.new(2020,2,7), Date.new(2020,2,9))
    front_desk.create_reservation(Date.new(2020,2,10), Date.new(2020,2,12))
    front_desk.create_reservation(Date.new(2020,2,14), Date.new(2020,2,17))
    
    available_rooms = front_desk.list_available_rooms(Date.new(2020,1,1), Date.new(2020,1,4))
    
    expect(available_rooms).must_be_kind_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 5
  end
  
  it "returns an array with correct number of rooms if there are rooms with reservations in a given daterange" do
    front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
    front_desk.create_reservation(Date.new(2020,2,4),Date.new(2020,2,6))
    front_desk.create_reservation(Date.new(2020,2,7), Date.new(2020,2,9))
    front_desk.create_reservation(Date.new(2020,2,10), Date.new(2020,2,12))
    front_desk.create_reservation(Date.new(2020,2,14), Date.new(2020,2,17))
    
    available_rooms = front_desk.list_available_rooms(Date.new(2020,2,1), Date.new(2020,2,3))
    
    expect(available_rooms).must_be_kind_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 4
    expect(available_rooms[0].room_number).must_equal "2"
  end
  
  it "returns an empty array if all rooms have reservations in a given daterange" do
    front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,5))
    front_desk.create_reservation(Date.new(2020,2,2),Date.new(2020,2,6))
    front_desk.create_reservation(Date.new(2020,2,2), Date.new(2020,2,9))
    front_desk.create_reservation(Date.new(2020,1,30), Date.new(2020,2,6))
    front_desk.create_reservation(Date.new(2020,2,3), Date.new(2020,2,5))
    
    available_rooms = front_desk.list_available_rooms(Date.new(2020,2,1), Date.new(2020,2,4))
    
    expect(available_rooms).must_be_kind_of Array
    expect(available_rooms).must_be_empty
  end
end

describe "find single available room" do
  let (:front_desk) {
    Hotel::FrontDesk.new(5)
  }
  
  it 'returns a single room object' do
    room = front_desk.find_available_room(Date.new(2020,2,6),Date.new(2020,2,8))
    
    expect(room).must_be_instance_of Hotel::Room
    expect(room.room_number).must_equal "1"
  end
  
  it 'raises an argument error if no rooms are available on that date' do
    5.times do
      front_desk.create_reservation(Date.new(2020,2,6),Date.new(2020,2,8))
    end
    
    expect { front_desk.find_available_room(Date.new(2020,2,6),Date.new(2020,2,8)) }.must_raise NoAvailableRoomsError
  end
  
end

describe "create reservation" do
  let (:front_desk) {
    Hotel::FrontDesk.new(5)
  }
  
  it 'instantiates a reservation object' do
    reservation = front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
    
    
    expect(reservation).must_be_instance_of Hotel::Reservation
    expect(reservation.room_number).must_equal "1"
  end  
  
  it 'assigns room numbers correctly for overlapping reservations' do
    reservation = front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
    reservation = front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
    
    expect(reservation.room_number).must_equal "2"
  end
  
  # it 'raises an argument error if reservation attempts to book over existing reservation' do
  #   front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
  #   front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
  #   front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
  #   front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
  #   front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
  
  #   reservation = front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))
  
  #   expect(reservation).must_raise ArgumentError
  # end 
end

describe "list reservations on a single date" do
  before do 
    @front_desk = Hotel::FrontDesk.new(5)
    @front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,4))
    @front_desk.create_reservation(Date.new(2020,2,2),Date.new(2020,2,6))
    @front_desk.create_reservation(Date.new(2020,2,7), Date.new(2020,2,9))
    @front_desk.create_reservation(Date.new(2020,2,8), Date.new(2020,2,12))
    @front_desk.create_reservation(Date.new(2020,2,14), Date.new(2020,2,17))
  end
  
  
  it 'returns empty array on dates without reservations' do
    expect(@front_desk.reservations_by_date(Date.new(2020,2,18))).must_be_kind_of Array
    expect(@front_desk.reservations_by_date(Date.new(2020,2,18))).must_be_empty
  end  
  
  it 'returns one reservation on dates with 1 reservation' do
    expect(@front_desk.reservations_by_date(Date.new(2020,2,16)).length).must_equal 1
    # expect(@front_desk.reservations_by_date(Date.new(2020,2,16))[0].room_number).must_equal "2"
  end
  
  it 'returns correct number of reservations on dates with many reservations' do
    expect(@front_desk.reservations_by_date(Date.new(2020,2,3)).length).must_equal 2
    
  end
  
end

