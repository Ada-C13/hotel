require_relative 'test_helper'

describe "Reservation class" do
  describe "initialize" do
    before do
      @reservation_data = Hotel::Reservation.new(
        id: 1337,
        start_date: "January 9, 2020",
        end_date: "January 11, 2020",
        room: 19
    )
    end #before end

    it "is an instance of Reservation" do
      expect(@reservation_data).must_be_kind_of Hotel::Reservation
    end #Instance of Reservation end
    
    it ""
  end #Describe initialize end


end #Reservation class describe block end

