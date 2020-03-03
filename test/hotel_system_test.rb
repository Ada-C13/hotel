require 'date'
require_relative "test_helper"

describe Hotel::HotelSystem do

	describe "Wave 1 Requirements" do
		before do
			@hotel = Hotel::HotelSystem.new

			@hotel.reservations << Hotel::Reservation.new(3, Date.new(2019, 12, 1), Date.new(2019, 12, 5))
			@hotel.reservations << Hotel::Reservation.new(4, Date.new(2019, 11, 27), Date.new(2019, 12, 2))
			@hotel.reservations << Hotel::Reservation.new(5, Date.new(2019, 12, 3), Date.new(2019, 12, 9))
		end

		it "creates an instance of Hotel" do
			expect(@hotel).must_be_instance_of Hotel::HotelSystem
			expect(@hotel.reservations).must_be_instance_of Array
			expect(@hotel.rooms).must_be_instance_of Array
		end
		
		it "returns an array of all rooms at the hotel" do

			expect(@hotel.rooms[0]).must_equal 1
			expect(@hotel.rooms[19]).must_equal 20
		end

		it "returns an array of all rooms with reservation including a specific date" do
			date = Date.new(2019, 12, 1)
			expect(@hotel.get_reservations_by_date(date)).must_be_instance_of Array
			expect(@hotel.get_reservations_by_date(date).length).must_equal 2
		end

		it "can access the list of reservations for a specified room and a given date range" do
			room = 10
			range_start = Date.new(2019, 12, 2)
			range_end = Date.new(2019, 12, 4)

			expect(@hotel.get_reservations_by_room(room, range_start, range_end)).must_be_instance_of Array
		end

		it "can show which rooms are available for a specific date" do
			date = Date.new(2019, 12, 1)

			expect(@hotel.get_rooms_by_date(date)).must_be_instance_of Array
			expect(@hotel.get_rooms_by_date(date).length).must_equal 18
		end

		it "must raise an error if all rooms are booked for a range" do
			hotel_two = Hotel::HotelSystem.new
			range_start = Date.new(2019, 12, 2)
			range_end = Date.new(2019, 12, 4)

			20.times do
				hotel_two.make_reservation(range_start, range_end)
			end

			expect{hotel_two.make_reservation(range_start, range_end)}.must_raise ArgumentError
		end

	end

end