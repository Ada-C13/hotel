require_relative "test_helper.rb"

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

  describe "Date checking" do
    before do   
      @long_check_out = Date.new(2020, 4, 10)
      @long_reservation = Stayappy::Reservation.new(
        room: @room, 
        check_in: @check_in, 
        check_out: @long_check_out
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

    it "does not match when range is before" do
      start_date = Date.new(2020, 03, 05)
      end_date = Date.new(2020, 03, 06)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal false
    end

    it "does not match when range is after" do
      start_date = Date.new(2020, 04, 20)
      end_date = Date.new(2020, 04, 20)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal false
    end

    it "matches when check_in is same as end of range" do
      start_date = Date.new(2020, 03, 01)
      end_date = Date.new(2020, 03, 10)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal true
    end

    it "matches when check_out is same as start of range" do
      start_date = Date.new(2020, 04, 10)
      end_date = Date.new(2020, 04, 20)

      expect(@long_reservation.in_range?(start_date, end_date)).must_equal true
    end

    it "does not count overlap when dates are before" do
      before_in_date = Date.new(2020, 3, 8)
      before_out_date = Date.new(2020, 3, 9)
      
      expect(@long_reservation.stay_overlaps?(
        other_check_in: before_in_date,
        other_check_out: before_out_date
      )).must_equal false
    end

    it "does not count overlap when are after" do
      before_in_date = Date.new(2020, 4, 11)
      before_out_date = Date.new(2020, 4, 12)
      
      expect(@long_reservation.stay_overlaps?(
        other_check_in: before_in_date,
        other_check_out: before_out_date
      )).must_equal false
    end

    it "does count overlap when dates are inside" do
      before_in_date = Date.new(2020, 3, 15)
      before_out_date = Date.new(2020, 3, 16)
      
      expect(@long_reservation.stay_overlaps?(
        other_check_in: before_in_date,
        other_check_out: before_out_date
      )).must_equal true
    end

    it "does count overlap when check_in is inside" do
      before_in_date = Date.new(2020, 3, 15)
      before_out_date = Date.new(2020, 4, 15)
      
      expect(@long_reservation.stay_overlaps?(
        other_check_in: before_in_date,
        other_check_out: before_out_date
      )).must_equal true
    end

    it "does count overlap when check_out is inside" do
      before_in_date = Date.new(2020, 2, 15)
      before_out_date = Date.new(2020, 3, 15)
      
      expect(@long_reservation.stay_overlaps?(
        other_check_in: before_in_date,
        other_check_out: before_out_date
      )).must_equal true
    end

    it "does not count overlap when other check_out is same as our check_in" do
      before_in_date = Date.new(2020, 2, 15)
      before_out_date = Date.new(2020, 3, 10)
      
      expect(@long_reservation.stay_overlaps?(
        other_check_in: before_in_date,
        other_check_out: before_out_date
      )).must_equal false
    end

    it "does not count overlap when other check_in is same as our check_out" do
      before_in_date = Date.new(2020, 4, 10)
      before_out_date = Date.new(2020, 4, 11)
      
      expect(@long_reservation.stay_overlaps?(
        other_check_in: before_in_date,
        other_check_out: before_out_date
      )).must_equal false
    end
  end
end
