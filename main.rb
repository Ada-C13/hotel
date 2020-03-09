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

def create_start_date
  puts "Please enter start date in DD/MM/YYYY format"
  stringdate = gets.chomp
  new_date = Date.parse(stringdate)
  return new_date
end

def create_end_date
  puts "Please enter end date in DD/MM/YYYY format"
  stringdate = gets.chomp
  new_date = Date.parse(stringdate)
  return new_date
end

def ask_room
  puts "Please enter the Room ID"
  room_id = gets.chomp.to_i
  return room_id
end

def ask_block
  puts "Please enter the Block ID"
  block_id = gets.chomp.to_i
  return block_id
end

def ask_rate
  puts "Please enter the rate"
  rate = gets.chomp
  return rate.to_f
end

def ask_quantity
  puts "Please enter the quantity of rooms for the hotel block"
  quantity = gets.chomp.to_i
  return quantity
end

def list_reservations(reservations)
  reservations.each do |rs|
    puts "Reservation #{rs.id}: Room #{rs.room_id} from #{rs.start_date} to #{rs.end_date}"
  end
end

def list_rooms(rooms_array)
  rooms_array.each do |room|
    print "Room #{room.room_id}, Rate: $#{room.cost} | "
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
        all_rooms = coordinator.list_rooms
        list_rooms(all_rooms)
      when "2", "2.", "find reservations by date"
        date_given = create_date
        bookings = coordinator.find_reservations_by_date(date_given)
        list_reservations(bookings)
      when "3", "3.", "find reservations by room and date range"
        start_date = create_start_date
        end_date = create_end_date
        range_given = Hotel::DateRange.new(start_date, end_date)
        room_id = ask_room
        bookings = coordinator.find_reservations_room_date(room_id.to_i,range_given)
        list_reservations(bookings)
      when "4", "4.", "find available rooms for date range"
        start_date = create_start_date
        end_date = create_end_date
        range_given = Hotel::DateRange.new(start_date, end_date)
        rooms_found = coordinator.find_available_rooms(range_given)
        puts "There are #{rooms_found.length} rooms available."
        list_rooms(rooms_found)
      when "5", "5.", "find available rooms for hotel block"
        block_given = ask_block
        availability = coordinator.check_block_availability(block_given)
        # puts availability
        puts availability == true ? "Available rooms in this block" : "No vacant rooms in this block"
      when "6", "6.", "make specific hotel block"
        start_date = create_start_date
        end_date = create_end_date
        range_given = Hotel::DateRange.new(start_date, end_date)
        quantity = ask_quantity
        while quantity > 5 || quantity <= 0
          quantity = ask_quantity
        end
        room_array = []
        quantity.times do
          room_id = ask_room.to_i
          room_array << room_id
        end
        cost = ask_rate
        block = coordinator.make_specific_block(range_given, room_array, cost)
        list_blocks(block)
      when "7", "7.", "make reservation"
        start_date = create_start_date
        end_date = create_end_date
        reservation = coordinator.make_reservation(start_date,end_date)
        puts "Reservation is made. It is Room #{reservation.room_id} from #{reservation.start_date} to #{reservation.end_date}"
      when "0", "0.", "exit", "quit", "0. exit"
        control_loop = false
    end
  end
end

main