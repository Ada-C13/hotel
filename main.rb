require_relative 'lib/front_desk'
require 'ap'

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
  puts "what do you want to do? (input a,b,c,d,e or f)"
  answer = get_user_input
  if answer == "a"
    do_request_reservation
  elsif answer == "b"
    do_create_block
  elsif answer == "c"
    puts "huh"
  elsif answer == "d"
    puts "huh"
  elsif answer == "e"
    puts "huh"
  elsif answer == "f"
  else 
    puts "what"
  end 
end 

def do_request_reservation
  puts "Requesting a reservation for you..."
  puts "Enter Start Date year/month/day example input: 2020/3/1"
  start_date = get_user_input.split("/").map{|a|a.to_i}
  puts "Enter End Date year/month/day example input: 2020/3/3"
  end_date = get_user_input.split("/").map{|a|a.to_i}
  MANAGER.request_reservation(start_date,end_date)
  puts MANAGER.list_all
end 

def do_create_block
  puts "creating a block for you..."
  puts "Enter Start Date year/month/day example input: 2020/3/1"
  start_date = get_user_input.split("/").map{|a|a.to_i}
  puts "Enter End Date year/month/day example input: 2020/3/3"
  end_date = get_user_input.split("/").map{|a|a.to_i}
  puts "Enter number of rooms to block (max 5)"
  num_of_rooms = get_user_input.to_i
  puts "Enter room rate"
  room_rate = get_user_input.to_f
  MANAGER.create_block(start_date,end_date,num_of_rooms,room_rate)
  puts MANAGER.list_all
end 

def book_room_of_block
end 

def reservation_cost
end 

def list_all
end 

def check_date_reservations
end 

def run_program
  puts "================================"
  puts "Hello Manager of HOTEL BUDAPEST"
  puts "================================"

  again = "y"
  while again == "y" 
    print_options
    choice
    puts "other things you like to check? y/n"
    again = get_user_input
  end 
  puts "COOL Program Ended"
end 

run_program