require_relative "test_helper"
require "hotel_dispatcher"

describe "HotelDispatcher class" do
  def build_test_dispatcher
    HotelManager.new
  end

  describe "Initializer" do
    it "is an instance of HotelDispatcher" do
      hotel_dispatcher = build_test_dispatcher
      expect(hotel_dispatcher).must_be_kind_of HotelManager
    end

    it "can makes all rooms" do
      hotel_dispatcher = build_test_dispatcher
      room_array = hotel_dispatcher.make_rooms
      expect(room_array.length).must_equal 20
    end
  end

  describe "Can create a reservation" do
    let(:room_ids) { 5 }
    let(:room_info) { 5 }
    let(:hotel_block_id) { 101 }
    let(:room_rate) { 150 }
    let(:check_in_date) { Date.new(2001, 2, 3) }
    let(:check_out_date) { Date.new(2001, 2, 6) }

    it "Return true if reservation is can be created" do
      hotel_dispatcher = build_test_dispatcher
      hotel_dispatcher.make_rooms
      new_res = hotel_dispatcher.create_reservation(check_in_date, check_out_date)
      expect(new_res).must_equal true
    end

    it "Raises error if no reservation available " do
      hotel_dispatcher = build_test_dispatcher
      hotel_dispatcher.rooms.each do |room|
        room.create_new_reservation(Date.today, Date.today + 3)
      end
      expect { new_res = hotel_dispatcher.create_reservation(Date.today, Date.today + 3) }.must_raise Exception
    end
  end

  describe "Can create a Hotel room block??????" do
    let(:check_in_date) { Date.new(2001, 2, 3) }
    let(:check_out_date) { Date.new(2001, 2, 6) }
    it "Raise expection if reservation is can't be created" do
      hotel_dispatcher = build_test_dispatcher
      room_ids = [1, 2, 3]
      hotel_dispatcher.rooms.each do |room|
        room.create_new_reservation(Date.today, Date.today + 3)
      end
      expect { new_res = hotel_dispatcher.create_room_block(room_ids, Date.today, Date.today + 3, 150) }.must_raise Exception
    end
    # it "Creates a successfull room block" do

    # end

    it "Check room availablity " do
      hotel_dispatcher = build_test_dispatcher

      hotel_dispatcher.rooms.each do |room|
        room.create_new_reservation(Date.today, Date.today + 3, hotel_block_reservation = false)
      end
      results = hotel_dispatcher.check_room_available?(Date.today, Date.today + 3)
      expect(results).must_equal false
    end
  end
  describe " Find all res" do
    it "finds all res" do
      hotel_dispatcher = build_test_dispatcher
      all_res = []
      hotel_dispatcher.rooms.each do |room|
        all_res << room.create_new_reservation(Date.today, Date.today + 3, hotel_block_reservation = false)
      end
      find_all = hotel_dispatcher.find_all_resevations
      all_res.each do |res|
        expect(find_all).must_include res
      end
    end
  end
end

