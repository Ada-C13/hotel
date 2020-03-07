require_relative 'lib/front_desk'
require 'ap'
require 'csv'

def print_options
  puts "options as below:"
  puts "
  # a # request_reservation(start_date,end_date)\n
  # b # create_block(start_date,end_date,num_of_rooms,room_rate)\n
  # c # book_room_of_block(block_id)\n
  # d # reservation_cost(reservation class)\n
  # e # list_all\n
  # f # check_date_reservations(date)
  "
end 

def hotel_manager 
  return Hotel::FrontDesk.new()
end 

MANAGER = hotel_manager

# get user input
def get_user_input
  input = gets.chomp
end 

# get user choice
def choice 
  pretty_up
  puts "What do you want to do? (input a,b,c,d,e or f)"
  pretty_up
  answer = get_user_input
  if answer == "a"
    do_request_reservation
  elsif answer == "b"
    do_create_block
  elsif answer == "c"
    do_book_room_of_block
  elsif answer == "d"
    do_reservation_cost
  elsif answer == "e"
    do_list_all
  elsif answer == "f"
    do_check_date_reservations
  else 
    puts "what"
  end 
end 

# pretty_up
def pretty_up
  puts "*************************************************************"
end 

def do_request_reservation
  puts "Requesting a reservation for you..."
  pretty_up
  puts "Enter Start Date year/month/day example input: 2020/3/1"
  start_date = get_user_input.split("/").map{|a|a.to_i}
  puts "Enter End Date year/month/day example input: 2020/3/3"
  end_date = get_user_input.split("/").map{|a|a.to_i}
  MANAGER.request_reservation(start_date,end_date)
  puts MANAGER.list_all
end 

def do_create_block
  puts "creating a block for you..."
  pretty_up
  puts "Enter Start Date year/month/day example input: 2020/3/1"
  start_date = get_user_input.split("/").map{|a|a.to_i}
  puts "Enter End Date year/month/day example input: 2020/3/3"
  end_date = get_user_input.split("/").map{|a|a.to_i}
  puts "Enter number of rooms to block (max 5)"
  num_of_rooms = get_user_input.to_i
  puts "Enter room rate:"
  room_rate = get_user_input.to_f
  MANAGER.create_block(start_date,end_date,num_of_rooms,room_rate)
  puts MANAGER.list_all
end 

def do_book_room_of_block
  puts "booking a room from a block for you..."
  pretty_up
  puts MANAGER.list_all 
  puts "Enter BXXXX block id to book a room"
  block_id = get_user_input.to_s
  MANAGER.book_room_of_block(block_id)
  puts "One of the #{block_id} id blocks is now booked!"
  puts MANAGER.list_all 
end 

# Helper Method to return reservation class by reservation_id

def find_id(id)
  reservation = MANAGER.reservations.select {|booking|booking.reservation_id == id}
  return reservation[0]
end 

def do_reservation_cost
  puts "Calculating cost for a reservation..."
  pretty_up
  puts "Please Enter the reservation id"
  reservation_id_input = get_user_input
  reservation = find_id(reservation_id_input)
  puts "$#{'%.2f' %MANAGER.reservation_cost(reservation)}"
end 

def do_list_all
  puts "pulling the list of all reservations"
  pretty_up
  puts MANAGER.list_all
end 

def do_check_date_reservations
  puts "Enter a specific date that you would like to check..."
  pretty_up
  date = get_user_input.split("/").map{|a|a.to_i}
  puts "okay. Here are all the reservations under #{date[0]}/#{date[1]}/#{date[2]}"
  puts MANAGER.check_date_reservations(date)
end 


def run_program

  # read existing reservations from csv file
  data = CSV.read('Hotel_bookings.csv',headers:true, header_converters: :symbol ).map{|record|record} 

  data.each do |record|
    start_date_fix = record[:start_date].split("-").map{|x|x.to_i}
    end_date_fix = record[:end_date].split("-").map{|x|x.to_i}
    date_range = Hotel::DateRange.new(start_date: start_date_fix, end_date: end_date_fix)
    to_add = Hotel::Reservation.new(reservation_id: record[:reservation_id],date_range: date_range,block_tag: record[:block_tag], room_rate: record[:room_rate])
    MANAGER.reservations << to_add
  end 

  puts "================================"
  puts "Hello Manager of HOTEL BUDAPEST"
  puts "================================"
  again = "y"

  while again == "y" 
    print_options
    choice
    puts "other things you like to check? y/n"
    pretty_up
    again = get_user_input
  end 
  
  puts "COOL Program Ended"

  CSV.open('Hotel_bookings.csv','w') do |csv|
    csv << ["reservation_id","start_date","end_date","room_num","block_tag","room_rate"]
    reservations = MANAGER.reservations
    
    reservations.each do |record|
      csv <<[record.reservation_id,record.date_range.start_date, record.date_range.end_date,record.room_num,record.block_tag, record.room_rate]
    end 
  end

end 

run_program

