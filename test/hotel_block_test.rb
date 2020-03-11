require 'test_helper'

describe 'hotel block' do
  before do
    @reception = Hotel::HotelReception.new

    my_rooms = []
    3.times do |i|
      my_rooms << @reception.rooms[i]
    end

    first_date = Date.new(2020, 3, 20)
    last_date = Date.new(2020, 3, 25)

    @reception.blocks << Hotel::HotelBlock.new(my_rooms, first_date, last_date)
  end

  describe "initialize" do
    it "can be initialized" do
      expect(@reception.blocks[0]).must_be_instance_of Hotel::HotelBlock
    end

    it "will have the appropriate attributes" do
      expect(@reception.blocks[0]).must_respond_to :id
      expect(@reception.blocks[0].id).must_be_instance_of Integer

      expect(@reception.blocks[0]).must_respond_to :rooms
      expect(@reception.blocks[0].rooms).must_be_instance_of Array

      expect(@reception.blocks[0]).must_respond_to :reservations
      expect(@reception.blocks[0].reservations).must_be_instance_of Array
      
      expect(@reception.blocks[0]).must_respond_to :dates
      expect(@reception.blocks[0].dates).must_be_instance_of Hotel::DateRange
    end

    it "will have 1 to 5 rooms objects" do
      expect(@reception.blocks[0].rooms).wont_be_empty
      expect(@reception.blocks[0].rooms[0]).must_be_instance_of Hotel::Room
      expect(@reception.blocks[0].rooms.length).must_equal 3
    end

    it "will make rooms not 'available' anymore" do
      my_rooms = @reception.blocks[0].rooms
      check_in = @reception.blocks[0].dates.check_in_time
      check_out = @reception.blocks[0].dates.check_out_time
      avail_rooms = @reception.available_rooms(check_in, check_out)

      expect(avail_rooms & my_rooms).must_be_empty
    end

    it "will throw argument error if given improper num of rooms" do
      my_rooms = []
      first_date = Date.new(2020, 3, 20)
      last_date = Date.new(2020, 3, 25)

      too_many_rooms = []
      6.times do |i|
        too_many_rooms << @reception.rooms[i]
      end

      not_rooms = [5, 6, 7]

      expect{
        Hotel::HotelBlock.new(my_rooms, first_date, last_date)
      }.must_raise ArgumentError

      expect{
        Hotel::HotelBlock.new(too_many_rooms, first_date, last_date)
      }.must_raise ArgumentError

      expect{
        Hotel::HotelBlock.new(not_rooms, first_date, last_date)
      }.must_raise ArgumentError
    end
  end

  describe "will calc discounted cost of a room" do
    it "will apply the correct discount" do
      my_room = @reception.blocks.last.rooms.first
      cost = @reception.blocks.last.cost(my_room)

      expect(cost).must_be_close_to 800
    end
  end

  describe "available rooms method" do
    it "will show available rooms in a block" do
      my_block = @reception.blocks.last
      my_rooms = my_block.rooms
      avail = my_block.available_rooms

      expect(avail).must_be_instance_of Array
      expect(avail.length).must_equal my_rooms.length
    end

    it "will not show rooms that have reservations" do
      my_block = @reception.blocks.last
      my_rooms = my_block.rooms
      @reception.reserve_from_block(my_block, my_rooms.first)
      avail = my_block.available_rooms

      expect(avail).wont_include my_rooms.first
      expect(avail.length).wont_equal my_rooms.length
      expect(avail.length).must_equal (my_rooms.length - 1)
    end
  end
end