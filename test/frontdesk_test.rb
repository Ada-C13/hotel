require_relative 'test_helper'

describe "FrontDesk class" do
  describe "#initialize" do
    it "creates an instance of FrontDesk class" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk).must_be_instance_of Hotel::FrontDesk
    end
  end
end
