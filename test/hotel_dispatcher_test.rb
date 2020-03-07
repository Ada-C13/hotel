require_relative 'test_helper'
require 'pry'

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
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
      expect(dispatcher.reservations.length).must_equal 1
    end

    it "is an array" do
    dispatcher = Hotel::HotelDispatcher.new()
    expect(dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))).must_be_kind_of Array
    end

    it "raises ArgumentError when start date is greater than end date" do
      dispatcher = Hotel::HotelDispatcher.new()
      expect{ dispatcher.make_reservation(Date.new(2019, 03, 15), Date.new(2019, 03, 01)) }.must_raise ArgumentError
    end

  end #make a new reservation end


  describe "find all reservations by room num and date range" do

    it "finds all reservations for a room given room_num and date range" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2019, 03, 03), Date.new(2019, 03, 07))).must_be_kind_of Array
    end

    it "returns a reservation when the given start_date falls into the reservation date range" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2019, 03, 04), Date.new(2019, 03, 10)).length).must_equal 1
    end

    it "returns a reservation when the given end_date falls into the reservation date range" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2019, 02, 28), Date.new(2019, 03, 03)).length).must_equal 1
    end

    it "does NOT return a reservation when the given date_ranges do NOT overlap" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2019, 03, 07), Date.new(2019, 03, 10))).must_be_empty
    end

  end # describ block end

  # describe "find available rooms" do

  #   it "will have 20 rooms on a new Hotel Dispatcher object" do
  #     dispatcher = Hotel::HotelDispatcher.new()
  #     expect(dispatcher.find_available_rooms(Date.new(2019, 03, 06), Date.new(2019, 03, 10)).length).must_equal 20
  #   end

  #   it "will return 19 available rooms only if there is one existing reservation that falls within the given date range" do 
  #     dispatcher = Hotel::HotelDispatcher.new()
  #     dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
  #     expect(dispatcher.find_available_rooms(Date.new(2019, 03, 01), Date.new(2019, 03, 10)).length).must_equal 20


  #   end

  #   it "when the date ranges for the reservation and the args for the make_res_method do not overlap" do
  #     dispatcher = Hotel::HotelDispatcher.new()
  #     dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
  #     expect(dispatcher.find_available_rooms(Date.new(2019, 03, 06), Date.new(2019, 03, 10)).length).must_equal 1
  #   end

  #   it "finds available rooms by open dates" do
  #     dispatcher = Hotel::HotelDispatcher.new()
  #     dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
  #     expect(dispatcher.find_available_rooms(Date.new(2019, 02, 27), Date.new(2019, 03, 01)).length).must_equal 1
  #   end

  #   it "finds available rooms by open dates" do
  #     dispatcher = Hotel::HotelDispatcher.new()
  #     dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
  #     expect(dispatcher.find_available_rooms(Date.new(2019, 03, 05), Date.new(2019, 03, 10)).length).must_equal 1
  #   end

  #   it "finds available rooms by open dates" do
  #     dispatcher = Hotel::HotelDispatcher.new()
  #     dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
  #     expect(dispatcher.find_available_rooms(Date.new(2019, 02, 27), Date.new(2019, 03, 01)).length).must_equal 1
  #   end

  #   it "finds all reservations for a single date" do
  #     dispatcher = Hotel::HotelDispatcher.new()
  #     dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 07))
  #     dispatcher.make_reservation(Date.new(2019, 03, 06), Date.new(2019, 03, 10))
  #     dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 06))
  #     expect(dispatcher.find_all_reservations(Date.new(2019, 03, 06)).length).must_equal 2
  #     expect(dispatcher.find_all_reservations(Date.new(2019, 04, 01)).length).must_equal 0
  #   end

   


  # end # describe block end



  
  
end #HotelDispatcher class end
