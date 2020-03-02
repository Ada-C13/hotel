require 'date_range'
require 'reservation'

module Hotel
  class FrontDesk
    attr_reader :reservations, :rooms 
    def initialize()
      @reservations=[]
      @rooms = {}
    end

    
  end 
end