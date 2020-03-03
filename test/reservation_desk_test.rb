require_relative "test_helper"

describe "ReservationDesk class" do
  before do
    @reservation_desk = Hotel::ReservationDesk.new()
    #@reservation = Hotel::Reservation.new("2020-4-1", "2020-4-5")
  end

  describe "ReservationDesk instatiation" do
    it "is an instance of ReservationDesk" do
      expect(@reservation_desk).must_be_kind_of Hotel::ReservationDesk
    end
  end

  describe "rooms" do
    it "returns an array" do
      expect(@reservation_desk.rooms).must_be_kind_of Array
    end

    it "returns an array of Rooms" do
      expect(@reservation_desk.rooms[0]).must_be_kind_of Hotel::Room
      expect(@reservation_desk.rooms.last).must_be_kind_of Hotel::Room
    end

    it "includes 20 rooms by default" do
      expect(@reservation_desk.rooms.length).must_equal 20
    end

    it "the first room has an id of 1" do
      expect(@reservation_desk.rooms[0].id).must_equal 1
    end

    it "the last room has an id which is equal to the number of rooms" do
      reservation_desk = Hotel::ReservationDesk.new(room_num: 134)
      expect(reservation_desk.rooms.last.id).must_equal 134
    end
  end

   
  describe "reservations" do
    it "returns an array" do
      expect(@reservation_desk.reservations).must_be_kind_of Array
    end

    # it "returns an array of reservations" do
    #   expect(@reservation_desk.reservations.first).must_be_kind_of Hotel::Reservation
    #   expect(@reservation_desk.reservations.last).must_be_kind_of Hotel::Reservation
    # end
  end

  describe "new_reservation" do
    it "creates a new instanse of Reservation" do
      start_date = "2020-4-1"
      end_date = "2020-4-5"
      expect(@reservation_desk.new_reservation(start_date, end_date)).must_be_kind_of Hotel::Reservation
    end
  end

  describe "add_reservation" do
    before do
      @start_date = "2020-4-1"
      @end_date = "2020-4-5"
      @reservation = @reservation_desk.new_reservation(@start_date, @end_date)
      @reservations_num = @reservation_desk.reservations.length
      @reservation_desk.add_reservation(@reservation)
    end

    it "add a new instance of Reservation to reservations array" do
      expect(@reservation_desk.reservations.include? @reservation).must_equal true
      expect(@reservation_desk.reservations.length).must_equal (@reservations_num + 1)
    end

  end

end