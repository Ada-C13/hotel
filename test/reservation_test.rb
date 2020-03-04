require_relative 'test_helper'

describe "Reservation class" do
  describe "initialize" do
    before do
      start_date= "March 1, 2019"
      end_date = "March 5, 2019"

      room = Hotel::Room.new(
        room_num: 13,
        date_range: [start_date, end_date], 
      )

      @res_data = Hotel::Reservation.new(

          res_id: 1337,
          start_date: start_date,
          end_date: end_date,
          room: room
          
        
      )
      
    end #before do end

    it "is an instance of Reservation" do
      expect(@res_data).must_be_kind_of Hotel::Reservation
    end 
    
    it "has a start_date that is a Date object" do
      expect(@res_data.start_date).must_equal Date.parse("March 1, 2019") 
    end

    it "has an end_date that is a Date object" do
      expect(@res_data.end_date).must_equal Date.parse("March 5, 2019")
    end
    
    it "@res_data.room is an instance of Room.new" do
      expect(@res_data.room).must_be_kind_of Hotel::Room
    end

    it "calculates res_duration in days - minus checkout day" do
      expect(@res_data.res_duration).must_equal 3
    end

    it "calculates total cost of reservation" do
      expect(@res_data.find_total_cost).must_equal 600
    end


  end #Describe initialize end


end #Reservation class describe block end




# DATE constants which are arrays of month names and day names
# Date::MONTHNAMES # (index 0 = nil)
# Date::DAYNAMES starts on Sunday. use .rotate(1) to change to Monday. 