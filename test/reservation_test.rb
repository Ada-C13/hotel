# include Hotel
require_relative 'test_helper'

describe Hotel::Reservation do
  describe "initialize" do
    before do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2020, 1, 2)
      @date_range = Hotel::DateRange.new(start_date, end_date)
      room_id = 2
      @reservation = Hotel::Reservation.new(@date_range, room_id)
    end

    # add must_respond_to tests?
    #___________________________

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "throws an argument error if given an invalid room_ID value" do
      [-1, 0, 21, nil, true, "hello"].each do |item|
        expect do
          Hotel::Reservation.new(date_range:@date_range, room_id:item)
        end.must_raise ArgumentError
      end
    end

  end

  describe "cost" do
    before do
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 2)
      @date_range = Hotel::DateRange.new(@start_date, @end_date)
      @reservation = Hotel::Reservation.new(@date_range, 2)
    end

    it "returns a number" do
      expect(@reservation.cost).must_be_kind_of Numeric
    end

    it "calculates the correct cost for a one-night reservation" do
      expect(@reservation.cost).must_equal 200
    end

    it "calculates the correct cost for a multiple-night reservation" do
      end_date_2 = @end_date + 1
      date_range_2 = Hotel::DateRange.new(@start_date, end_date_2)
      reservation = Hotel::Reservation.new(date_range_2, 2)
      expect(reservation.cost).must_equal 400

      end_date_3 = @end_date + 2
      date_range_3 = Hotel::DateRange.new(@start_date, end_date_3)
      reservation = Hotel::Reservation.new(date_range_3, 2)
      expect(reservation.cost).must_equal 600
    end
  end

end