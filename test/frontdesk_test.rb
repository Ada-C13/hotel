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
  end

  describe "add_reservation" do

    before do
        @start_date = "2019-1-4"
        @end_date = "2019-1-7"
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
        @front_desk.add_reservation("2019-1-4","2019-1-7", 1)
        @front_desk.add_reservation("2019-1-1","2019-1-5", 1)
        @front_desk.add_reservation("2019-1-4","2019-1-5", 1)
        @front_desk.add_reservation("2019-1-3","2019-1-6", 1)
      end

    it "can return an array of reservations by date" do
      expect(@front_desk.find_reservation_by_date(Time.parse("2019-1-4"))).must_be_kind_of Array
    end

    it "can return an accurate list of reservations by date" do
      reservation_by_date = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))
      
      expect(reservation_by_date.length).must_equal 4
    end

    it "can return an accurate first reservation by date" do
      reservation_by_date = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))
      
      expect(reservation_by_date.first.start_date).must_equal Time.parse("2019-1-4")
    end

    it "can return an accurate last reservation by date" do
      reservation_by_date = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))
      
      expect(reservation_by_date.last.start_date).must_equal Time.parse("2019-1-3")
    end

    it "can return an array of reservations and those reservations are Reservation class" do
      reservation = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))[0]
      
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "assign room" do

    it "assigns a room to a new reservation" do
      @front_desk = Hotel::FrontDesk.new()
      reservation = @front_desk.add_reservation("2019-1-4","2019-1-7", 1)
      
      expect(reservation[0].assigned_room.empty?).must_equal false
    end

    it "assigns a different room to each reservation" do
      skip
    end

    it "returns an error if no rooms are available" do
      @front_desk = Hotel::FrontDesk.new()
      20.times do @front_desk.add_reservation("2019-1-4","2019-1-7", 1) 
        end
      
      expect{ @front_desk.add_reservation("2019-1-4","2019-1-7", 1, 1) }.must_raise ArgumentError
    end

    it "can start a reservation on the same day that another in the same room ends" do
      @front_desk = Hotel::FrontDesk.new()
      20.times do @front_desk.add_reservation("2019-1-4","2019-1-7", 1) 
        end
      @front_desk.add_reservation("2019-1-7","2019-1-9", 1)
      reservation = @front_desk.find_reservation_by_date(Time.parse("2019-1-8"))
      
      expect(reservation[0].assigned_room.empty?).must_equal false
    end

  end

  describe "find_available_room_by_date" do
    before do
      @front_desk = Hotel::FrontDesk.new()
      @front_desk.add_reservation("2019-1-4","2019-1-7", 1)
      @front_desk.add_reservation("2019-1-1","2019-1-5", 1)
      @front_desk.add_reservation("2019-1-4","2019-1-5", 1)
      @front_desk.add_reservation("2019-1-3","2019-1-6", 1)
    end

    it "can return an array of available rooms by date" do
      expect(@front_desk.find_available_room_by_date(Time.parse("2019-1-4"))).must_be_kind_of Array
    end
  
    it "can return an accurate list of available rooms by date" do
      available_rooms = @front_desk.find_available_room_by_date(Time.parse("2019-1-4"))
      expect(available_rooms.length).must_equal 16
    end
  end
  #   xit "can return an array of Integers (room numbers)" do

  #   end

    #   it "can return an accurate list of reservations by date" do
    #     reservation_by_date = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))
    #     expect(reservation_by_date.length).must_equal 4
    #   end
  
    #   it "can return an accurate first reservation by date" do
    #     reservation_by_date = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))
    #     expect(reservation_by_date.first.start_date).must_equal Time.parse("2019-1-4")
    #   end
  
    #   it "can return an accurate last reservation by date" do
    #     reservation_by_date = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))
    #     expect(reservation_by_date.last.start_date).must_equal Time.parse("2019-1-3")
    #   end
  
    #   it "can return an array of reservations and those reservations are Reservation class" do
    #     reservation = @front_desk.find_reservation_by_date(Time.parse("2019-1-4"))[0]
    #     expect(reservation).must_be_kind_of Hotel::Reservation
    #   end
    # end
  #end
end