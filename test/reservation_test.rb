require_relative 'test_helper'

describe "initialization" do 
  it "creates a new instance of reservation" do 
    id = 3
    Reservation.new.must_be_instance_of Reservation
  end
end