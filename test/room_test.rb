require_relative "test_helper"

describe "Room" do
  before do
    @room = Hotel::Room.new(1, 200)
    date_range1 = Hotel::DateRange.new(Date.new(2020,4,12), Date.new(2020,4,13))
    date_range2 = Hotel::DateRange.new(Date.new(2020,4,16), Date.new(2020,4,20))
    reservation1 = Hotel::Reservation.new(date_range1)
    reservation2 = Hotel::Reservation.new(date_range2)

    @room.reservations.push(reservation1)
    @room.reservations.push(reservation2)
  end

  describe "initialize" do
    it "creates an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
      expect(@room).must_respond_to :number
      expect(@room).must_respond_to :cost
      expect(@room).must_respond_to :reservations
    end
  end

  describe "check_availability" do
    let(:check_availability) do
      date_range = Hotel::DateRange.new(Date.new(2020,5,3), Date.new(2020,5,5))
      check_availability = @room.check_availability(date_range)
    end

    it "returns true if room has no reservations" do
      @room.reservations.clear()
      expect(check_availability).must_equal true
    end

    it "returns true if room has no reservations during date range provided" do
      expect(check_availability).must_equal true
    end

    it "returns false if room has a reservation during date range provided" do
      date_range = Hotel::DateRange.new(Date.new(2020,4,13), Date.new(2020,5,5))
      availability = @room.check_availability(date_range)
      expect(availability).must_equal false
    end

    it "returns true when last day of reservation is same as first day of new reservation" do
      date_range = Hotel::DateRange.new(Date.new(2020,4,20), Date.new(2020,5,5))
      availability = @room.check_availability(date_range)
      expect(availability).must_equal true
    end

    it "returns true when first day of reservation is same as last day of new reservation" do
      date_range = Hotel::DateRange.new(Date.new(2020,4,14), Date.new(2020,4,16))
      availability = @room.check_availability(date_range)
      expect(availability).must_equal true
    end

  end

  describe "list_reservations" do
    it "returns an array of reservations for given date_range" do
      date_range = Hotel::DateRange.new(Date.new(2020,4,16), Date.new(2020,4,20))

      expect(@room.list_reservations(date_range)).must_be_kind_of Array
      expect(@room.list_reservations(date_range)[0]).must_be_kind_of Hotel::Reservation
    end

    it "returns an array of reservations for given date" do
      date = Date.new(2020,4,12)

      expect(@room.list_reservations(date)).must_be_kind_of Array
      expect(@room.list_reservations(date)[0]).must_be_kind_of Hotel::Reservation
    end

    it "returns an empty array if there are no reservations during given date_range" do
      date_range = Hotel::DateRange.new(Date.new(2020,7,12), Date.new(2020,7,13))
      expect(@room.list_reservations(date_range)).must_equal []
    end

    it "returns an empty array if there are no reservations during given date" do
      date = Date.new(2020,4,30)
      expect(@room.list_reservations(date)).must_equal []
    end

    it "returns all reservations if no arguments are provided" do
      expect(@room.list_reservations.length).must_equal 2
    end

    it "raises ArgumentError if Date or DateRange is not provided" do
      date = "date"

      expect{(@room.list_reservations(date))}.must_raise ArgumentError
    end
  end

end