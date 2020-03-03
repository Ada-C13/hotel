require_relative 'test_helper'

describe Hotel::Reservation do
  before do
    date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
    @room_id = 10
    @reservation01 = Hotel::Reservation.new(date_range, @room_id)
  end

  describe "#initialize" do
    it "is an instance of Reservation" do
      expect(@reservation01).must_be_instance_of Hotel::Reservation
    end

    it "automatic generates an ID for the reservation" do
      expect(@reservation01.id).must_be_instance_of Integer
    end

    it "stores the correct room_id in the reservation" do
      expect(@reservation01.room_id).must_be_instance_of Integer
      expect(@reservation01.room_id).must_equal @room_id
    end

    it "stores a date_range that is an instance of DateRange" do
      expect(@reservation01.date_range).must_be_instance_of Hotel::DateRange
    end

    it "stores start_date and end_date that are both an instance of Date" do
      expect(@reservation01.date_range.start_date).must_be_instance_of Date
      expect(@reservation01.date_range.end_date).must_be_instance_of Date
    end
  end
end


# describe Hotel::Reservation do
#   before do
#     start_date = Date.today + 5
#     end_date = Date.today + 10
#     room_id = 10
#     @reservation01 = Hotel::Reservation.new(start_date, end_date, room_id)
#   end

#   describe "#initialize" do
#     it "is an instance of Reservation" do
#       expect(@reservation01).must_be_instance_of Hotel::Reservation
#     end

#     it "automatic generates an ID for the reservation" do
#       expect(@reservation01.id).must_be_instance_of Integer
#     end

#     it "stores a date_range that is an instance of DateRange" do
#       expect(@reservation01.date_range).must_be_instance_of Hotel::DateRange
#     end

#     it "stores start_date and end_date that are both an instance of Date" do
#       expect(@reservation01.start_date).must_be_instance_of Date
#       expect(@reservation01.end_date).must_be_instance_of Date
#     end

#     it "stores a room_id that is passed in as an argument" do
#       expect(@reservation01.room_id).must_equal 10
#     end
#   end

#   describe "#get_price" do
#     it "returns the total price for the reservation" do
#       expect(@reservation01.get_price).must_be_instance_of Float
#       expect(@reservation01.get_price).must_equal 1000
#     end

#   end
# end
