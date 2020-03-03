require_relative 'test_helper'

describe 'initialize' do
  before do
    @reception = Hotel::HotelReception.new
  end

  it "can be instantiated" do
    expect(@reception).must_be_instance_of Hotel::HotelReception
    expect(@reception).must_respond_to :rooms
    expect(@reception).must_respond_to :reservations
  end

  it "has an array of rooms as an attribute" do
    expect(@reception.rooms).must_be_instance_of Array
    expect(@reception.rooms).wont_be_empty
    expect(@reception.rooms.length).must_equal 20
  end

  it "has an empty array of reservation objects as an attribute" do
    expect(@reception.reservations).must_be_instance_of Array
    expect(@reception.reservations).must_be_empty
  end
end

describe "make reservation method" do
  before do
    @reception = Hotel::HotelReception.new
  end

  it "edits the hotel reception reservations array" do
    check_in_time = [2020, 2, 1]
    check_out_time = [2020, 2, 3]
    @reception.make_reservation(check_in_time, check_out_time)

    check_in_time = [2020, 2, 14]
    check_out_time = [2020, 2, 15]
    @reception.make_reservation(check_in_time, check_out_time)

    expect(@reception.reservations).wont_be_empty
    expect(@reception.reservations.length).must_equal 2
    expect(@reception.reservations[0]).must_be_instance_of Hotel::Reservation
  end

  it "will reserve the first room available" do
    check_in_time = [2020, 2, 1]
    check_out_time = [2020, 2, 3]
    my_reservation = Hotel::Reservation.new(check_in_time, check_out_time, 1)
    @reception.make_reservation(check_in_time, check_out_time)

    expect(@reception.reservations[0].room_id).must_equal my_reservation.room_id
  end
end

describe "find available room" do
  before do
    @reception = Hotel::HotelReception.new

    check_in_time = [2020, 2, 1]
    check_out_time = [2020, 2, 3]
    @reception.make_reservation(check_in_time, check_out_time)

    check_in_time = [2020, 2, 14]
    check_out_time = [2020, 2, 15]
    @reception.make_reservation(check_in_time, check_out_time)
  end

  it "will list an array of the available rooms for a given date" do
    check_in_time = [2020, 2, 1]
    check_out_time = [2020, 2, 2]
    my_rooms = @reception.available_rooms(check_in_time, check_out_time)

    expect(my_rooms).must_be_instance_of Array
    expect(my_rooms).wont_include 1
    expect(my_rooms[0]).must_equal 2
  end

end

describe "find reservation method" do
  before do
    @reception = Hotel::HotelReception.new

    check_in_time = [2020, 2, 1]
    check_out_time = [2020, 2, 3]
    @reception.make_reservation(check_in_time, check_out_time)

    check_in_time = [2020, 2, 14]
    check_out_time = [2020, 2, 15]
    @reception.make_reservation(check_in_time, check_out_time)
  end

  it "will return the reservation with the id given" do
    my_reservation_id = @reception.reservations[1].id
    my_reservation = @reception.find_reservation(my_reservation_id)

    expect(my_reservation).must_be_instance_of Hotel::Reservation
    expect(my_reservation.room_id).must_equal 2
  end
end

describe "" do
  before do
    @reception = Hotel::Reception.new
  end

end

describe "" do
  before do
    @reception = Hotel::Reception.new
  end

end