require_relative "test_helper"

describe "Reservation" do
  
  describe "Initialize" do
  
    before do
      @reservation = Hotel::Reservation.new(start_date: "2020-5-1", end_date: "2020-5-4", guest: "Bobby", num_rooms: 1)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "each start and stop time in array is a Time instance" do
      expect(@reservation.start_date).must_be_kind_of Time
      expect(@reservation.end_date).must_be_kind_of Time
    end

  describe "total_cost" do
    it "returns the total cost accurately and as a float" do
      expect(@reservation.total_cost).must_equal 600.00
    end
  end

  # describe "Look at start time"
  #   let @error_res = Hotel::Reservation.new(start_date: 5-1-2020, end_date: 5-4-2020, guest: "Bobby", num_rooms: 1)  

  #   it "throws an argument error with a bad start/end time" do
  #     expect @error_res.must_raise ArgumentError
  #   end

  end

end