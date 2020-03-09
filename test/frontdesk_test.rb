require_relative 'test_helper'

describe "Front Desk" do
  
  describe "Initialize" do

    before do
      @front_desk = Hotel::FrontDesk.new
    end

    it "can create an instance of FrontDesk" do
      expect(@front_desk).must_be_kind_of Hotel::FrontDesk
    end

    it "can return a list of 20 rooms" do
      expect(@front_desk.rooms).must_equal [*1..20]
    end

    it "can return a list of 20 rooms represented by Integers" do
      expect(@front_desk.rooms[0]).must_be_kind_of Integer
    end

    it "can return an empty reservation collection when initialized (before reservations have been added)" do
      expect(@front_desk.all_reservations.empty?).must_equal true
    end

    it "can return the reservation collection as an Array" do
      expect(@front_desk.all_reservations).must_be_kind_of Array
    end
  end

  describe "add_reservation" do

    before do
        @start_date = Date.new(2019, 1, 4)
        @end_date = Date.new(2019, 1, 7)
        @front_desk = Hotel::FrontDesk.new()
      end

    it "can add a new reservation to the reservation collection" do
        @front_desk.add_reservation(@start_date, @end_date, 1)
        
        expect(@front_desk.all_reservations.length).must_equal 1
    end

    it "can return a list of 20 rooms" do
      expect(@front_desk.rooms).must_equal [*1..20]
    end
  end

  describe "find_reservation_by_date" do

    before do
        @front_desk = Hotel::FrontDesk.new()
        @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1)
        @front_desk.add_reservation(Date.new(2019, 1, 1),Date.new(2019, 1, 5), 1)
        @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 5), 1)
        @front_desk.add_reservation(Date.new(2019, 1, 3),Date.new(2019, 1, 6), 1)
      end

    it "can return an array of reservations by date" do
      expect(@front_desk.find_reservation_by_date(Date.new(2019, 1, 4))).must_be_kind_of Array
    end

    it "can return an accurate list of reservations by date" do
      reservation_by_date = @front_desk.find_reservation_by_date(Date.new(2019, 1, 4))
      
      expect(reservation_by_date.length).must_equal 4
    end

    it "can return an accurate first reservation by date" do
      reservation_by_date = @front_desk.find_reservation_by_date(Date.new(2019, 1, 4))
      
      expect(reservation_by_date.first.start_date).must_equal Date.new(2019, 1, 4)
    end

    it "can return an accurate last reservation by date" do
      reservation_by_date = @front_desk.find_reservation_by_date(Date.new(2019, 1, 4))
      
      expect(reservation_by_date.last.start_date).must_equal Date.new(2019, 1, 3)
    end

    it "can return an array of reservations and those reservations are Reservation class" do
      reservation = @front_desk.find_reservation_by_date(Date.new(2019, 1, 4))[0]
      
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "returns a single reservation for hotel blocks based on date" do
      @front_desk = Hotel::FrontDesk.new()
      block_to_find = @front_desk.add_block_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 3, 0.10, "banana")

      reservation = @front_desk.find_reservation_by_date(Date.new(2019, 1, 4))

      expect(reservation).must_equal block_to_find
    end

  end

  describe "assign room" do

    it "assigns a room to a new reservation" do
      @front_desk = Hotel::FrontDesk.new()
      reservation = @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1)
      
      expect(reservation[0].assigned_room.empty?).must_equal false
    end

    it "returns an error if no rooms are available" do
      @front_desk = Hotel::FrontDesk.new()
      20.times do @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1) 
        end
      
      expect{ @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1, 1) }.must_raise ArgumentError
    end

    it "returns an error if more than one room is requested" do
      @front_desk = Hotel::FrontDesk.new()
      
      expect{ @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 4) }.must_raise ArgumentError
    end

    it "can start a reservation on the same day that another in the same room ends" do
      @front_desk = Hotel::FrontDesk.new()
      20.times do @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1) 
        end
      @front_desk.add_reservation(Date.new(2019, 1, 7),Date.new(2019, 1, 9), 1)
      reservation = @front_desk.find_reservation_by_date(Date.new(2019, 1, 8))
      
      expect(reservation[0].assigned_room.empty?).must_equal false
    end

  end

  describe "add_block_reservation" do
    it "returns a block reservation when a block is added" do
      @front_desk = Hotel::FrontDesk.new()
      @front_desk.add_block_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 3, 0.10, "banana")

      expect(@front_desk.all_reservations[0].block).must_equal :BLOCK
    end

    it "raises an error if only one room is requested" do
      @front_desk = Hotel::FrontDesk.new()
      
      expect{ @front_desk.add_block_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1, 0.10, "bananas") }.must_raise ArgumentError
    end

    #I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
    #{TODO}MOVE THIS TO BLOCK SECTION
    it "returns an error if not enough rooms are available for a block" do
      @front_desk = Hotel::FrontDesk.new()
      15.times do @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1) 
        end
      
      expect{ @front_desk.add_block_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 5, 1) }.must_raise ArgumentError
    end
  end

  describe "find_available_room_by_date" do
    before do
      @front_desk = Hotel::FrontDesk.new()
      @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 1)
      @front_desk.add_reservation(Date.new(2019, 1, 1),Date.new(2019, 1, 5), 1)
      @front_desk.add_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 5), 1)
      @front_desk.add_reservation(Date.new(2019, 1, 3),Date.new(2019, 1, 6), 1)
    end

    it "can return an array of available rooms by date" do
      expect(@front_desk.find_available_room_by_date(Date.new(2019, 1, 4))).must_be_kind_of Array
    end

    it "can return an array of Integers (room numbers)" do
      available_rooms = @front_desk.find_available_room_by_date(Date.new(2019, 1, 4))
      expect(available_rooms[0]).must_be_kind_of Integer
    end
  
    it "can return an accurate list of available rooms by date" do
      available_rooms = @front_desk.find_available_room_by_date(Date.new(2019, 1, 4))
      expect(available_rooms.length).must_equal 16
    end

    it "can return an accurate list of available rooms by date when blocks are involved" do
      @front_desk.add_block_reservation(Date.new(2019, 1, 3),Date.new(2019, 1, 6), 3, 0.10, "banana")
      available_rooms = @front_desk.find_available_room_by_date(Date.new(2019, 1, 4))
      expect(available_rooms.length).must_equal 14
    end

    it "can return an accurate list of available rooms and those rooms are unique" do
      available_rooms = @front_desk.find_available_room_by_date(Date.new(2019, 1, 4))
      expect(available_rooms.length).must_equal available_rooms.uniq.length
    end

    it "can return an accurate first available room by date" do
      room_by_date = @front_desk.find_available_room_by_date((Date.new(2019, 1, 4)))
      expect(room_by_date.first).must_equal room_by_date[0]
    end

    it "can return an accurate last available room by date" do
      room_by_date = @front_desk.find_available_room_by_date((Date.new(2019, 1, 4)))
      expect(room_by_date.last).must_equal room_by_date[-1]
    end
  end
  
  describe "find_block_by_block_key" do
    before do
      @front_desk = Hotel::FrontDesk.new()
      block = @front_desk.add_block_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 5, 0.20, "bananas")
    end

    it "can return a block using a block_key" do
      found_block = @front_desk.find_block_by_block_key(Date.new(2019, 1, 4),"bananas")
      expect(found_block[0].block_key).must_equal "bananas"
    end
  end

  describe "update_block" do
    before do
      @front_desk = Hotel::FrontDesk.new()
      block = @front_desk.add_block_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 5, 0.20, "bananas")
    end

    it "can return an updated block (num_rooms - 1) using a block_key" do
      found_block = @front_desk.update_block(Date.new(2019, 1, 4),"bananas")
      expect(found_block.num_rooms).must_equal 4
    end

    it "raises an ArgumentError if no rooms are left in the block" do
      @front_desk.update_block(Date.new(2019, 1, 4),"bananas")
      @front_desk.update_block(Date.new(2019, 1, 4),"bananas")
      @front_desk.update_block(Date.new(2019, 1, 4),"bananas")
      @front_desk.update_block(Date.new(2019, 1, 4),"bananas")
      @front_desk.update_block(Date.new(2019, 1, 4),"bananas")

      expect{ @front_desk.update_block(Date.new(2019, 1, 4),"bananas") }.must_raise ArgumentError
    end
  end

  describe "reserve_from_block" do
    before do
      @front_desk = Hotel::FrontDesk.new()
      @front_desk.add_block_reservation(Date.new(2019, 1, 4),Date.new(2019, 1, 7), 5, 0.20, "bananas")
    end

    it "can create a new single reservation with block_key" do
      expect(@front_desk.reserve_from_block(Date.new(2019, 1, 4), "bananas")).must_be_kind_of Hotel::Reservation
    end

  end


    # it "can return an accurate list of available rooms and those rooms are unique" do
    #   available_rooms = @front_desk.find_available_room_by_date(Date.new(2019, 1, 4))
    #   expect(available_rooms.length).must_equal available_rooms.uniq.length
    # end

    # it "can return an accurate first available room by date" do
    #   room_by_date = @front_desk.find_available_room_by_date(Date.parse(Date.new(2019, 1, 4)))
    #   expect(room_by_date.first).must_equal room_by_date[0]
    # end

    # it "can return an accurate last available room by date" do
    #   room_by_date = @front_desk.find_available_room_by_date(Date.parse(Date.new(2019, 1, 4)))
    #   expect(room_by_date.last).must_equal 20
    # end
  #end
end