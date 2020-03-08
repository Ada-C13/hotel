require_relative 'lib/system_coordinator'
require_relative 'lib/room'
require_relative 'lib/date_range'
require_relative 'lib/reservation'
require_relative 'lib/no_availability_error'

def display_intro
  puts "\nGood day! You are now logged in the hotel system."
end

def display_options
  puts "\nEnter 1, 2, 3, 4, 5, 6 ,7 , or 0 for the following options."
  puts "1. list rooms"
  puts "2. find reservations by date"
  puts "3. find reservations by room and date range"
  puts "4. find available rooms for date range"
  puts "5. find available rooms for hotel block"
  puts "6. make hotel block"
  puts "7. make reservation"
  puts "0. exit"
end

def create_date
  puts "Please enter a date in DD/MM/YYYY format"
  stringdate = gets.chomp
  new_date = Date.parse(stringdate)
  return new_date
end

def ask_room
  puts "Please enter the Room ID"
  room_id = gets.chomp
  return room_id
end

def ask_rate
  puts "Please enter the rate"
  rate = gets.chomp
  return rate.to_f
end

def list_reservations(reservations)
  reservations.each do |rs|
    puts "Reservation #{rs.id}: Room #{rs.room_id} from #{rs.start_date} to #{rs.end_date}"
  end
end

def list_rooms(rooms_array)
  rooms_array.each do |room|
    print "Room #{room.room_id} | "
  end
end

def list_blocks(blocks_array)
  blocks_array.each do |rs|
    puts "Block #{rs.block}: Room #{rs.room_id} from #{rs.start_date} to #{rs.end_date}"
  end
end

def main
  coordinator = Hotel::SystemCoordinator.new

  display_intro
  control_loop = true

  while control_loop
    display_options
    choice = gets.chomp
    case choice
      when "1",  "1.", "list rooms"
        coordinator.list_rooms
      when "2", "2.", "find reservations by date"
        date_given = create_date
        bookings = coordinator.find_reservations_by_date(date_given)
        list_reservations(bookings)
      when "3", "3.", "find reservations by room and date range"
        start_date = create_date
        end_date = create_date
        range_given = Hotel::DateRange.new(start_date, end_date)
        room_id = ask_room
        bookings = coordinator.find_reservations_room_date(room_id.to_i,range_given)
        list_reservations(bookings)
      when "4", "4.", "find available rooms for date range"
        start_date = create_date
        end_date = create_date
        range_given = Hotel::DateRange.new(start_date, end_date)
        rooms = coordinator.find_available_rooms(range_given)
        puts "There are #{rooms.length} rooms available."
        rooms.list_rooms
        # rooms.each do |room|
        #   print "Room #{room.room_id} | "
        # end
      when "5", "5.", "find available rooms for hotel block"
        start_date = create_date
        end_date = create_date
        range_given = Hotel::DateRange.new(start_date, end_date)
        rooms = coordinator.find_block_rooms(range_given)
        puts "There are #{rooms.length} rooms available."
        rooms.list_rooms
      when "6", "6.", "make specific hotel block"
        start_date = create_date
        end_date = create_date
        range_given = Hotel::DateRange.new(start_date, end_date)
        room_array = []
        5.times do
          room_id = ask_room
          room_array << room_id
        end
        cost = ask_rate
        block = coordinator.make_specific_block(range_given, room_array, cost)
        block.list_blocks
      when "7", "7.", "make reservation"
        start_date = create_date
        end_date = create_date
        reservation = coordinator.make_reservation(start_date,end_date)
        puts "Reservation is made. It is room #{reservation.room_id} from #{reservation.start_date} to #{reservation.end_date}"
      when "0", "0.", "exit", "quit", "0. exit"
        control_loop = false
    end
  end

end

# example = Date.parse("10/10/2020")
# puts example.class 

# puts example

main