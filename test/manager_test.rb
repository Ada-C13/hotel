require_relative 'test_helper'
require 'simplecov'

SimpleCov.start do
  add_filter 'test/manager_test'
  add_filter 'test/reservation_test'
  add_filter 'test/room_test'
end

describe "manager" do 
  describe "initialize" do 
    it "creates an instance of Manager" do 
      manager = Hotel::Manager.new
      expect(manager).must_be_kind_of Hotel::Manager
      # expect(manager.length).must_equal 20
    end 

    # it "creates 20 rooms if no other parameter passed in" do 
    #   new_hotel = Hotel::Manager.new
    #   expect(new_hotel.all_rooms.length).must_equal 20
    # end

    # it "creates correct number of rooms if parameter passed in" do 
    #   all_rooms = Hotel::Manager.new(num: 30)
    #   expect(@all_rooms.length).must_equal 30
    # end
  end

  describe "create_rooms" do 
    it "creates 20 rooms if no other parameter passed in" do 
      rooms = Hotel::Manager.create_rooms
      expect(rooms.length).must_equal 20
    end

    it "creates correct number of rooms if parameter passed in" do 
      rooms = Hotel::Manager.create_rooms(num: 30)
      expect(rooms.length).must_equal 30
    end
  end 

  # describe "show_all_rooms" do 
  #   it "shows all rooms" do 
  #     new_hotel = Hotel::Manager.new(num: 2)
  #     expect(new_hotel.show_all_rooms.length).must_equal 20
  #   end
  # end 

  # describe "book_res" do 
  #   it "" do 
    
  #   end 
  # end 

  # describe "res_by_room" do 
  #   it "" do 
    
  #   end 
  # end 

  # describe "res_by_date" do 
  #   it "" do 
    
  #   end 
  # end 

    # describe "rooms_available_by_date" do 
  #   it "" do 
    
  #   end 
  # end 

  # describe "find_total_cost" do 
  #   before do 
  #     @res1 = Hotel::Reservation.new(start_date: "3/4/2014", end_date: "7/4/2014")
  #     @res2 = Hotel::Reservation.new(start_date: "1/4/2014", end_date: "2/4/2014")
  #   end 

  #   it "returns correct total cost" do 
  #     expect(@res1.find_total_cost).must_equal 800
  #     expect(@res2.find_total_cost).must_equal 200
    
  #   end 
  # end 

    ## taken from old class
    # describe "create_rooms" do 
  #   it "creates the correct number of rooms" do 
  #     all_rooms = Hotel::Room.create_rooms(20)
  #     expect(all_rooms.length).must_equal 20
  #   end
  # end

end