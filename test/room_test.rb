require_relative 'test_helper'


xdescribe 'Room class' do
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

    it 'can hold each reservation'do 
     room = Room.new(1)
     all_res = []
      5.times do |index|
        all_res << room.add_reservation(Date.today,Date.today + 3)
      end
      expect(all_res.length).must_equal 5
    end
  end
end
