require_relative 'test_helper'

describe "Reservation Class" do
  date_range = Hotel::DateRange.new(("2020-02-03"), ("2020-02-07"))

  let (:reservation) {
    Hotel::Reservation.new(1, date_range, "3")
  }

  it "instantiates a reservation correctly" do
    expect(reservation).must_be_instance_of Hotel::Reservation
    expect(reservation.reservation_id).must_equal 1
    expect(reservation.date_range).must_be_instance_of Hotel::DateRange
    expect(reservation.room_number).must_equal "3"
    # expect(reservation.total_cost).must_equal 800
  end

end