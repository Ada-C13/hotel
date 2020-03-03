require_relative 'test_helper'

describe "Reservation class" do 
  
  # Arrange 
  before do 
    date_range = Hotel::DateRange.new("2020-3-20", "2020-3-27")

    room = {
      number: 5,
      vacancy: true
    }

    @reservation = Hotel::Reservation.new(date_range, room)
  end

  describe "#initialize" do 
    it "Creates date_range and room instances" do 
      expect(@reservation).must_respond_to :date_range
      expect(@reservation).must_respond_to :room

      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
    end 
  end 
end 