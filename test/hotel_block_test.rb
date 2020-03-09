require_relative "test_helper"

describe "HotelBlock" do
  let(:date_range) {
    date_range = Hotel::DateRange.new(Date.new(2020,5,3), Date.new(2020,5,5))
  }
  let(:reservations) {
    rooms.each do |room|
      room.reservations << Hotel::Reservation.new(date_range, 2, room.number, room.cost, 1, true)
    end
  }
  let(:rooms) {
    room1 = Hotel::Room.new(1, 200)
    room2 = Hotel::Room.new(2, 200)
    room3 = Hotel::Room.new(3, 200)
    rooms = [room1, room2, room3]
  }
  let(:discount_rate) {
    discount_rate = 15
  }
  let(:hotel_block) {
    hotel_block = Hotel::HotelBlock.new(date_range, rooms, discount_rate, 1)
  }

  describe "initialize" do
    it "creates an instance of HotelBlock" do
      expect(hotel_block).must_be_kind_of Hotel::HotelBlock
      expect(hotel_block).must_respond_to :date_range
      expect(hotel_block).must_respond_to :rooms
      expect(hotel_block).must_respond_to :discount_rate
    end

    it "raises ArgumentError if date_range is not instance of DateRange" do
      date_range = "tues-thurs"
      expect{ Hotel::DateRange.new(date_range, rooms, discount_rate) }.must_raise ArgumentError
    end

    it "raises ArgumentError if more than 5 rooms are provided" do
      rooms = []
      6.times do |i|
        rooms << Hotel::Room.new(i, 200)
      end

      expect{ Hotel::HotelBlock.new(date_range, rooms, discount_rate, 1) }.must_raise ArgumentError
    end
  end

  describe "calculate_discounted_rate" do
    it "calculates discounted rate correctly given an integer" do
      hotel_block.rooms.each do |room|
        expect(room.cost).must_equal 170
      end
    end

    it "calculates discounted rate correctly given a float" do
      hotel_block = Hotel::HotelBlock.new(date_range, rooms, 0.20, 1)
      hotel_block.rooms.each do |room|
        expect(room.cost).must_equal 160
      end
    end
  end

  describe "check_availability" do
    it "returns an array of available room numbers" do
      reservations
      expect(hotel_block.check_availability()).must_equal [1,2,3]
    end

    it "returns an empty array if no rooms are available" do
      rooms.each do |room|
        room.reservations << Hotel::Reservation.new(date_range, 2, room.number, room.cost, 1, false)
      end
      rooms.each do |room|
        room.reservations.each do |reservation|
          reservation.available == false
        end
      end

      expect(hotel_block.check_availability).must_equal []
    end
  end

  describe "find_reservations" do
    it "returns an Array of Reservations" do
      reservations
      expect(hotel_block.find_reservations).must_be_kind_of Array
    end
  end
end