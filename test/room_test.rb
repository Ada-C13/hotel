require 'room'
require_relative 'test_helper'

describe 'Room class' do
  describe 'Initializer' do
    it 'is an instance of Room' do
    test_room = Room.new(1)
      expect(test_room).must_be_kind_of Room
    end
  end
end