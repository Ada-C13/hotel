require_relative 'test_helper'

describe "HotelDispatcher class" do
  describe "initialize" do
    
    it "@rooms will have a length of 20" do
    dispatcher = Hotel::HotelDispatcher.new()
    expect(dispatcher.rooms.length).must_equal 20
    end

    it "@reservations will be empty" do
      dispatcher = Hotel::HotelDispatcher.new()
      expect(dispatcher.reservations).must_be_empty
      end

  end #initialize end


  describe "make a new reservation" do
    it "@reservations should be length one" do
      dispatcher = Hotel::HotelDispatcher.new()
      expect(dispatcher.make_reservation("March 1, 2019", "March 5, 2019").length).must_equal 1
    end

    it "is an array" do
    dispatcher = Hotel::HotelDispatcher.new()
    expect(dispatcher.make_reservation("March 1, 2019", "March 5, 2019")).must_be_kind_of Array
    end
  end #make a new reservation end

  describe "find all reservations by room num and date range" do

    it "finds all reservations for a room given room_num and date range" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_all_res_for_room(1, "March 3, 2019", "March 7, 2019")).must_be_kind_of Array
    end

    it "returns a reservation when the given start_date falls into the reservation date range" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_all_res_for_room(1, "March 4, 2019", "March 10, 2019").length).must_equal 1
    end

    it "returns a reservation when the given end_date falls into the reservation date range" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_all_res_for_room(1, "Feb 28, 2019", "March 4, 2019").length).must_equal 1
    end

    it "does NOT return a reservation when the given date_ranges do NOT overlap" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_all_res_for_room(1, "March 7, 2019", "March 10, 2019")).must_be_empty
    end

  end # describ block end

  describe "find available rooms" do

    it "finds available rooms when reservation end_date and requested new room start_date do not overlap" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_available_rooms("March 6, 2019", "March 10, 2019").length).must_equal 1
    end

    it "finds available rooms by open dates" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_available_rooms("February 27, 2019", "March 1, 2019").length).must_equal 1
    end

    it "finds available rooms by open dates" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_available_rooms("March 5, 2019", "March 10, 2019").length).must_equal 1
    end

    it "finds available rooms by open dates" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_available_rooms("February 27, 2019", "March 1, 2019").length).must_equal 1
    end

   


  end # describe block end



  
  
end #HotelDispatcher class end
