require 'date' 
require_relative "./lib/res_man"
require_relative "./lib/reservation"
require_relative "./lib/block_res"

def main()

  phillip = Stayappy::ReservationManager.new()

  smiths = Stayappy::Reservation.new(
    check_in: Date.today, 
    check_out: Date.new(2020,3,10), 
    res_num: 123456789, 
    room_num: 10, 
    total: 600.00
  )

  #   mansons = Stayappy::BlockRes.new(
  #   check_in: Date.new(2020,3,30), 
  #   check_out: Date.new(2020,4,10), 
  #   res_num: 123456789, 
  #   room_num: 1, 
  #   total: 600.00
  # )
  
  phillip.make_reservation(smiths)
end 

main()