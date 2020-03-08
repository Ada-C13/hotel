require_relative 'test_helper.rb'

describe "reservation class" do
  before do
    @room = Stayappy::Room.new(room_num: 1, cost: 200)
    @check_in = Date.new(2020, 3, 10)
    @check_out = Date.new(2020, 3, 11)
    @reservation = Stayappy::Reservation.new(
      room: @room, 
      check_in: @check_in, 
      check_out: @check_out
    )
  end

  describe "Initialize" do
    it "can create a reservation" do
      expect(@reservation).must_be_instance_of Stayappy::Reservation
    end

    it "sets the room" do
      expect(@reservation.room).must_equal @room
    end

    it "sets the check_in and check_out duration" do
      expect(@reservation.check_in).must_equal @check_in
      expect(@reservation.check_out).must_equal @check_out
    end

    it "determine the stay correctly" do
      expect(@reservation.stay).must_equal @check_in..@check_out
    end

    it "raises an error if check_in date is after check_out date" do
      expect { Stayappy::Reservation.new(
        room: @room,
        check_in: @check_out,
        check_out: @check_in
      ) }.must_raise ArgumentError
    end
  end
end
