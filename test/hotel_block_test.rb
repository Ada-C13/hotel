require 'test_helper'

describe 'hotel block' do
  before do
    @reception = Hotel::HotelReception.new
  end

  describe 'initialize' do
    my_rooms = []
    3.times do |i|
      my_rooms << @reception.rooms
    end
    first_date = [2020, 3, 20]
    last_date = [2020, 3, 25]
    my_dates = Hotel::DateRange.new(first_date, last_date)

    @my_block = Hotel::HotelBlock.new(my_rooms, my_dates)

    it "can be initialized" do
      expect(@my_block).must_be_instance_of Hotel::HotelBlock
    end

    it "will have the appropriate attributes" do
      expect(@my_block).must_respond_to :id
      expect(@my_block.id).must_be_instance_of Integer
      expect(@my_block).must_respond_to :rooms
      expect(@my_block.rooms).must_be_instance_of Array
      expect(@my_block).must_respond_to :reservations
      expect(@my_block.reservations).must_be_instance_of Array
      expect(@my_block).must_respond_to :date_range
      expect(@my_block.date_range).must_be_instance_of Hotel::DateRange
    end

    it "will have 1 to 5 rooms objects" do
      expect(@my_block.rooms).wont_be_empty
      expect(@my_block.rooms[0]).must_be_instance_of Hotel::Room
      expect(@my_block.rooms.length).must_equal 3
    end

    it "will only have available rooms" do
      my_rooms = @my_block.rooms
      check_in = @my_block.date_range.check_in_time
      check_out = @my_block.date_range.check_out_time
      avail_rooms = @reception.available_rooms(check_in, check_out)
      #check the array of room objects against the array of avail room objects for our date range
      expect(avail_rooms & my_rooms).must_be_empty
    end
  end

  describe "" do
  
    
  end



end