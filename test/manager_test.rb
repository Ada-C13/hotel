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
    end 

    it "creates 20 rooms if no other parameter passed in" do 
      new_hotel = Hotel::Manager.new
      expect(new_hotel.all_rooms.length).must_equal 20
    end

    it "creates correct number of rooms if parameter passed in" do 
      manager2 = Hotel::Manager.new(num: 30)
      expect(manager2.all_rooms.length).must_equal 30
    end
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

    it "correctly assigns room numbers" do 
      new_hotel = Hotel::Manager.new(num: 2)
      expect(new_hotel.all_rooms[0].rm_num).must_equal 1
      expect(new_hotel.all_rooms[1].rm_num).must_equal 2
    end 
  end 

  describe "show_all_rooms" do   
    it "shows all rooms" do 
      new_hotel = Hotel::Manager.new(num: 2)
      expect(new_hotel.show_all_rooms.length).must_equal 2
      expect(new_hotel.show_all_rooms).must_equal [1, 2]
    end
  end 

  describe "book_res" do 
    before do 
      @new_hotel = Hotel::Manager.new(num: 2)
      @room1 = @new_hotel.all_rooms[0]
      @room2 = @new_hotel.all_rooms[1]
    end

    it "successfully runs" do
      res = @new_hotel.book_res(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
      expect{res}.wont_match ArgumentError
    end 

    it "correctly books available room " do  
      @room1.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
      @room1.book_room(Date.new(2014, 4, 1), Date.new(2014, 4,2))
      res = @new_hotel.book_res(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
      expect(res).must_be_instance_of Hotel::Reservation
      expect(res.rm_num).must_equal 2
    end

    it "gives ArgumentError if no room available" do  
      @room1.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
      @room2.book_room(Date.new(2014, 4, 3), Date.new(2014, 4,7))
      expect{@new_hotel.book_res(Date.new(2014, 4, 3), Date.new(2014, 4, 7))}.must_raise ArgumentError
    end   

  end 

  describe "res_by_room" do 
    before do 
      @new_hotel = Hotel::Manager.new(num: 2)
      @room1 = @new_hotel.all_rooms[0]
      @room2 = @new_hotel.all_rooms[1]
      @res1 = @room1.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
      @res2 = @room1.book_room(Date.new(2014, 4, 1), Date.new(2014, 4,2))
    end

    it "returns an array of reservations of a room for a date range" do 
      expect(@new_hotel.res_by_room(1, Date.new(2014, 4, 3), Date.new(2014, 4, 7))).must_be_instance_of Array
      expect(@new_hotel.res_by_room(1, Date.new(2014, 4, 3), Date.new(2014, 4, 7)).include?(@res1)).must_equal true
      expect(@new_hotel.res_by_room(1, Date.new(2014, 4, 1), Date.new(2014, 4, 7)).include?(@res1)).must_equal true
      expect(@new_hotel.res_by_room(1, Date.new(2014, 4, 1), Date.new(2014, 4, 7)).include?(@res2)).must_equal true
    end 

  end 

  describe "res_by_date" do 
    before do 
      @new_hotel = Hotel::Manager.new(num: 2)
      @room1 = @new_hotel.all_rooms[0]
      @room2 = @new_hotel.all_rooms[1]
      @res1 = @room1.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
      @res2 = @room2.book_room(Date.new(2014, 4, 3), Date.new(2014, 4,7))
    end

    it "returns an array of reservations from all rooms by one date" do 
      expect(@new_hotel.res_by_date(Date.new(2014, 4, 3))).must_be_instance_of Array
      expect(@new_hotel.res_by_date(Date.new(2014, 4, 3)).include?(@res2)).must_equal true
      expect(@new_hotel.res_by_date(Date.new(2014, 4, 3)).include?(@res1)).must_equal true
    end 
  end 

    describe "rooms_available_by_date" do 
      before do 
        @new_hotel = Hotel::Manager.new(num: 3)
        @room1 = @new_hotel.all_rooms[0]
        @room2 = @new_hotel.all_rooms[1]
        @room3 = @new_hotel.all_rooms[2]
        @res1 = @room1.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
        @res2 = @room2.book_room(Date.new(2014, 4, 3), Date.new(2014, 4, 7))
        @res3 = @room2.book_room(Date.new(2014, 4, 1), Date.new(2014, 4, 2))
      end
  
      it "returns an array of all rooms available during a certain date range" do 
        expect(@new_hotel.rooms_available_by_date(Date.new(2014, 4, 3), Date.new(2014, 4, 7))).must_be_instance_of Array
        expect(@new_hotel.rooms_available_by_date(Date.new(2014, 4, 3), Date.new(2014, 4, 7)).include?(@room3)).must_equal true
        expect(@new_hotel.rooms_available_by_date(Date.new(2014, 4, 3), Date.new(2014, 4, 4)).include?(@room2)).must_equal false
        expect(@new_hotel.rooms_available_by_date(Date.new(2014, 4, 1), Date.new(2014, 4, 4)).include?(@room1)).must_equal false


      end 
  end 

  describe "find_total_cost" do 
    
    before do 
      @new_hotel = Hotel::Manager.new(num: 3)
      @res1 = @new_hotel.all_rooms[0].book_room(Date.new(2014, 3, 4), Date.new(2014, 3, 7), recloc: "aaaaaa")
      @res2 = @new_hotel.all_rooms[1].book_room(Date.new(2014, 4, 1), Date.new(2014, 4, 2), recloc: "bbbbbb")
    end 

    it "returns correct total cost" do 
      expect(@new_hotel.find_total_cost("aaaaaa")).must_equal 600
      expect(@new_hotel.find_total_cost("bbbbbb")).must_equal 200
    end 
  end 

end