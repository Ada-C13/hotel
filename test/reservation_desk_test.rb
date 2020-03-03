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

  describe "find_room_by_id" do
    it "returns an instanse of Room" do
      expect(@reservation_desk.find_room_by_id(2)).must_be_kind_of Hotel::Room
    end

    it "returns a Room with a matching ID" do
      expect(@reservation_desk.find_room_by_id(2).id).must_equal 2
    end

    it "returns nill if there is no Room with a matching ID" do
      assert_nil @reservation_desk.find_room_by_id(20000000)
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

  describe "find_reservations" do
    it "returns an array" do
      expect(@reservation_desk.find_reservations(room_id: 1)).must_be_kind_of Array
    end

    it "returns an array of reservations" do
      
    end

    it "Reservation#room_id is what we searched for" do
      
    end

    it "Reservation@start_date and end_date are what we searched for" do
      
    end

    it "Returns empty array if there are no reservations for the room/dates" do
      
    end

    it "Returns nil if room ID doesn't exist" do
      
    end

    it "If end_date is nil, returns all reservations from the start date onward" do
    #TODO: wording
    end  

    it "If start_date is nil, returns all reservations until the end date" do
      
    end

    it "If both start and end dates are nill, returns all reservations" do
      
    end

  end

  describe "new_reservation" do
    it "creates a new instanse of Reservation" do
      room_id = 1
      start_date = "2020-4-1"
      end_date = "2020-4-5"
      expect(@reservation_desk.new_reservation(room_id: room_id, start_date: start_date, end_date: end_date)).must_be_kind_of Hotel::Reservation
    end

    it "raises an error if room id is invalid" do
      room_id = 1000 #TODO: what if there is one?
      start_date = "2020-4-1"
      end_date = "2020-4-5"
      expect {
        @reservation_desk.new_reservation(room_id, start_date, end_date)
      }.must_raise ArgumentError
    end
  end

  describe "add_reservation" do
    before do
      @room = @reservation_desk.rooms[0]
      @room_id = 1
      @start_date = "2020-4-1"
      @end_date = "2020-4-5"
      @reservation = @reservation_desk.new_reservation(room_id: @room_id, start_date: @start_date, end_date: @end_date)
      @reservations_num = @reservation_desk.rooms[0].reservations.length
      @reservation_desk.add_reservation(@reservation)
    end

    it "add a new instance of Reservation to a correct Room's reservations array" do
      expect(@reservation_desk.rooms[0].reservations.include? @reservation).must_equal true
      expect(@reservation_desk.rooms[0].reservations.length).must_equal (@reservations_num + 1)
    end
  end

end