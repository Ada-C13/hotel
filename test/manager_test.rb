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
      manager.must_be_kind_of Hotel::Manager
    end 
  end

  it "creates 20 rooms if no other parameter passed in" do 
    all_rooms = Hotel::Manager.create_rooms
    expect(all_rooms.length).must_equal 20
  end

  it "creates correct numner of rooms if parameter passed in" do 
    all_rooms = Hotel::Manager.create_rooms(num: 30)
    expect(all_rooms.length).must_equal 30
  end
  
  # describe "show_all_rooms" do 
  #   it "shows all rooms" do 
  #     new_hotel = Hotel::Manager.new
  #     expect(new_hotel.show_all_rooms.length).must_equal 20
  #   end
  # end 

  # describe "book_res" do 
  #   it "" do 
    
  #   end 
  # end 

  # describe "res_by_date" do 
  #   it "" do 
    
  #   end 
  # end 

  # describe "total_cost" do 
  #   it "" do 
    
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