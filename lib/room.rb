require 'csv'

module Hotel
  class Room
    
  attr_reader :room_number
  attr_accessor :price

    def initialize(room_number, price = 200.00)
      if room_number.class != Integer
        raise ArgumentError.new("Invalid room number, must be an Integer.")
      end
      @room_number = room_number

      if ![Float, Integer].include?(price.class)
        raise ArgumentError.new("Invalid price, must be a Float.")
      end
      @price = price
    end #initialize

    def self.load_all_rooms() #what to get
      rooms = CSV.parse(File.read(__dir__ + "/../support/rooms.csv"), headers: true, header_converters: :symbol) #relative to HOTEL & reading csv file
      all_rooms = [] #save all rooms to this array
        rooms.each do |record| #loop through each record
          room_number = record[:room_number].to_i
          price = record[:price].to_i
          temp_room = Room.new(room_number, price)
          all_rooms.push(temp_room) #push Room into all_rooms
        end
    return all_rooms #return all the rooms
    end

  end #class
end #module


# test = Hotel::Room.new("1A")
# puts test.room_number
# puts test.price

# rooms = Hotel::Room.load_all_rooms
# rooms.each do |room|
#   room_number = room.room_number
#   price = room.price
#   puts "#{room_number}, #{price}"
# end




