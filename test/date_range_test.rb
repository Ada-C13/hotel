#date range (1) 2001,2,1 - 2001, 2,10    9 nights
#date range (2) 2001,2,1 - 2001, 2,4     3 nights
#date range (3) 2001,1,31 - 2001,2,4    4 nights
#date range (4) 2001,2,4 - 2001, 2,8    4 nights
#date range (5) 2001,2,8 - 2001, 2,10   2 nights
#date range (6) 2001,2,8 - 2001, 2,12   4 nights
#date range (7) 2001,2,12 - 2001,2,14   4 nights

require_relative "test_helper"

describe "Instanitates a new Date Range" do
  let(:check_in_date) { Date.new(2001, 2, 1) }
  let(:check_out_date) { Date.new(2001, 2, 3) }

  it "Initialize Date Range" do
    new_date = Date_Range.new(check_in_date, check_out_date)
    expect(new_date).must_be_kind_of Date_Range
  end

  describe "Checks Overlaps" do
    let(:check_in_date) { Date.new(2001, 2, 1) }
    let(:check_out_date) { Date.new(2001, 2, 4) }
    let(:date_range_1) { Date_Range.new(check_in_date, check_out_date) }

    it "both date ranges are the exact same" do
      #  Arrange
      date_range_2 = Date_Range.new(check_in_date, check_out_date)
      #  Act
      test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
      #  Assert
      expect(test_date_range).must_equal true
    end

    it " New date range fails within current date range" do
      #  Arrange
      start_two = Date.new(2001, 2, 2)
      end_two = Date.new(2001, 2, 3)
      date_range_2 = Date_Range.new(start_two, end_two)
      #  Act
      test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
      #  Assert
      expect(test_date_range).must_equal true
    end

    it "New date range starts before current date range - ends after after current check in" do
      #  Arrange
      start_two = Date.new(2001, 1, 31)
      end_two = Date.new(2001, 2, 2)
      date_range_2 = Date_Range.new(start_two, end_two)
      #  Act
      test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
      #  Assert
      expect(test_date_range).must_equal true
    end

    it "New date range check in starts prior to current date range end - ends after " do
      #  Arrange
      start_two = Date.new(2001, 2, 3)
      end_two = Date.new(2001, 2, 6)
      date_range_2 = Date_Range.new(start_two, end_two)
      #  Act
      test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
      #  Assert
      expect(test_date_range).must_equal true
    end

    it "New date range spans the length of the whole current reservation " do
      #  Arrange
      start_two = Date.new(2001, 2, 3)
      end_two = Date.new(2001, 2, 6)
      date_range_2 = Date_Range.new(start_two, end_two)
      #  Act
      test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
      #  Assert
      expect(test_date_range).must_equal true
    end

    it " New range check in same as check out for current - Return False" do
      #  Arrange
      start_two = Date.new(2001, 2, 4)
      end_two = Date.new(2001, 2, 7)
      date_range_2 = Date_Range.new(start_two, end_two)
      #  Act
      test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
      #  Assert
      expect(test_date_range).must_equal false
    end

    it " New date check in end before current check in" do
      #  Arrange
      start_two = Date.new(2001, 1, 28)
      end_two = Date.new(2001, 2, 1)
      date_range_2 = Date_Range.new(start_two, end_two)
      #  Act
      test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
      #  Assert
      expect(test_date_range).must_equal false
    end
    describe "Calulates number of nights " do
      let(:check_in_date) { Date.new(2001, 2, 3) }
      let(:check_out_date) { Date.new(2001, 2, 6) }

      it "Correctly calulates number of nights" do
        res = Reservation.new(Room.new(1), check_in_date, check_out_date)
        expect(res.number_of_nights?).must_equal 3
      end
    end
  end # inside describe
end # top describe

