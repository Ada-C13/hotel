require 'hotel_dispatcher'
require_relative 'test_helper'

describe 'HotelDispatcher class' do
  def build_test_dispatcher
    return HotelDispatcher.new
  end
  describe 'Initializer' do
    it 'is an instance of HotelDispatcher' do
      dispatcher = build_test_dispatcher
      expect(dispatcher).must_be_kind_of HotelDispatcher
    end
  end
  describe 'Instance of Hotel Dispatcher' do
    it 'can makes all rooms' do
      hotel_dispatcher = build_test_dispatcher
      room_array = hotel_dispatcher.make_rooms
      expect(room_array.length).must_equal 20
  describe
    end
  end
end
