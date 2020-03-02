require 'date'
require_relative "test_helper"

describe Hotel::HotelSystem do

	describe "Wave 1 Requirements" do
		before do
			@hotel = Hotel::HotelSystem.new

			date_one = Hotel::DateRange.new('dec 1', 'dec 5')
			@hotel.reservations << Hotel::Reservation.new(date_one)
			date_two = Hotel::DateRange.new('nov 27', 'dec 2')
			@hotel.reservations << Hotel::Reservation.new(date_two)
			date_three = Hotel::DateRange.new('dec 3', 'dec 5')
			@hotel.reservations << Hotel::Reservation.new(date_three)
		end

		it "returns an array of all rooms with reservation including a specific date" do
			date = Date.parse('dec 1')
			expect(@hotel.get_reservations(date)).must_be_instance_of Array
			expect(@hotel.get_reservations(date).length).must_equal 2
		end

	end

end