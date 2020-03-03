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

  describe "#add" do
    it "adds a new reservation to a list of reservations" do
      reservation = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "3rd May 2020", end_date: "6th May 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation)
      expect(front_desk.reservations.first).must_be_instance_of Hotel::Reservation
      expect(front_desk.reservations.first.room).must_be_instance_of Hotel::Room
    end
  end

  describe "#get_bookings" do
    it "gives an instance of Reservation in a list of reservations" do
      reservation = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation)
      expect(front_desk.get_bookings("2nd Apr 2020").first).must_be_instance_of Hotel::Reservation
    end

    it "gives a correct Reservation for a specified date" do
      reservation = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation)
      expect(front_desk.get_bookings("2nd Apr 2020").first).must_equal reservation
    end

    it "gives a correct Reservation if a specified date coinsides with a check-in or check-out date" do
      reservation = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation)
      expect(front_desk.get_bookings("1st Apr 2020").first).must_equal reservation
      expect(front_desk.get_bookings("3rd Apr 2020").first).must_equal reservation
    end

    it "returns an empty array if no reservations are found" do
      reservation = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation)
      expect(front_desk.get_bookings("21st Apr 2020")).must_equal []
    end

    it "gives a correct array length if a couple of reservations occured on a specified date" do
      reservation_1 = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      reservation_2 = Hotel::Reservation.new(room: Hotel::Room.new(2), start_date: "30th Mar 2020", end_date: "7th Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation_1)
      front_desk.add_reservation(reservation_2)

      expect(front_desk.get_bookings("1st Apr 2020").length).must_equal 2
    end
  end

  describe "#get_room_bookings" do
    it "returns an instance of Reservation in a list" do
      reservation = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation)
      expect(front_desk.get_room_bookings(1, "2nd Apr 2020", "4th Apr 2020").first).must_be_instance_of Hotel::Reservation
    end

    it "returns all instances of Reservations if they all satisfy parameters" do
      reservation_1 = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      reservation_2 = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "30th Mar 2020", end_date: "7th Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation_1)
      front_desk.add_reservation(reservation_2)
      expect(front_desk.get_room_bookings(1, "2nd Apr 2020", "4th Apr 2020").length).must_equal 2
      expect(front_desk.get_room_bookings(1, "2nd Apr 2020", "4th Apr 2020").first).must_equal reservation_1
      expect(front_desk.get_room_bookings(1, "2nd Apr 2020", "4th Apr 2020").last).must_equal reservation_2
    end

    it "returns an empty array if no matches of dates found for the room" do
      reservation_1 = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      reservation_2 = Hotel::Reservation.new(room: Hotel::Room.new(1), start_date: "30th Mar 2020", end_date: "7th Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation_1)
      front_desk.add_reservation(reservation_2)
      expect(front_desk.get_room_bookings(1, "8th Apr 2020", "10th Apr 2020")).must_equal []
    end

    it "returns an empty array if a specified room had no reservations" do
      reservation_1 = Hotel::Reservation.new(room: Hotel::Room.new(2), start_date: "1st Apr 2020", end_date: "3rd Apr 2020")
      reservation_2 = Hotel::Reservation.new(room: Hotel::Room.new(2), start_date: "30th Mar 2020", end_date: "7th Apr 2020")
      front_desk = Hotel::FrontDesk.new
      front_desk.add_reservation(reservation_1)
      front_desk.add_reservation(reservation_2)
      expect(front_desk.get_room_bookings(1, "8th Apr 2020", "10th Apr 2020")).must_equal []
    end
  end
end
