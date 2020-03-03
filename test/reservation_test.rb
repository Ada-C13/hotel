require_relative 'test_helper'

describe "Reservation class" do
  describe "initialize" do
    before do
      #Date.parse("September 3") # -> 2015-09-03
      start_date= "March 1, 2019"
      end_date = "March 5, 2019"
      @reservation_data = Hotel::Reservation.new(
        res_id: 1337,
        start_date: start_date,
        end_date: end_date
    )
    end #before do end

    it "is an instance of Reservation" do
      expect(@reservation_data).must_be_kind_of Hotel::Reservation
      # puts "This is the actual id #{@reservation_data.id}" 
      puts "This is the res_id #{@reservation_data.res_id}"
    end #Instance of Reservation end
    
    it "has a start_date that is a Date object" do
      expect(@reservation_data.start_date).must_equal Date.parse("March 1, 2019") 
    end

    it "has an end_date that is a Date object" do
      expect(@reservation_data.end_date).must_equal Date.parse("March 5, 2019")
    end


  end #Describe initialize end


end #Reservation class describe block end


# DATE constants which are arrays of month names and day names
# Date::MONTHNAMES # (index 0 = nil)
# Date::DAYNAMES starts on Sunday. use .rotate(1) to change to Monday. 