require_relative 'test_helper'
require 'pry'

describe "Reservation class" do
  describe "initialize" do
    before do
      start_date= Date.new(2019, 03, 01)
      end_date = Date.new(2019, 03, 05)

      room = Hotel::Room.new(
        room_num: 13,
      )

      @res_data = Hotel::Reservation.new(

          start_date: start_date,
          end_date: end_date,
          room: room
        )
      
    end 

    it "is an instance of Reservation" do
      expect(@res_data).must_be_kind_of Hotel::Reservation
    end 
    
    it "has a start_date that is a Date object" do
      expect(@res_data.start_date).must_be_instance_of Date
    end

    it "has an end_date that is a Date object" do
      expect(@res_data.end_date).must_be_instance_of Date
    end
    
    it "@res_data.room is an instance of Room.new" do
      expect(@res_data.room).must_be_kind_of Hotel::Room
    end

    it "calculates res_duration in days - minus checkout day" do
      expect(@res_data.res_duration).must_equal 3
    end

    it "calculates total cost of reservation" do
      expect(@res_data.find_total_cost).must_equal 600
    end

  end 

end 
