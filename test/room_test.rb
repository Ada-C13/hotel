require_relative "test_helper"

describe Hotel::Room do
  describe "constructor" do
    room1 = Hotel::Room.new(1)
    it "creates a room" do
      expect(room1).must_be_kind_of Hotel::Room
    end
    it "has correct id" do
      expect(room1.id).must_equal 1
    end
    it "has an array called reservations" do
      expect(room1.reservations).must_be_kind_of Array
    end
  end
  describe "available? + add" do
    before do
      @room20 = Hotel::Room.new(20)
      @reservation1 = Hotel::Reservation.new(Date.new(2020, 01,01),Date.new(2020,01,03),20)
      @reservation2 = Hotel::Reservation.new(Date.new(2020, 01,01),Date.new(2020,01,04),20)
      @reservation3 = Hotel::Reservation.new(Date.new(2020, 01,03),Date.new(2020,01,05),20)
      @reservation4 = Hotel::Reservation.new(Date.new(2020, 02,01),Date.new(2020,02,03),20)
    end
    it "adds a reservation" do
      @room20.add(@reservation1)
      expect(@room20.reservations[0]).must_equal @reservation1
    end
    it "*adds another, unconflicting reservation to room" do
      @room20.add(@reservation1)
      @room20.add(@reservation3)
      expect(@room20.reservations[1]).must_equal @reservation3
    end
    it "raises error if attempt to add overlapping reservation" do
      @room20.add(@reservation1)
      expect{@room20.add(@reservation2)}.must_raise ArgumentError
      expect(@room20.reservations.include?(@reservation2)).must_equal false
    end
    it "returns false when not available" do
      @room20.add(@reservation1)
      expect(@room20.available?(@reservation2)).must_equal false
    end
    it "returns true when available" do
      @room20.add(@reservation1)
      expect(@room20.available?(@reservation4)).must_equal true
    end
  end

  describe "returns list of reservations for a specific date range" do
    before do
      @room15 = Hotel::Room.new(15)
      @reservation1 = Hotel::Reservation.new(Date.new(2020, 01,01), Date.new(2020,01,03),15)
      @reservation2 = Hotel::Reservation.new(Date.new(2020, 01,03), Date.new(2020,01,04),15)
      @reservation3 = Hotel::Reservation.new(Date.new(2020, 01,04), Date.new(2020,01,05),15)
      @reservation4 = Hotel::Reservation.new(Date.new(2020, 02,04), Date.new(2020,02,05),15)
      @room15.add(@reservation1)
      @room15.add(@reservation2)
      @room15.add(@reservation3)
      @room15.add(@reservation4)
    end
    it "returns correct reservations for specific date range" do
      resvs_within = @room15.get_reservations(Date.new(2020, 01,01), Date.new(2020,01,31))
      expect(resvs_within.include? @reservation1).must_equal true
      expect(resvs_within.include? @reservation2).must_equal true
      expect(resvs_within.include? @reservation3).must_equal true
      expect(resvs_within.include? @reservation4).must_equal false
    end
    it "returns an array of one reservation if only one found" do
      resvs_within = @room15.get_reservations(Date.new(2020, 02,01), Date.new(2020,02,29))
      expect(resvs_within.include? @reservation4).must_equal true
    end
    it "doesn't include a reservation partly in the specified range" do
      @reservation5 = Hotel::Reservation.new(Date.new(2019, 12, 31), Date.new(2020, 01, 05), 15)
      @reservation6 = Hotel::Reservation.new(Date.new(2020, 01, 29), Date.new(2020, 02, 02), 15)
      @room15.add(@reservation5)
      @room15.add(@reservation6)
      resvs_within = @room15.get_reservations(Date.new(2020, 01,01), Date.new(2020,01,31))
      expect(resvs_within.include? @reservation5).must_equal false
      expect(resvs_within.include? @reservation6).must_equal false
    end
    it "returns empty array if none found" do
      resvs_within = @room15.get_reservations(Date.new(2020, 03,01), Date.new(2020,03,31))
      expect(resvs_within.length).must_equal 0
    end
  end
  
end