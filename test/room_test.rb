require_relative "test_helper"

describe Hotel::Room do

	describe "#initialize" do
		before do
			number = 20
			@new_room = Hotel::Room.new(number)
		end

		it "creates an instance of Room" do
			expect(@new_room).must_be_instance_of Hotel::Room
		end

		it "contains an integer for @number" do
			expect(@new_room.number).must_be_instance_of Integer
		end

		it "contains an array for @reservations" do
			expect(@new_room.reservations).must_be_instance_of Array
		end

	end

end