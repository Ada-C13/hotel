require_relative 'test_helper'

describe "Hotel Controller" do
  before do
    @front_desk = Hotel::HotelController.new(20)
    @front_desk.reserve_room(Date.new(2020,01,05), Date.new(2020,01,10), "Alex")
    @front_desk.reserve_room(Date.new(2020,03,05), Date.new(2020,03,10), "Macy")
    @front_desk.reserve_room(Date.new(2020,03,12), Date.new(2020,03,15), "Leo")

  end

  describe "Initalizer" do
    it "is an instance of Hotel Controller" do
      expect(@front_desk).must_be_kind_of Hotel::HotelController  
    end

    it "will create an array of rooms according to the number of room provided as an argument" do
      expect(@front_desk.room_list.length).must_equal 20
    end
  end

  describe "reserve_room" do
    it "will create a new Reservation class and push into Reservation List" do
      expect(@front_desk.reservation_list.length).must_equal 3
      expect(@front_desk.reservation_list[1]).must_be_kind_of Hotel::Reservation
      expect(@front_desk.reservation_list[1].date_range).must_be_kind_of Hotel::DateRange
    end
  end

  describe "reservations" do
    it "will return a list of reservation on that specific date" do
      check_date = @front_desk.reservations(Date.new(2020,01,05))
    
      expect(check_date).must_be_kind_of Array
      expect(check_date.length).must_equal 1
      expect{@front_desk.reservations(Date.new(2020,10,05))}.must_raise ArgumentError
    end
  end

  describe "get_list_of_reservation" do
    @front_desk = Hotel::HotelController.new(20)
    it "will return a list of reservations for a specific room in that date range" do
    room_reservation_list =  @front_desk.get_list_of_reservations("Room 1", Date.new(2020,03,01), Date.new(2020,03,31,))
    expect(room_reservation_list.length).must_equal 2
    end
  end

  describe "available_rooms" do
    it "will return a list of avaliable_rooms" do
      available_list = @front_desk.available_rooms(Date.new(2020,03,01), Date.new(2020,03,31,))
      available_list_two = @front_desk.available_rooms(Date.new(2020,10,01), Date.new(2020,10,31,))
      expect(available_list.length).must_equal 19
      expect(available_list_two.length).must_equal 20
    end
  end

  describe "create_hotel_block" do
    it "will create a hotel_block, create the correct amount of reservation according to the block" do
      hotel_block = @front_desk.create_hotel_block(Date.new(2020,06,20), Date.new(2020,06,25), 5)
      
      
      expect(hotel_block).must_be_kind_of Hotel::BlockReservation 
      expect(@front_desk.reservations(Date.new(2020,06,20)).length).must_equal 5
      expect{@front_desk.create_hotel_block(Date.new(2020,06,20), Date.new(2020,06,25), 10)}.must_raise ArgumentError
    end
  end

  describe "check_hotel_block_list_availability" do
    it "will retrun the rooms from hotel block that is available" do
      hotel_block = @front_desk.create_hotel_block(Date.new(2020,06,20), Date.new(2020,06,25), 5)
      rooms_from_block = @front_desk.check_hotel_block_list_availability(1)

      expect(rooms_from_block.length).must_equal 5
      expect{@front_desk.check_hotel_block_list_availability(10)}.must_raise ArgumentError
    end
  end

  describe "reserve_room_hotel_block(hotel_block_id, customer_name, specific_room)" do
    it "will reserve room within the hotel block" do
    @front_desk.create_hotel_block(Date.new(2020,06,20), Date.new(2020,06,25), 5)
    @front_desk.create_hotel_block(Date.new(2020,06,20), Date.new(2020,06,25), 4)
    
    @front_desk.reserve_room_hotel_block(1, "Lily", "Room 1")
    
    expect(@front_desk.get_list_of_reservations("Room 1",Date.new(2020,06,20), Date.new(2020,06,25))[0].status).must_equal :reserved_hotel_block 
    expect(@front_desk.get_list_of_reservations("Room 1",Date.new(2020,06,20), Date.new(2020,06,25))[0].customer_name).must_equal "Lily"
    expect{@front_desk.reserve_room_hotel_block(1, "Peter", "Room 1")}.must_raise ArgumentError
    expect{@front_desk.reserve_room_hotel_block(5, "Hello Kitty", 1)}.must_raise ArgumentError
    end 
  end
end 
 
