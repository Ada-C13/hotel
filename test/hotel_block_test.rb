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
    my_dates = Hotel::DateRange.new(first_date, last_date)

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

    it "will only have available rooms" do
      my_rooms = @reception.blocks[0].rooms
      check_in = @reception.blocks[0].dates.check_in_time
      check_out = @reception.blocks[0].dates.check_out_time
      avail_rooms = @reception.available_rooms(check_in, check_out)
      #check the array of room objects against the array of avail room objects for our date range
      expect(avail_rooms & my_rooms).must_be_empty
    end

    it "will throw argument error if given improper no. of rooms" do
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

  describe "make reservation method" do
    
    
  end



end