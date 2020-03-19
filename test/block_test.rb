require_relative "test_helper"

describe Hotel::Block do
  before do
    @fd = Hotel::FrontDesk.new
    @rooms = @fd.rooms.slice(0,5)
    @start = Date.new(2020, 01, 01)
    @end = Date.new(2020, 01, 07)
    @rate = 153
  end

  describe "constructor" do
    describe "has all the expected state" do
      it "rooms" do 
        block = Hotel::Block.new(@start, @end, @rooms, @rate)
        expect(block.available_rooms).must_be_kind_of Array
        avail_rooms = block.available_rooms
        avail_rooms.each_with_index do |room, i|
          expect(room).must_equal @rooms[i]
        end
      end
      it "reservations" do
        block = Hotel::Block.new(@start, @end, @rooms, @rate)
        expect(block.reservations).must_be_kind_of Array
      end
    end
    it "raises error if a room in rooms is not available" do
      @rooms[4].add(Hotel::Reservation.new(@start, @end, 5, 150))
      expect{Hotel::Block.new(@start, @end, @rooms, @rate)}.must_raise ArgumentError
    end
    it "raises an error if rooms is > 5" do
      @rooms << Hotel::Room.new(6)
      expect{Hotel::Block.new(@start, @end, @rooms, @rate)}.must_raise ArgumentError
    end
    it "reflects changes in rooms included in block" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      @rooms.each do |room|
        expect(room.reservations.include?(block)).must_equal true
      end
    end
    
  end

  describe "reserve(room)" do
    it "raises error if attempting to reserve a room not in block" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      expect{block.reserve(Hotel::Room.new(20))}.must_raise ArgumentError
    end

    it "reflects changes in class state: reservations" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      @rooms.each do |room|
        block.reserve(room)
      end
      block.reservations.each_with_index do |reservation, i|
        expect(reservation.room).must_equal i + 1
      end
    end

    it "reserved room no longer has the block in their reservations, but a reservation instead" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      @rooms.each do |room|
        block.reserve(room)
        expect(room.reservations.any?(Hotel::Block)).must_equal false
      end
      
    end
    it "won't let another block be formed on the same rooms with overlapping range" do
      Hotel::Block.new(@start, @end, @rooms, @rate)
      start2 = Date.new(2020, 01, 03)
      end2 = Date.new(2020, 01, 15)
      expect{Hotel::Block.new(start2, end2, @rooms, @rate)}.must_raise ArgumentError
    end
    it "won't erase another block in making room's block>reservation change" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      start2 = Date.new(2020, 02, 01)
      end2 = Date.new(2020, 02, 28)
      block2 = Hotel::Block.new(start2, end2, @rooms, @rate)
      @rooms.each do |room|
        block.reserve(room)
        expect(room.reservations.find{|r| r.class == Hotel::Block}).must_equal block2
      end
    end 
    it "removes room from available_rooms" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      @rooms.each_with_index do |room, i|
        block.reserve(room)
        expect(block.available_rooms.any?{|r| r == room }).must_equal false
      end
    end
    it "effectively adds discounted rate to reservation" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      @rooms.each_with_index do |room, i|
        block.reserve(room)
      end
      block.reservations.each do |r|
        expect(r.cost % 153 == 0).must_equal true
      end
    end
    it "raises error if all rooms are booked" do
      block = Hotel::Block.new(@start, @end, @rooms, @rate)
      @rooms.each_with_index do |room, i|
        block.reserve(room)
      end
      expect{block.reserve(@rooms[0])}.must_raise ArgumentError
    end
  end

end