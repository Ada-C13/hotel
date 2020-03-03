require 'hotel_dispatch'
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
end
