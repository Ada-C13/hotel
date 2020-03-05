require_relative "test_helper"

describe "FrontDesk" do
  before do
    @front_desk = Hotel::FrontDesk.new

    id = 1
    date_range = Hotel::DateRange.new("2020-3-15", "2020-3-17")
    room_num = 1
    @reservation = Hotel::Reservation.new(
      id = id, 
      date_range = date_range, 
      room_num = room_num
    )
  end
  
  it "reserve a room" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
  end

  it "add reservation to the array after reserved a room" do
    expect(@front_desk.reservations).wont_include @reservation
      previous = @front_desk.reservations.length

      @front_desk.add_reservation(@reservation)

      expect(@front_desk.reservations).must_include @reservation
      expect(@front_desk.reservations.length).must_equal previous + 1
  end

  it "using date to find the reservation (return the associate reservations)" do
    @front_desk.add_reservation(@reservation)
    date = "2020-3-16"
    expect(@front_desk.check_reservations(date)).must_be_kind_of Array
    expect(@front_desk.check_reservations(date)).must_include @reservation
  end

  it "using date to find the reservation (none reservation on that day)" do
    @front_desk.add_reservation(@reservation)
    date = "2020-3-20"
    expect(@front_desk.check_reservations(date)).must_be_kind_of Array
    expect(@front_desk.check_reservations(date)).wont_include @reservation
  end
end