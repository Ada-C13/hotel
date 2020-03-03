require_relative 'test_helper'

describe 'initialize' do
  before do
    @reception = Hotel::HotelReception.new
  end

  it "can be instantiated" do
    expect(@reception).must_be_instance_of Hotel::HotelReception
    expect(@reception).must_respond_to :rooms
    expect(@reception).must_respond_to :reservations
  end

  it "has an array of rooms as an attribute" do
    expect(@reception.rooms).must_be_instance_of Array
    expect(@reception.rooms).wont_be_empty
    expect(@reception.rooms.length).must_equal 20
  end

  it "has an empty array of reservation objects as an attribute" do
    expect(@reception.reservations).must_be_instance_of Array
    expect(@reception.reservations).must_be_empty
  end
end

describe "" do
  before do
    @reception = Hotel::Reception.new
  end

end

describe "" do
  before do
    @reception = Hotel::Reception.new
  end


end

describe "" do
  before do
    @reception = Hotel::Reception.new
  end

end

describe "" do
  before do
    @reception = Hotel::Reception.new
  end

end

describe "" do
  before do
    @reception = Hotel::Reception.new
  end

end