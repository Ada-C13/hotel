require_relative 'test_helper'

describe "HotelManager class" do 

  # Arrange 
  before do 
     @hotel_manager = Hotel::HotelManager.new()

     @date_range = Hotel::DateRange.new("2020-3-20", "2020-3-27")
     @date_range_2 =  Hotel::DateRange.new("2020-3-5", "2020-3-10")

    # 1st reservation
    @hotel_manager.make_reservation(@date_range)

    # 2nd reservation
    @hotel_manager.make_reservation(@date_range_2)
  end 


  describe "#initialize" do 
    # I can access the list of all of the rooms in the hotel
    it "Creates rooms" do
      # Assert
      expect(@hotel_manager).must_respond_to :rooms

      expect(@hotel_manager.rooms).must_be_instance_of Array

      @hotel_manager.rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end  
    end 

    # I access the list of reservations for a specified room and a given date range
    it "Creates reservations" do 
  
      expect(@hotel_manager).must_respond_to :reservations

      expect(@hotel_manager.reservations).must_be_instance_of Array   
      
      @hotel_manager.reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end 
    end 

    it "Returns the first reservation" do 
      expect(@hotel_manager.reservations[0].room.number).must_equal 1
      expect(@hotel_manager.reservations[0].date_range).must_be_instance_of Hotel::DateRange
    end 

    it "Returns the last reservation" do 
      last_index = @hotel_manager.reservations.length - 1
      expect(@hotel_manager.reservations[last_index].room.number).must_equal last_index + 1
    end 
  end 

  describe "#available_room" do 
    it "Returns an available room" do 
      # Arrange 
      date_range_3 = Hotel::DateRange.new("2020-3-5", "2020-3-10")

      # 3rd reservation
      @hotel_manager.make_reservation(date_range_3)

      # Act & Assert
      expect(@hotel_manager.available_room(date_range_3).number).must_equal 4
    end 
  end 


  describe "#make_reservation" do 
    it "Makes a reservation within valid date range" do 
      # Assert 
      expect(@hotel_manager).must_respond_to :make_reservation

      expect(@hotel_manager.make_reservation(@date_range)).must_be_instance_of Hotel::Reservation
    end 
  end 


  # I can access the list of reservations for a specific date, so that I can track reservations by date
  describe "#find_reservations_by_date" do 
    
    it "Finds the list of reservations for a specific date" do 
      reservations_list = @hotel_manager.find_reservations_by_date(@date_range)

     # Assert
      expect(reservations_list).must_be_instance_of Array 
      reservations_list.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end 
    end 
  end 
end 