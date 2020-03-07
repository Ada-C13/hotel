require_relative "test_helper"

describe "FrontDesk" do
  describe "Find existing reservation" do
    before do
      @front_desk = Hotel::FrontDesk.new

      @reservation_one = Hotel::Reservation.new(
        date_range = Hotel::DateRange.new("2020-03-15", "2020-03-17"), 
        room_num = 1
      )
      @reservation_two = Hotel::Reservation.new(
        date_range = Hotel::DateRange.new("2020-04-01", "2020-04-05"), 
        room_num = 2
      )
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
      start_date = "2020-03-16" #3/15 - 3/17
      end_date = "2020-04-01" # 4/1 - 4/5
      expect(@front_desk.check_reservations_in_date_range(start_date, end_date)).must_be_kind_of Array
      expect(@front_desk.check_reservations_in_date_range(start_date, end_date)).must_include @reservation_one  
      expect(@front_desk.check_reservations_in_date_range(start_date, end_date)).must_include @reservation_two
    end
  end

  describe "Find available room" do
    before do
      @front_desk = Hotel::FrontDesk.new
      @reservation_one = Hotel::Reservation.new(
        date_range = Hotel::DateRange.new("2020-05-01", "2020-05-03"), 
        room_num = 1
      )
      @reservation_two = Hotel::Reservation.new(
        date_range = Hotel::DateRange.new("2020-05-03", "2020-05-10"), 
        room_num = 2
      )
    end

    it "Room availability" do
      @front_desk.add_reservation(@reservation_one)
      @front_desk.add_reservation(@reservation_two)
      date_range_one = Hotel::DateRange.new("2020-05-02", "2020-05-07")
      date_range_two = Hotel::DateRange.new("2020-05-10", "2020-05-11")
      expect(@front_desk.is_room_avaiable_for_entire_date_range?(date_range_one, 1)).must_equal false
      expect(@front_desk.is_room_avaiable_for_entire_date_range?(date_range_one, 2)).must_equal false
      expect(@front_desk.is_room_avaiable_for_entire_date_range?(date_range_two, 2)).must_equal true
    end

    it "Return a list of available rooms" do
      @front_desk.add_reservation(@reservation_one)
      @front_desk.add_reservation(@reservation_two)
      start_date = "2020-05-02" 
      end_date = "2020-05-04" 
      expect(@front_desk.available_rooms(start_date, end_date)).wont_include 1
      expect(@front_desk.available_rooms(start_date, end_date)).wont_include 2
    end
  end

  describe "Make a reservation" do 
    before do
      @front_desk = Hotel::FrontDesk.new
      @reservation_one = Hotel::Reservation.new(
        date_range = Hotel::DateRange.new("2020-05-10", "2020-05-20"), 
        room_num = 1
      )
    end

    it "Shuffle a reservation to the associate room # in the @reservations hash" do
      @front_desk.add_reservation(@reservation_one)
      expect(@front_desk.reservations[1]).must_include @reservation_one
    end

    it "Return the instance of Reservation after reserve a room" do
      reservation = @front_desk.reserve_room("2020-05-01", "2020-05-03")
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Assign the first aviable room number in the array when reserve the room" do
      room_one = @front_desk.reserve_room("2020-05-01", "2020-05-03")
      room_two = @front_desk.reserve_room("2020-05-01", "2020-05-03")
      expect(room_two.room_num).must_equal 2
    end

    it "Raise exception when try to reserve a room during a date range when all rooms are reserved" do
      20.times do |time|
        @front_desk.reserve_room("2020-05-01", "2020-05-03")
      end
      expect{@front_desk.reserve_room("2020-05-01", "2020-05-03")}.must_raise StandardError
    end
  end
end