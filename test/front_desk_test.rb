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

describe "create reservation" do
  let (:front_desk) {
    Hotel::FrontDesk.new(5)
  }

  it 'instantiates a reservation object' do
    
    reservation = front_desk.create_reservation(Date.new(2020,2,1), Date.new(2020,2,3))

    expect(reservation).must_be_instance_of Hotel::Reservation
    # expect(reservation.room_number).must_equal 1
  end
end

describe "list available rooms" do
  let (:front_desk) {
    Hotel::FrontDesk.new(5)
  } # there are only five rooms in this hotel!
  
  it "returns an array of 5 room objects if there are no reservations in a given daterange" do
    date_range1 = Hotel::DateRange.new(Date.new(2020,2,1), Date.new(2020,2,3))
    date_range2 = Hotel::DateRange.new(Date.new(2020,2,4),Date.new(2020,2,6))
    date_range3 = Hotel::DateRange.new(Date.new(2020,2,7), Date.new(2020,2,9))
    date_range4 = Hotel::DateRange.new(Date.new(2020,2,10), Date.new(2020,2,12))
    date_range5 = Hotel::DateRange.new(Date.new(2020,2,14), Date.new(2020,2,17))

    res1 = Hotel::Reservation.new(date_range1)
    res2 = Hotel::Reservation.new(date_range2)
    res3 = Hotel::Reservation.new(date_range3)
    res4 = Hotel::Reservation.new(date_range4)
    res5 = Hotel::Reservation.new(date_range5)

    available_rooms = front_desk.list_available_rooms(Date.new(2020,1,1), Date.new(2020,1,4))
    
    expect(available_rooms).must_be_kind_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 5
  end
  
  it "returns an array of many rooms if there are rooms with reservations in a given daterange" do
    date_range1 = Hotel::DateRange.new(Date.new(2020,2,1), Date.new(2020,2,3))
    date_range2 = Hotel::DateRange.new(Date.new(2020,2,4),Date.new(2020,2,6))
    date_range3 = Hotel::DateRange.new(Date.new(2020,2,7), Date.new(2020,2,9))
    date_range4 = Hotel::DateRange.new(Date.new(2020,2,10), Date.new(2020,2,12))
    date_range5 = Hotel::DateRange.new(Date.new(2020,2,14), Date.new(2020,2,17))

    res1 = Hotel::Reservation.new(date_range1)
    res2 = Hotel::Reservation.new(date_range2)
    res3 = Hotel::Reservation.new(date_range3)
    res4 = Hotel::Reservation.new(date_range4)
    res5 = Hotel::Reservation.new(date_range5)

    available_rooms = front_desk.list_available_rooms(Date.new(2020,2,1), Date.new(2020,2,3))

    expect(available_rooms).must_be_kind_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 4
    expect(available_rooms[0].room_number).must_equal 3
  end
  
  it "returns an empty array if all rooms have reservations in a given daterange" do
    date_range1 = Hotel::DateRange.new(Date.new(2020,2,1), Date.new(2020,2,5))
    date_range2 = Hotel::DateRange.new(Date.new(2020,2,2),Date.new(2020,2,6))
    date_range3 = Hotel::DateRange.new(Date.new(2020,2,2), Date.new(2020,2,9))
    date_range4 = Hotel::DateRange.new(Date.new(2020,1,30), Date.new(2020,2,6))
    date_range5 = Hotel::DateRange.new(Date.new(2020,2,3), Date.new(2020,2,5))

    res1 = Hotel::Reservation.new(date_range1)
    res2 = Hotel::Reservation.new(date_range2)
    res3 = Hotel::Reservation.new(date_range3)
    res4 = Hotel::Reservation.new(date_range4)
    res5 = Hotel::Reservation.new(date_range5)

    # if all rooms have reservations for given range of dates
    # expect empty array
    available_rooms = front_desk.list_available_rooms(Date.new(2020,2,1), Date.new(2020,2,4))

    expect(available_rooms).must_be_kind_of Array
    expect(available_rooms).must_be_empty
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

