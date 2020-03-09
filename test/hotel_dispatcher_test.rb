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
      hotel_dispatcher.make_rooms
      new_res = hotel_dispatcher.create_reservation(check_in_date, check_out_date)
      expect { new_res.create_reservation }.must_raise NoMethodError
    end
  end
end
# describe "Can create a Hotel room block" do
#   let(:check_in_date) { Date.new(2001, 2, 3) }
#   let(:check_out_date) { Date.new(2001, 2, 6) }

#   it "Checks the check room method block" do
#     room_ids = [1, 2, 3, 4, 5]
#     hotel_dispatcher = build_test_dispatcher
#     hotel_dispatcher.make_rooms
#     new_res = hotel_dispatcher.create_room_block(room_ids, check_in_date, check_out_date, room_rate)
#     expect { new_res.create_room_block }.must_raise NoMethodError
#   end

# it "Raise expection if reservation is can't be created" do
#   hotel_dispatcher = build_test_dispatcher
#   hotel_dispatcher.create_room_block(3, check_in_date, check_out_date, 150)
#   expect { new_res.create_room_block }.must_raise NoMethodError
# end
