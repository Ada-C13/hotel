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

  describe "find all reservations by room num" do
    it "finds all reservations for a room" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation("March 1, 2019", "March 5, 2019")
      expect(dispatcher.find_all_res_for_room(1).length).must_equal 1
    end
  end
  
  
end #HotelDispatcher class end
