require_relative "test_helper"

describe "Hotel Class" do 
  it "#initialize" do 
    expect(Hotel.new("four season").name).must_equal "four season"
  end 
end 