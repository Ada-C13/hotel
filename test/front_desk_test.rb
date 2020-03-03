require_relative 'test_helper'
describe "front_desk" do 
  def hotel_manager 
    return Hotel::FrontDesk.new()
  end 
  describe "reservation_cost method" do 
    it "calculate cost for a reservation" do 
      manager = hotel_manager
      reservation_1 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,2],end_date:[2020,3,5]
        )
      )
      reservation_2 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,4,1],end_date:[2020,4,8]
        )
      )
  
      manager.reservations << reservation_1
      manager.reservations << reservation_2
      cost = manager.reservation_cost(reservation_1)
      expect(cost).must_equal 600
      cost2 = manager.reservation_cost(reservation_2)
      expect(cost2).must_equal 1400
    end
  end  

  describe "list_all" do
    it "return a list of all reservations" do 
      manager = hotel_manager
      reservation_1 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,2],end_date:[2020,3,5]
        )
      )
      reservation_2 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,4,1],end_date:[2020,4,8]
        )
      )
      manager.reservations << reservation_1
      manager.reservations << reservation_2
      result = manager.list_all
      expect(result).must_match (/2020-03-02/)
      expect(result).must_match (/2020-03-05/)
      expect(result).must_match (/2020-04-01/)
      expect(result).must_match (/2020-04-08/)
    end 
  end
  
  describe "check_date_reservations method" do 
    it "return a list of all reservations under a specific date" do 
      manager = hotel_manager
      reservation_1 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,2],end_date:[2020,3,10]
        )
      )
      reservation_2 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,4,1],end_date:[2020,4,8]
        )
      )
      reservation_3 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,3],end_date:[2020,3,7]
        )
      )
      reservation_4 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,4],end_date:[2020,3,5]
        )
      )
      manager.reservations << reservation_1
      manager.reservations << reservation_2
      manager.reservations << reservation_3
      manager.reservations << reservation_4

      date_to_check = [2020,3,5]
      result = manager.check_date_reservations(date_to_check)

      expect(result).must_match (/2020-03-02/)
      expect(result).must_match (/2020-03-10/)
      expect(result).must_match (/2020-03-03/)
      expect(result).must_match (/2020-03-07/)
      expect(result).wont_match (/2020-03-04/)
      expect(result).wont_match (/2020-03-05/)
      expect(result).wont_match (/2020-04-01/)
      expect(result).wont_match (/2020-04-08/)

    end 
  end 
  
  describe "room_reservations_and_date method" do 
    
    it "return a list of reservations under a room and within date_range" do 
      manager = hotel_manager
      reservation_1 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,2],end_date:[2020,3,10]
        ),
        room_num:1
      )
      reservation_2 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,4,1],end_date:[2020,4,8]
        ),
        room_num:2
      )
      reservation_3 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,3],end_date:[2020,3,7]
        ),
        room_num:2
      )
      reservation_4 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,7],end_date:[2020,3,9]
        ),
        room_num:2
      )
      manager.reservations << reservation_1
      manager.reservations << reservation_2
      manager.reservations << reservation_3
      manager.reservations << reservation_4
    
      date_range = Hotel::DateRange.new(
        start_date:[2020,3,4],end_date:[2020,3,20]
      )
      result = manager.room_reservations_and_date(2,date_range)
      expect(result).must_match (/2020-03-03/)
      expect(result).must_match (/2020-03-07/)
      expect(result).must_match (/2020-03-07/)
      expect(result).must_match (/2020-03-09/)
      expect(result).wont_match (/2020-04-01/)
      expect(result).wont_match (/2020-04-08/)
      expect(result).wont_match (/2020-03-10/)
    end 
  end
  xdescribe "#request_reservation_wave1" do
    before do 
      manager = hotel_manager
      start_date = [2020,3,4]
      end_date = [2020,3,5]
      @new_reservation = manager.request_reservation(start_date,end_date)
    end 
    it "return an instance of reservation" do
        expect(@new_reservation).must_be_kind_of Hotel::Reservation
    end  
    it "return room number 1 to 20" do 
      expect(@new_reservation.room_num).must_be_kind_of Integer
      expect(@new_reservation.room_num).must_be :>, 0
      expect(@new_reservation.room_num).must_be :<, 21
    end 
    it "return reservation_id" do 
      expect(@new_reservation.reservation_id).must_be_kind_of Integer
    end 
    it "return correct start/end date" do 
      expect(@new_reservation.date_range.start_date).must_equal Date.new(2020,3,4)
    end 
  end 

  describe "#request_reservation for wave 2 Check if room added to reservations pool" do 
    it "new reservation is an instance of reservation" do 
      skip 
      manager = hotel_manager
      reservation_2 = manager.request_reservation([2020,3,6],[2020,3,8])
      expect(reservation_2).must_be_kind_of Hotel::Reservation
    end 
    it "reservation pool will have new reservation" do 
      manager = hotel_manager
      reservation_1 = manager.request_reservation([2020,4,9],[2020,4,10])
      reservation_2 = manager.request_reservation([2020,3,6],[2020,3,8])
      expect(manager.reservations.include?(reservation_1)).must_equal true
      expect(manager.reservations.include?(reservation_2)).must_equal true
    end 
    it "will raise ArgumentError if all rooms are already booked for that date" do 
      manager = hotel_manager
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:1)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:2)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:3)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:4)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:5)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:6)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:7)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:8)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:9)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:10)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:11)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:12)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:13)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:14)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:15)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:16)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:17)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:18)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:19)
      manager.reservations << Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,10]),room_num:20)  
      expect{manager.request_reservation([2020,3,3],[2020,3,7])}.must_raise ArgumentError
    end 
    it "will not randomly assign same room same dates" do
      manager = hotel_manager
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      manager.request_reservation([2020,4,9],[2020,4,10])
      room_num_array = manager.reservations.map {|bookings|bookings.room_num.to_i}
      expect(room_num_array.sum).must_equal 210
    end 

  end 


end 