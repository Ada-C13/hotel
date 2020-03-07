require 'date'
require_relative "test_helper"

describe Hotel::HotelSystem do

	describe "#initialize" do

		before do
			@hotel = Hotel::HotelSystem.new
			range = Hotel::DateRange.new(Date.new(2019, 12, 1), Date.new(2019, 12, 5))
			range_two = Hotel::DateRange.new(Date.new(2019, 11, 27), Date.new(2019, 12, 2))
			range_three = Hotel::DateRange.new(Date.new(2019, 12, 3), Date.new(2019, 12, 9))
			@hotel.reservations << Hotel::Reservation.new(Hotel::Room.new(3), range)
			@hotel.reservations << Hotel::Reservation.new(Hotel::Room.new(4), range_two)
			@hotel.reservations << Hotel::Reservation.new(Hotel::Room.new(5), range_three)
		end

		it "creates an instance of HotelSystem" do
			expect(@hotel).must_be_instance_of Hotel::HotelSystem
		end

		it "contains an array of all rooms" do
			expect(@hotel.rooms).must_be_instance_of Array
			expect(@hotel.rooms.length).must_equal 20
		end

		it "contains a list of all reservations" do
			expect(@hotel.reservations).must_be_instance_of Array
			expect(@hotel.reservations.length).must_equal 3
		end

	end

	describe "#make_reservation" do

		before do
			@hotel = Hotel::HotelSystem.new
			range_start = Date.new(2019, 03, 05)
			range_end = Date.new(2019, 03, 10)
			@range = Hotel::DateRange.new(range_start, range_end)
			@new_res = @hotel.make_reservation(@range)
		end
		
		it "creates an instance of Reservation" do
			expect(@new_res).must_be_instance_of Hotel::Reservation
		end
		
		it "assigns a Room to Reservation" do
			expect(@new_res.room).must_be_instance_of Hotel::Room
		end

		it "correctly adds Reservation to Room's list of reservations" do
			expect(@new_res.room.reservations).must_include @new_res
		end

		describe "#room_finder helper method" do

			it "returns an instance of Room" do
				found_room = @hotel.room_finder(@range)
				expect(found_room).must_be_instance_of Array
				expect(found_room[0]).must_be_instance_of Hotel::Room
			end

			it "must assign a room that has not been assigned yet for each reservation" do
				available = @hotel.rooms.dup
				assigned = []

				19.times do 
					res = @hotel.make_reservation(@range)
					assigned << res.room
				end

				expect((available & assigned).length).must_equal 19
			end

			it "allows bookings where prior booking in same room ends on start date of next booking" do
				18.times do 
					@hotel.make_reservation(@range)
				end

				range_start = Date.new(2019, 03, 10)
				range_end = Date.new(2019, 03, 15)
				allowable_range = Hotel::DateRange.new(range_start, range_end)

				expect(@hotel.make_reservation(allowable_range)).must_be_instance_of Hotel::Reservation
			end

			it "raises an ArgumentError if all rooms are taken for a date range" do
				19.times do
					@hotel.make_reservation(@range)
				end

				expect{@hotel.make_reservation(@range)}.must_raise ArgumentError
			end

			it "raises an ArgumentError if all rooms are taken for overlapping date range" do
				19.times do
					@hotel.make_reservation(@range)
				end

				inval_range = Hotel::DateRange.new(Date.new(2019, 03, 03), Date.new(2019, 03, 10))

				expect{@hotel.make_reservation(inval_range)}.must_raise ArgumentError
			end
		end
	end

	describe "#get_reservations_by_date" do

		before do
			@hotel = Hotel::HotelSystem.new

			range = Hotel::DateRange.new(Date.new(2019, 12, 1), Date.new(2019, 12, 5))
			range_two = Hotel::DateRange.new(Date.new(2019, 11, 27), Date.new(2019, 12, 2))
			range_three = Hotel::DateRange.new(Date.new(2019, 12, 3), Date.new(2019, 12, 9))
			@hotel.reservations << Hotel::Reservation.new(Hotel::Room.new(3), range)
			@hotel.reservations << Hotel::Reservation.new(Hotel::Room.new(4), range_two)
			@hotel.reservations << Hotel::Reservation.new(Hotel::Room.new(5), range_three)

			searching = Date.new(2019, 12, 1)
			@found_reservations = @hotel.get_reservations_by_date(searching)
		end

		it "returns an array of reservations" do
			expect(@found_reservations).must_be_instance_of Array
		end

		it "returns an array the size of 2" do
			expect(@found_reservations.length).must_equal 2
		end

	end

	describe "#get_reservations_by_room" do

		before do
			@hotel = Hotel::HotelSystem.new

			range = Hotel::DateRange.new(Date.new(2019, 12, 1), Date.new(2019, 12, 5))
			range_two = Hotel::DateRange.new(Date.new(2019, 11, 27), Date.new(2019, 12, 1))
			range_three = Hotel::DateRange.new(Date.new(2019, 12, 3), Date.new(2019, 12, 9))
			res_one = Hotel::Reservation.new(@hotel.rooms[0], range)
			res_two = Hotel::Reservation.new(@hotel.rooms[0], range_two)
			res_three = Hotel::Reservation.new(@hotel.rooms[4], range_three)
			@hotel.rooms[0].reservations << res_one
			@hotel.rooms[0].reservations << res_two
			@hotel.rooms[4].reservations << res_three
		end

		it "returns array length of 2" do
			searching = Hotel::DateRange.new(Date.new(2019, 11, 26), Date.new(2019, 12, 5))
			found_reservations = @hotel.get_reservations_by_room(@hotel.rooms[0], searching)

			expect(found_reservations.length).must_equal 2
		end

	end

	describe "#get_rooms_by_date" do

		before do
			@hotel = Hotel::HotelSystem.new

			range = Hotel::DateRange.new(Date.new(2019, 12, 1), Date.new(2019, 12, 5))
			range_two = Hotel::DateRange.new(Date.new(2019, 11, 27), Date.new(2019, 12, 2))
			range_three = Hotel::DateRange.new(Date.new(2019, 12, 1), Date.new(2019, 12, 9))
			@hotel.reservations << Hotel::Reservation.new(@hotel.rooms[0], range)
			@hotel.reservations << Hotel::Reservation.new(@hotel.rooms[3], range_two)
			@hotel.reservations << Hotel::Reservation.new(@hotel.rooms[4], range_three)

			searching = Date.new(2019, 12, 1)
			@available_rooms = @hotel.get_rooms_by_date(searching)
		end

		it "returns an array of 17 for available rooms on a date" do
			expect(@available_rooms.length).must_equal 17
		end

	end

	describe "#make_block" do
		
		before do
			@hotel = Hotel::HotelSystem.new

			rooms = [@hotel.rooms[19], @hotel.rooms[18], @hotel.rooms[17]]
			@range = Hotel::DateRange.new(Date.new(2019, 12, 23), Date.new(2019, 12, 28))
			@cost = 900
			@length_list = @hotel.reservations.length
			@length_list_room = @hotel.rooms[19].reservations.length
			@new_block = @hotel.make_block(rooms, @range, @cost)
		end

		it "return an instance of block" do
			expect(@new_block).must_be_instance_of Hotel::Block
		end

		it "assigns new reservations to reservations list in Hotel" do
			expect(@hotel.reservations.length).must_equal (@length_list + 3)
		end

		it "correctly adds Reservation to Room's list of reservations" do
			expect(@hotel.rooms[19].reservations.length).must_equal (@length_list_room + 1)
		end

		it "raises an exception if one of the rooms is already booked for range" do
			inval_rooms = [@hotel.rooms[15], @hotel.rooms[16], @hotel.rooms[17]]

			expect{@hotel.make_block(inval_rooms, @range, @cost)}.must_raise ArgumentError
		end
	end

	describe "#check_block_availability" do

	end

end