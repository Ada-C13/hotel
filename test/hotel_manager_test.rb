require_relative "test_helper"

describe "HotelManager class" do
  before do
    @hotel_manager = Hotel::HotelManager.new()
    @date = Date.new(2020, 8, 10)

    @date_range = Hotel::DateRange.new(Date.new(2020, 8, 10), Date.new(2020, 8, 15))
  end

  # wave 1
  describe "wave 1" do
    describe "#initialize" do
      it "returns a list of rooms" do
        rooms = @hotel_manager.rooms
        expect(rooms).must_be_kind_of Array

        rooms.each do |room|
          expect(room).must_be_instance_of Hotel::Room
        end 

        expect(rooms[0].number).must_equal 1
      end
    end

    describe "#reservations_per_room" do 
      it "returns a list of reservations for the specific room" do 

        room = @hotel_manager.rooms[0]

        reservations = @hotel_manager.reservations_per_room(@date_range, room)

        expect(reservations).must_be_kind_of Array

        reservations.each do |reservation| 
          expect(reservation).must_be_kind_of Hotel::Reservation
        end 
      end 
    end 

    # TO DO (think if there are more tests to add)
    describe "#make_reservation" do 
      it "takes a date range and returns a Reservation" do 
        reservation = @hotel_manager.make_reservation(@date_range)

        expect(reservation).must_be_instance_of Hotel::Reservation 
        expect(reservation.room).must_be_instance_of Hotel::Room
        expect(reservation.room.number).must_equal 1
      end 

      it "raise an Arugment error after making 20 reservations for the same date range" do 

        20.times do 
          @hotel_manager.make_reservation(@date_range)
        end 
 
        expect{
          @hotel_manager.make_reservation(@date_range)
        }.must_raise ArgumentError
      end 
    end 


    describe "#find_all_reservations" do 

      it "raises an ArgumentError when there is no reservation" do 
        expect{@hotel_manager.find_all_reservations(@date)}.must_raise ArgumentError
      end 


      it "returns 5 reservations on the specific date" do 
        5.times do 
          @hotel_manager.make_reservation(@date_range)
        end 

        reservations = @hotel_manager.find_all_reservations(@date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 5
        expect(reservations[0]).must_be_kind_of Hotel::Reservation
      end 

      it "returns 5 reservations on the specific date" do 

        @hotel_manager.make_reservation(@date_range)

        # TO DO
        # no overlap
        test_date_range = Hotel::DateRange.new(Date.new(2020, 07, 11), Date.new(2020, 07, 13))

        10.times do 
          @hotel_manager.make_reservation(test_date_range)
        end 

        # overlap
        test_date_range_2 = Hotel::DateRange.new(Date.new(2020, 07, 6), Date.new(2020, 07, 12))

        9.times do 
          @hotel_manager.make_reservation(test_date_range_2)
        end 


        test_date = Date.new(2020, 07, 11)
        reservations = @hotel_manager.find_all_reservations(test_date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 19
        expect(reservations.last.room.number).must_equal 19
      end 
    end 

    describe "#add_reservation" do 
      it "adds a reservation in reservations" do 
        room = Hotel::Room.new(8)
        reservation = Hotel::Reservation.new(@date_range, room)

        reservations = @hotel_manager.add_reservation(reservation)

        expect(reservations).must_be_instance_of Array
        expect(reservations.length).must_equal 1
        expect(reservations[0].room.number).must_equal 8
      end 
    end 
  end

  describe "wave 2" do 
    describe "#available_room_numbers" do 
      it "returns available rooms for the given date range" do 

        available_room_numbers = @hotel_manager.available_room_numbers(@date_range)

        expect(available_room_numbers).must_be_kind_of Array
        expect(available_room_numbers.length).must_equal 20 

        expect(available_room_numbers[0]).must_be_kind_of Integer
      end 

      it "returns the room #1 after making 20 reservations in a different date range" do 
        date_range = Hotel::DateRange.new(Date.new(2020, 8, 10), Date.new(2020, 8, 15))
        new_date_range = Hotel::DateRange.new(Date.new(2020, 8, 1), Date.new(2020, 8, 6))

        20.times do 
          @hotel_manager.make_reservation(date_range)
        end 

        expect(@hotel_manager.available_room_numbers(new_date_range)[0]).must_equal 1
      end 

      it "returns the room #20 after making 19 reservations for the same date range" do 
        19.times do 
          @hotel_manager.make_reservation(@date_range)
        end 
 
        expect(@hotel_manager.available_room_numbers(@date_range)[0]).must_equal 20
      end 
    end 
  end 
end
