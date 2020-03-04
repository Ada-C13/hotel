require_relative 'test_helper'


describe 'Room class' do
  describe 'Initializer' do
    it 'is an instance of Room' do
    test_room = Room.new(1)
      expect(test_room).must_be_kind_of Room
    end
    
    it 'can create a new reservation' do
      room = Room.new(1)
      reservation = room.add_reservation(Date.today,Date.today + 3)
      expect(room.reservations.length).must_equal 1
      expect(room.reservations).must_include reservation
    end

    it 'can take in the dates from Room class' do
      new_res = Reservation.new(Room.new(1),Date.today,Date.today + 3)
      expect(new_res.total).must_equal 400
    end
  end
end

