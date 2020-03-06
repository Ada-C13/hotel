require_relative "test_helper"

describe "FrontDesk" do
  before do
    @front_desk = Hotel::FrontDesk.new

    @reservation_one = Hotel::Reservation.new(
      id = 1, 
      date_range = Hotel::DateRange.new("2020-03-15", "2020-03-17"), 
      room_num = 1
    )
    @reservation_two = Hotel::Reservation.new(
      id = 2, 
      date_range = Hotel::DateRange.new("2020-04-01", "2020-04-05"), 
      room_num = 2
    )

  end
  
  it "Reserve a room" do
    expect(@reservation_one).must_be_kind_of Hotel::Reservation
  end

  # it "add reservation to the hash after reserved a room" do
  #   expect(@front_desk.reservations).wont_include @reservation
  #     previous = @front_desk.reservations.length

  #     @front_desk.add_reservation(@reservation)

  #     expect(@front_desk.reservations).must_include @reservation
  #     expect(@front_desk.reservations.length).must_equal previous + 1
  # end

  it "Add a reservation to the associate room in the @reservations hash" do
    @front_desk.add_reservation(@reservation_one)
    expect(@front_desk.add_reservation(@reservation_one)).must_include @reservation_one
  end

  it "Find the reservation using a date (return the associate reservations)" do
    @front_desk.add_reservation(@reservation_one)
    @front_desk.add_reservation(@reservation_two)
    date = "2020-04-01"
    expect(@front_desk.check_reservations_on_date(date)).must_be_kind_of Array
    expect(@front_desk.check_reservations_on_date(date)).must_include @reservation_two
  end

  it "Find the reservation using a date (none reservation on that day)" do
    @front_desk.add_reservation(@reservation_one)
    date = "2020-3-20"
    expect(@front_desk.check_reservations_on_date(date)).must_be_kind_of Array
    expect(@front_desk.check_reservations_on_date(date)).wont_include @reservation_one
  end

  it "Find reservations using date range" do
    @front_desk.add_reservation(@reservation_one)
    @front_desk.add_reservation(@reservation_two)
    start_date = "2020-03-16"
    end_date = "2020-04-01"
    p "============"
    p @front_desk.check_reservations_in_date_range(start_date, end_date)
    expect(@front_desk.check_reservations_in_date_range(start_date, end_date)).must_be_kind_of Array
    expect(@front_desk.check_reservations_in_date_range(start_date, end_date)).must_include @reservation_one  
    expect(@front_desk.check_reservations_in_date_range(start_date, end_date)).must_include @reservation_two  
  end
end