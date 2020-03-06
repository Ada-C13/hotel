require_relative "test_helper"

describe "Reservation" do
  describe "#initialize" do
    before do
      id = 1
      date_range = Hotel::DateRange.new("2020-3-13", "2020-3-15")
      room_num = 15
      @reservation = Hotel::Reservation.new(
        id, 
        date_range,
        room_num
      )
    end
    

    it "id must be a positive integer" do
      expect(@reservation.id).must_be_kind_of Integer
      expect(@reservation.id).must_equal 1
    end

    it "raise ArgumentError if id is not a positive integer" do
      id = -100
      expect{Hotel::Reservation.new(@reservation)}.must_raise ArgumentError
    end

    it "date_range must be a instance of DateRange class" do
      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
    end

    it "Raise ArgumentError when room number isn't between 1 to 20" do
      room_num = -100
      expect{Hotel::Reservation.new(@reservation)}.must_raise ArgumentError
      room_num = 25
      expect{Hotel::Reservation.new(@reservation)}.must_raise ArgumentError
    end

    it "room_num must be integer between 1 to 20" do
      expect(@reservation.room_num).must_equal 15
    end

    it "total_price" do
      expect(@reservation.total_price).must_equal 400
    end
  end
end