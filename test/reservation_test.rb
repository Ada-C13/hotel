require_relative "test_helper"

describe "Reservation class" do
  describe "Reservation instatiation" do
    before do
      @room_id = 1
      @start_date = "2020-4-1"
      @end_date = "2020-4-5"
      @reservation = Hotel::Reservation.new(room_id: @room_id, start_date: @start_date, end_date: @end_date)
    end

    it "is an instance of reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "stores start and end dates as Date objects" do
      expect(@reservation.start_date).must_be_kind_of Date
    end

  end


end