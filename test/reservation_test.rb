require_relative "test_helper.rb"

describe "reservation class" do
  before do
    @room = Stayappy::Room.new(room_num: 1, cost: 200)
    @check_in = Date.new(2020, 3, 10)
    @check_out = Date.new(2020, 3, 11)
    @reservation = Stayappy::Reservation.new(@room, @check_in, @check_out)
  end

  describe "Initialize" do
    it "can create a reservation" do
      expect(@reservation).must_be_instance_of Stayappy::Reservation
    end

    it "can set the room" do
      expect(@reservation.room).must_equal @room
    end

    it "can set the check_in and check_out duration" do
      expect(@reservation.check_in).must_equal @check_in
      expect(@reservation.check_out).must_equal @check_out
    end

    it "can determine the stay correctly" do
      expect(@reservation.stay).must_equal @check_in..@check_out
    end

    it "can raises an error if the check_in date is after the check_out date" do
      expect { Stayappy::Reservation.new(@room, @check_out, @check_in) }.must_raise ArgumentError
    end
  end

  describe "in_range method" do
    before do   
      @long_check_out = Date.new(2020, 4, 10)
      @long_reservation = Stayappy::Reservation.new(
        @room, 
        @check_in, 
        @long_check_out
      )
    end

    it "matches range when check_in is inside" do
      start_date = Date.new(2020, 03, 05)
      end_date = Date.new(2020, 03, 15)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal true
    end

    it "matches range when check_out is inside" do
      start_date = Date.new(2020, 03, 05)
      end_date = Date.new(2020, 04, 20)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal true
    end

    it "does not match when other range is before" do
      start_date = Date.new(2020, 03, 05)
      end_date = Date.new(2020, 03, 06)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal false
    end

    it "does not match when other range is after" do
      start_date = Date.new(2020, 04, 20)
      end_date = Date.new(2020, 04, 20)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal false
    end

    it "does not match when other range is after" do
      start_date = Date.new(2020, 04, 20)
      end_date = Date.new(2020, 04, 20)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal false
    end

    it "matches when check_in is same as end of range" do
      start_date = Date.new(2020, 03, 01)
      end_date = Date.new(2020, 03, 10)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal true
    end

    it "matches when check_out is not same as start of range" do
      start_date = Date.new(2020, 04, 10)
      end_date = Date.new(2020, 04, 20)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal false
    end

    it "matches when check_in and check_out are the same as the range" do
      expect(@long_reservation.in_range?(
        @check_in,
        @long_check_out)).must_equal true
    end
  end

  describe "receipt method" do
    it "can get cost for one night reservation" do
      expect(@reservation.receipt).must_equal 200
    end

    it "can get cost for multi-night night reservation" do
      @multi_night_checkout = Date.new(2020, 3, 15)
      @multi_night_reservation = Stayappy::Reservation.new(
        @room,
        @check_in, 
        @multi_night_checkout
      )

      expect(@multi_night_reservation.receipt).must_equal 1000
    end
  end
end
