require_relative "test_helper"

describe "FrontDesk Class" do

  describe "initialize" do
    before do 
      @test_desk = Hotel::FrontDesk.new()
    end 

    it "creates an instance of FrontDesk" do
      expect(@test_desk).must_be_kind_of Hotel::FrontDesk
    end 
    
    it "populates room list with 20 room objects" do 
      expect(@test_desk.rooms.length).must_equal 20
      expect(@test_desk.rooms[0]).must_be_kind_of Hotel::Room
    end 

    it "sets reservations list to empty arrays as default" do 
      expect(@test_desk.reservations.length).must_equal 0 
    end 
  end 

  xdescribe "all_rooms" do 
    it "prints all the rooms information" do 
      @test_desk = Hotel::FrontDesk.new()
      @test_desk.all_rooms 
      # not sure how to test printed output 
    end 
  end  

  describe "reservations_by_date(date_query)" do 
    before do 
      test_res_1 = Hotel::Reservation.new(id: 1, room_num: 1, start_date: Date.new(2020, 8, 1), end_date: Date.new(2020, 8, 5)) # includes test_date
      test_res_2 = Hotel::Reservation.new(id: 2, room_num: 2, start_date: Date.new(2020, 7, 1), end_date: Date.new(2020, 7, 11))
      test_res_3 = Hotel::Reservation.new(id: 3, room_num: 3, start_date: Date.new(2020, 8, 4), end_date: Date.new(2020, 8, 10)) # includes test_date
      test_res_4 = Hotel::Reservation.new(id: 4, room_num: 4, start_date: Date.new(2020, 8, 3), end_date: Date.new(2020, 8, 4))
      test_res_5 = Hotel::Reservation.new(id: 5, room_num: 5, start_date: Date.new(2020, 8, 14), end_date: Date.new(2020, 8, 21))
      test_res_6 = Hotel::Reservation.new(id: 6, room_num: 6, start_date: Date.new(2020, 8, 2), end_date: Date.new(2020, 8, 9)) # includes test_date
      test_date = Date.new(2020, 8, 4)

      @test_desk = Hotel::FrontDesk.new(reservations: [test_res_1, test_res_2, test_res_3, test_res_4, test_res_5, test_res_6])
      @test_res_list = @test_desk.reservations_by_date(test_date)
    end 

    it "returns an array of reservation objects" do
      expect(@test_res_list).must_be_kind_of Array
      expect(@test_res_list.first).must_be_kind_of Hotel::Reservation 
    end

    it "lists every reservation with a date range that includes the date being queried" do 
      expect(@test_res_list.length).must_equal 3
      expect(@test_res_list[0].id).must_equal 1
      expect(@test_res_list[1].id).must_equal 3
      expect(@test_res_list[2].id).must_equal 6
    end 
  end 

  describe "reservations_by_room_and_range(room_num_query, range_query)" do
    before do 
      test_res_1 = Hotel::Reservation.new(id: 1, room_num: 1, start_date: Date.new(2020, 6, 1), end_date: Date.new(2020, 6, 5)) 
      test_res_2 = Hotel::Reservation.new(id: 2, room_num: 2, start_date: Date.new(2020, 7, 1), end_date: Date.new(2020, 7, 5))
      test_res_3 = Hotel::Reservation.new(id: 3, room_num: 3, start_date: Date.new(2020, 7, 1), end_date: Date.new(2020, 7, 10)) # in test_range
      test_res_4 = Hotel::Reservation.new(id: 4, room_num: 3, start_date: Date.new(2020, 7, 15), end_date: Date.new(2020, 7, 19)) # in test_range 
      test_res_5 = Hotel::Reservation.new(id: 5, room_num: 3, start_date: Date.new(2020, 7, 21), end_date: Date.new(2020, 7, 31)) # in test_range 
      test_res_6 = Hotel::Reservation.new(id: 6, room_num: 4, start_date: Date.new(2020, 8, 2), end_date: Date.new(2020, 8, 9)) 
      test_res_7 = Hotel::Reservation.new(id: 7, room_num: 3, start_date: Date.new(2020, 7, 31), end_date: Date.new(2020, 8, 8)) 
      test_room_num = 3
      test_range = Hotel::DateRange.new(start_date: Date.new(2020, 7, 1), end_date: Date.new(2020, 7, 31)) # month of July

      @test_desk = Hotel::FrontDesk.new(reservations: [test_res_1, test_res_2, test_res_3, test_res_4, test_res_5, test_res_6, test_res_7])
      @test_res_list = @test_desk.reservations_by_room_and_range(test_room_num, test_range)
    end 

    it "returns an array of reservation objects" do
      expect(@test_res_list).must_be_kind_of Array
      expect(@test_res_list.first).must_be_kind_of Hotel::Reservation 
    end

    it "lists every reservation with the same room number as the room number being queried" do
      @test_res_list.each do |res|
        expect(res.room_num) == 3
      end 
    end
    
    it "lists every reservation with a date range that is within the date range being queried" do 
      expect(@test_res_list.length).must_equal 3
      expect(@test_res_list[0].id).must_equal 3
      expect(@test_res_list[1].id).must_equal 4
      expect(@test_res_list[2].id).must_equal 5
    end 
  end

  describe "available_rooms(range_query)" do 
    # ASSUMPTION: this method returns room numbers, not instances of room objects
    before do 
      test_res_1 = Hotel::Reservation.new(id: 1, room_num: 1, start_date: Date.new(2020, 8, 1), end_date: Date.new(2020, 8, 5)) 
      test_res_2 = Hotel::Reservation.new(id: 2, room_num: 2, start_date: Date.new(2020, 7, 1), end_date: Date.new(2020, 7, 11)) # available during range
      test_res_3 = Hotel::Reservation.new(id: 3, room_num: 3, start_date: Date.new(2020, 8, 4), end_date: Date.new(2020, 8, 10)) 
      test_res_4 = Hotel::Reservation.new(id: 4, room_num: 4, start_date: Date.new(2020, 8, 3), end_date: Date.new(2020, 8, 8))
      test_res_5 = Hotel::Reservation.new(id: 5, room_num: 5, start_date: Date.new(2020, 8, 8), end_date: Date.new(2020, 8, 21)) # available during range
      test_res_6 = Hotel::Reservation.new(id: 6, room_num: 6, start_date: Date.new(2020, 8, 2), end_date: Date.new(2020, 8, 9)) 

      test_range = Hotel::DateRange.new(start_date: Date.new(2020, 8, 1), end_date: Date.new(2020, 8, 8)) # first week of August
      @test_desk = Hotel::FrontDesk.new(reservations: [test_res_1, test_res_2, test_res_3, test_res_4, test_res_5, test_res_6])
      @test_avail_rooms_list = @test_desk.available_rooms(test_range)
    end 

    it "returns an array of room numbers" do 
      expect(@test_avail_rooms_list).must_be_kind_of Array
      expect(@test_avail_rooms_list.first).must_be_kind_of Integer
    end 

    it "lists every room that does not have a reservation whose date range overlaps with the date range being queried" do 
      expect(@test_avail_rooms_list[0]).must_equal 2
      expect(@test_avail_rooms_list[1]).must_equal 5
    end

    it "includes rooms that don't have reservations made for them yet" do 
     expect(@test_avail_rooms_list.length).must_equal 16 # 20 rooms total - 4 that are occupied
    end 
  end 

  describe "update_reservations_list(reservation)" do 
    it "adds a reservation object to the reservations list" do
      start_date = Date.new(2020, 8, 4)
      end_date = start_date + 5
      range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      @test_reservation = Hotel::Reservation.new(id: 1, room_num: 1, start_date: start_date, end_date: end_date, range: range)
      @test_desk = Hotel::FrontDesk.new()

      @test_desk.update_reservations_list(@test_reservation)
      expect(@test_desk.reservations.length).must_equal 1
      expect(@test_desk.reservations[0]).must_be_kind_of Hotel::Reservation
    end 
  end 

  describe "reserve_room(start_date, end_date)" do 
    it "raises an error for invalid date range: same start and end date" do
      @test_desk = Hotel::FrontDesk.new()
      start_date = Date.new(2020, 8, 4)
      end_date = Date.new(2020, 8, 4)
      expect{@test_desk.reserve_room(start_date, end_date)}.must_raise ArgumentError
    end 

    it "raises an error for invalid date range: end date before start date" do
      @test_desk = Hotel::FrontDesk.new()
      start_date = Date.new(2020, 8, 4)
      end_date = Date.new(2020, 8, 1)
      expect{@test_desk.reserve_room(start_date, end_date)}.must_raise ArgumentError
    end 
  
    it "raises an error when there are no rooms available for the date range provided" do 
      @test_desk = Hotel::FrontDesk.new()
      start_date = Date.new(2020, 8, 1)
      end_date = Date.new(2020, 8, 8)
      i = 1 
      # book all 20 rooms that conflict with date range provided 
      20.times do
        @test_desk.update_reservations_list(Hotel::Reservation.new(id: i, room_num: i, start_date: Date.new(2020, 8, 1), end_date: Date.new(2020, 8, 5))) 
        i += 1
      end  
      expect{@test_desk.reserve_room(start_date, end_date)}.must_raise ArgumentError
    end 

    it "appends a new reservation object to the @reservations list" do 
      test_res_1 = Hotel::Reservation.new(id: 1, room_num: 1, start_date: Date.new(2020, 7, 1), end_date: Date.new(2020, 7, 5)) 
      test_res_2 = Hotel::Reservation.new(id: 2, room_num: 2, start_date: Date.new(2020, 7, 4), end_date: Date.new(2020, 7, 10)) 
      test_res_3 = Hotel::Reservation.new(id: 3, room_num: 3, start_date: Date.new(2020, 7, 29), end_date: Date.new(2020, 8, 1))
      start_date = Date.new(2020, 8, 1)
      end_date = Date.new(2020, 8, 8)
      @test_desk = Hotel::FrontDesk.new(reservations: [test_res_1, test_res_2, test_res_3])
      @test_desk.reserve_room(start_date, end_date)
      expect(@test_desk.reservations.length).must_equal 4
      expect(@test_desk.reservations[3]).must_be_kind_of Hotel::Reservation
    end 

    it "creates a reservation object with an available room" do 
      test_res_1 = Hotel::Reservation.new(id: 1, room_num: 1, start_date: Date.new(2020, 8, 1), end_date: Date.new(2020, 8, 5)) 
      test_res_2 = Hotel::Reservation.new(id: 2, room_num: 2, start_date: Date.new(2020, 7, 1), end_date: Date.new(2020, 7, 11)) # available during range
      test_res_3 = Hotel::Reservation.new(id: 3, room_num: 3, start_date: Date.new(2020, 8, 4), end_date: Date.new(2020, 8, 10)) 
      test_res_4 = Hotel::Reservation.new(id: 4, room_num: 4, start_date: Date.new(2020, 8, 3), end_date: Date.new(2020, 8, 8))
      test_res_5 = Hotel::Reservation.new(id: 5, room_num: 5, start_date: Date.new(2020, 8, 8), end_date: Date.new(2020, 8, 21)) # available during range
      test_res_6 = Hotel::Reservation.new(id: 6, room_num: 6, start_date: Date.new(2020, 8, 2), end_date: Date.new(2020, 8, 9)) 
      start_date = Date.new(2020, 8, 1)
      end_date = Date.new(2020, 8, 8)
      @test_desk = Hotel::FrontDesk.new(reservations: [test_res_1, test_res_2, test_res_3, test_res_4, test_res_5, test_res_6])
      @test_desk.reserve_room(start_date, end_date)
      expect(@test_desk.reservations[6].room_num).must_be :!=, 1
      expect(@test_desk.reservations[6].room_num).must_be :!=, 3
      expect(@test_desk.reservations[6].room_num).must_be :!=, 4
      expect(@test_desk.reservations[6].room_num).must_be :!=, 6
    end 

    it "creates a reservation object with start and end dates that match the ones that were requested" do 
      @test_desk = Hotel::FrontDesk.new()
      start_date = Date.new(2020, 8, 1)
      end_date = Date.new(2020, 8, 8)
      @test_desk.reserve_room(start_date, end_date)
      expect(@test_desk.reservations[0].start_date).must_equal start_date
      expect(@test_desk.reservations[0].end_date).must_equal end_date
    end 

    it "does not assign the same room for same date range" do 
      @test_desk = Hotel::FrontDesk.new()
      start_date = Date.new(2020, 8, 1)
      end_date = Date.new(2020, 8, 8)
      @test_desk.reserve_room(start_date, end_date)
      @test_desk.reserve_room(start_date, end_date)
      expect(@test_desk.reservations[1].room_num).must_be :!=, @test_desk.reservations[0].room_num
    end 

    it "does not assign the same room for overlapping date ranges" do 
      @test_desk = Hotel::FrontDesk.new()
      start_date_1 = Date.new(2020, 8, 1)
      end_date_1 = Date.new(2020, 8, 8)
      start_date_2 = Date.new(2020, 8, 1)
      end_date_2 = Date.new(2020, 8, 3)  
      @test_desk.reserve_room(start_date_1, end_date_1)
      @test_desk.reserve_room(start_date_2, end_date_2)
      expect(@test_desk.reservations[1].room_num).must_be :!=, @test_desk.reservations[0].room_num
    end 

    it "does assign the first available room for non-overlapping ranges" do 
      @test_desk = Hotel::FrontDesk.new()
      start_date_1 = Date.new(2020, 8, 1)
      end_date_1 = Date.new(2020, 8, 8)
      start_date_2 = Date.new(2020, 8, 8)
      end_date_2 = Date.new(2020, 8, 9)  
      @test_desk.reserve_room(start_date_1, end_date_1)
      @test_desk.reserve_room(start_date_2, end_date_2)
      expect(@test_desk.reservations[1].room_num).must_be :==, @test_desk.reservations[0].room_num
    end 
  end
  
end  