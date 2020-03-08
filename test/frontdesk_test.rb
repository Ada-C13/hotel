require_relative 'test_helper'

describe "FrontDesk class" do
  describe "#initialize" do
    it "creates an instance of FrontDesk class" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk).must_be_instance_of Hotel::FrontDesk
    end

    it "has 20 items in a rooms list" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.rooms.length).must_equal 20
    end

    it "creates a list of Room instances" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.rooms.last).must_be_instance_of Hotel::Room
    end

    it "gives a correct room number for the first instance in the rooms list" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.rooms.first.number).must_equal 1
    end

    it "gives a correct room number for the last instance in the rooms list" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.rooms.last.number).must_equal 20
    end

    it "creates a list of reservations" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.reservations).must_be_instance_of Array
    end
  end

  describe "#get_bookings" do
    it "gives an instance of Reservation in a list of reservations" do
      range = Hotel::DateRange.new(start_date: "3rd May 2020", end_date: "26th May 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.reserve_room(range)
      expect(front_desk.get_bookings("22nd May 2020").first).must_be_instance_of Hotel::Reservation
    end

    it "gives nil if a specified date coinsides with a check-out date" do
      range = Hotel::DateRange.new(start_date: "3rd May 2020", end_date: "26th May 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.reserve_room(range)
      expect(front_desk.get_bookings("26th May 2020").first).must_be_nil
    end

    it "returns an empty array if no reservations are found" do
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.reserve_room(range)
      expect(front_desk.get_bookings("21st Apr 2020")).must_equal []
    end
  end

  describe "#get_room_bookings" do
    it "returns an instance of Reservation in a list" do
      range = Hotel::DateRange.new(start_date: "2nd Apr 2020", end_date: "4th Apr 2020")
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.reserve_room(range)
      expect(front_desk.get_room_bookings(1, range).first).must_be_instance_of Hotel::Reservation
    end
  end

  describe "#get_available_rooms" do
    it "returns an instance of a Room in a list" do
      range = Hotel::DateRange.new(start_date: "2nd Apr 2020", end_date: "4th Apr 2020")
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.reserve_room(range)
      expect(front_desk.get_available_rooms(range).first).must_be_instance_of Hotel::Room
    end

    it "returns an array with length equal to the number of available rooms" do
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      18.times do |i|
        reservation = Hotel::Reservation.new(
          rooms: Hotel::Room.new(i+1), 
          date_range: Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020"))
        front_desk.reserve_room(range)
      end
      expect(front_desk.get_available_rooms(range).length).must_equal 2
    end

    it "returns an array with length 20 if no reservations made" do
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.get_available_rooms(range).length).must_equal 20
    end

    it "returns the first room if there is no reservation made for it" do
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.get_available_rooms(range).first.number).must_equal 1
    end
  end

  describe "#reserve_room" do
    it "returns an instance of a new Reservation" do
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.reserve_room(range)).must_be_instance_of Hotel::Reservation
    end

    it "returns a new Reservation" do
      range = Hotel::DateRange.new(start_date: "3rd Mar 2020", end_date: "5th Mar 2020")
      check_in = Date.parse("3rd Mar 2020")
      check_out = Date.parse("5th Mar 2020")
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.reserve_room(range).rooms.first).must_be_instance_of Hotel::Room
      expect(front_desk.reserve_room(range).date_range.start_date).must_equal check_in
      expect(front_desk.reserve_room(range).date_range.end_date).must_equal check_out
      expect(front_desk.reserve_room(range).cost).must_equal 400
    end

    it "adds a new Reservation to the list of reservations" do
      range = Hotel::DateRange.new(start_date: "3rd Mar 2020", end_date: "5th Mar 2020")
      check_in = Date.parse("3rd Mar 2020")
      check_out = Date.parse("5th Mar 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.reserve_room(range)
      expect(front_desk.reservations.size).must_equal 1
      expect(front_desk.reserve_room(range).rooms.first.number).must_equal 2
      expect(front_desk.reserve_room(range).rooms.first).must_be_instance_of Hotel::Room
      expect(front_desk.reserve_room(range).date_range.start_date).must_equal check_in
      expect(front_desk.reserve_room(range).date_range.end_date).must_equal check_out
      expect(front_desk.reserve_room(range).cost).must_equal 400
    end

    it "raises and Argument Error if there are no available rooms for provided dates" do
      range = Hotel::DateRange.new(start_date: "3rd Mar 2020", end_date: "5th Mar 2020")
      front_desk = Hotel::FrontDesk.new
      20.times do
        front_desk.reserve_room(range)
      end
      expect{front_desk.reserve_room(range)}.must_raise ArgumentError
    end

    it "does not let reserve a room if there is dates overlapping for 2 reservations" do
      range = Hotel::DateRange.new(start_date: "3rd Mar 2020", end_date: "5th Mar 2020")
      range2 = Hotel::DateRange.new(start_date: "4 Mar 2020", end_date: "5 Mar 2020")
      front_desk = Hotel::FrontDesk.new
      20.times do
        front_desk.reserve_room(range)
      end
      expect{front_desk.reserve_room(range2)}.must_raise ArgumentError
    end

    it "reserves a room if check_in and check-out are the same dates for 2 reservations" do
      range = Hotel::DateRange.new(start_date: "3rd Mar 2020", end_date: "5th Mar 2020")
      range2 = Hotel::DateRange.new(start_date: "5 Mar 2020", end_date: "7 Mar 2020")
      front_desk = Hotel::FrontDesk.new
      20.times do
        front_desk.reserve_room(range)
      end
      expect(front_desk.reserve_room(range2)).must_be_instance_of Hotel::Reservation
    end

    it "doesn't let reserve a room booked in a hotel block for a specific date" do
      range = Hotel::DateRange.new(start_date: "3 Mar 2020", end_date: "5 Mar 2020")
      front_desk = Hotel::FrontDesk.new
      4.times do
        front_desk.reserve_block(range, 5, 100)
      end
      expect{front_desk.reserve_room("4 Mar 2020")}.must_raise ArgumentError
    end
  end

  describe "#reserve_block" do
    it "adds hotel block to reservations so that's they are no longer available" do
      front_desk = Hotel::FrontDesk.new
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk.reserve_block(range, 4, 150)
      expect(front_desk.reservations.size).must_equal 1
      expect(front_desk.reservations.first.rooms.first.number).must_equal 1
    end

    it "reserves a hotel block for a specific date" do
      front_desk = Hotel::FrontDesk.new
      booking = front_desk.reserve_block("3 Mar 2020", 2, 150)
      expect(booking.date_range.start_date).must_equal Date.parse("3 Mar 2020")
      expect(booking.date_range.end_date).must_equal Date.parse("4 Mar 2020")
      expect(booking.rooms.length).must_equal 2
      expect(booking.cost).must_equal 300
    end

    it "returns an instance of a new HotelBlock" do
      front_desk = Hotel::FrontDesk.new
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      expect(front_desk.reserve_block(range, 3, 150)).must_be_instance_of Hotel::HotelBlock
    end

    it "doesn't let reserve another block with already reserved rooms" do
      front_desk = Hotel::FrontDesk.new
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      3.times do
        front_desk.reserve_block(range, 5, 150)
      end
      front_desk.reserve_block(range, 2, 150)
      expect{front_desk.reserve_block(range, 4, 150)}.must_raise ArgumentError
    end

    it "doesn't let reserve a room reserved in a hotel block for date range" do
      front_desk = Hotel::FrontDesk.new
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      4.times do
        front_desk.reserve_block(range, 5, 150)
      end
      expect{front_desk.reserve_room(range)}.must_raise ArgumentError
    end

    it "doesn't let reserve a block for specific date if another block was created" do
      front_desk = Hotel::FrontDesk.new
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      4.times do
        front_desk.reserve_block(range, 5, 150)
      end
      expect{front_desk.reserve_room("2 Apr 2020")}.must_raise ArgumentError
    end

    it "shows a reservation made from a hotel block from the list of reservations" do
      front_desk = Hotel::FrontDesk.new
      range = Hotel::DateRange.new(start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk.reserve_block(range, 5, 150)
      date = "2 Apr 2020"
      expect(front_desk.get_bookings(date).length).must_equal 1
      expect(front_desk.get_bookings(date).first.cost).must_equal 1500
    end
  end
end
