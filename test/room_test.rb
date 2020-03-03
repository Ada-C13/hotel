room_test.rb






it "throws an argument error if checkout date is before checkin date" do
  expect do
    Hotel::Reservation.new(id:1, checkin:@checkout, checkout:@checkin, room_id:2)
  end.must_raise ArgumentError
end