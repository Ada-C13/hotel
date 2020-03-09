require_relative 'test_helper'


describe "Manages calendar and it's various duties" do
  before do 
    @reservation1 = Reservation.new("2020/05/04", "2020/05/07")
    @reservation2 = Reservation.new("2020/05/07", "2020/05/09")
    @reservation3 = Reservation.new("2020/05/06", "2020/05/11")

    @calendar = Calendar.new
    @calendar.add_to_calendar(@reservation1)
    @calendar.add_to_calendar(@reservation2)
    @calendar.add_to_calendar(@reservation3)

    
    # puts "\n"
    # puts @calendar.date_store
    # puts "\n"
    
  end

  it "gives correct cost of requested reservation" do
    reservation1 = @reservation1.details
    id = reservation1[:id]
    cost = @calendar.total_cost_reservation(id)

    expect (reservation1[:cost]).must_equal cost
  end

  it "lists all reservations for specific date" do
    reservation1 = @reservation1.details
    expected_outcome = [reservation1]
    actual_outcome = @calendar.reservations_on_date("2020/05/04")
    assert_equal(actual_outcome, expected_outcome)
  end 

  it "accesses list of available rooms on a given date" do
    expected_outcome = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    actual_outcome = @calendar.rooms_on_date("2020/05/04")
    assert_equal(actual_outcome, expected_outcome)
  end

  it "returns an array of all 1-20 rooms if there are no reservations on a given date" do
    expected_outcome = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    actual_outcome = @calendar.rooms_on_date("2020/05/02")
    assert_equal(actual_outcome, expected_outcome)
  end

  it "returns an array of the open rooms during a date range" do
    @calendar.list_available_rooms_entire_stay(@reservation2)
    expect available_rooms.must_be_instance_of Array
  end

  # it "raises NoRoomError if all rooms on a given date are booked" do
    
  #   raise NoRoomError
  # end

  it 'accesses correct reservation when searching by id' do
    reservation1 = @reservation1.details
    id = reservation1[:id]

    expected_outcome = reservation1
    actual_outcome = @calendar.find_by_id(id)
    assert_equal(actual_outcome, expected_outcome)
  end

  it 'creates a new reservation' do
    expected_outcome = Reservation.new("2020/05/04", "2020/05/07")
    actual_outcome = expected_outcome

    assert_equal(actual_outcome, expected_outcome)
  end

  it "returns true/false if given room is available on a given date" do
    yesorno = @calendar.is_available?(5, "2020/05/07")

    expect yesorno.must_equal true
  end

end
    
