require_relative 'test_helper'

describe "Trip class" do
  before do
    start_time = Time.now - 60 * 60 # 60 minutes
    end_time = start_time + 25 * 60 # 25 minutes
    @trip_data = {
      id: 8,
      passenger: RideShare::Passenger.new(
        id: 1,
        name: "Ada",
        phone_number: "412-432-7640"
      ),
      start_time: start_time,
      end_time: end_time,
      cost: 23.45,
      rating: 3,
      #Adding driver data to trip 
      driver: RideShare::Driver.new(
        id: 7,
        name: "Lak Kate",
        vin: "1C9YKKLR1BV5564A7",
        status: :AVAILABLE,
        trips: nil
      )
    }
    @trip = RideShare::Trip.new(@trip_data)
  end

  describe "initialize" do
    it "is an instance of Trip" do
      expect(@trip).must_be_kind_of RideShare::Trip
    end

    it "stores an instance of passenger" do
      expect(@trip.passenger).must_be_kind_of RideShare::Passenger
    end

    it "stores an instance of driver" do
      # skip # Unskip after wave 2
      expect(@trip.driver).must_be_kind_of RideShare::Driver
    end

    it "raises an error for an invalid rating" do
      [-3, 0, 6].each do |rating|
        @trip_data[:rating] = rating
        expect do
          RideShare::Trip.new(@trip_data)
        end.must_raise ArgumentError
      end
    end

    it "raises an error because end time is before the start time" do
      # if start_time > end_time #https://ruby-doc.org/core-2.6.3/Time.html
      #   raise ArgumentError.new("Invalid, start time must be before end time")
      # end
      #what do we need: testing the initialize by creating a Trip object
      @trip_data[:start_time] = Time.parse("2018-12-27 02:00:00 -0800")
      @trip_data[:end_time] = Time.parse("2018-12-27 01:00:00 -0800")
      expect{RideShare::Trip.new(@trip_data)}.must_raise ArgumentError
      
    end
  end
  describe "duration" do
    it "calculates a one minute duration" do
      @trip_data[:start_time] = Time.parse("2018-12-27 02:00:00 -0800")
      @trip_data[:end_time] = Time.parse("2018-12-27 02:01:00 -0800")
      test_time = RideShare::Trip.new(@trip_data)
      expect(test_time.duration()).must_equal 60
    
    end
  end

  describe "connect" do
    # TODO
  end
end


require_relative 'test_helper'

TEST_DATA_DIR = 'test/test_data'

describe RideShare::CsvRecord do
  describe 'constructor' do
    it 'takes and saves an id' do
      id = 7
      record = RideShare::CsvRecord.new(id)
      expect(record.id).must_equal id
    end

    it 'validates the ID' do
      id = -7
      expect {
        RideShare::CsvRecord.new(id)
      }.must_raise ArgumentError
    end
  end

  describe 'load_all' do
    it "raises an error if neither full_path nor directory is provided" do
      expect {
        RideShare::CsvRecord.load_all
      }.must_raise ArgumentError
    end

    it "raises an error if invoked directly (without subclassing)" do
      full_path = "#{TEST_DATA_DIR}/testrecords.csv"
      expect {
        RideShare::CsvRecord.load_all(full_path: full_path)
      }.must_raise NotImplementedError
    end
  end

  describe 'validate_id' do
    it 'accepts natural numbers' do
      # Should not raise
      [1, 10, 9999].each do |id|
        RideShare::CsvRecord.validate_id(id)
      end
    end

    it 'raises for negative numbers and 0' do
      [0, -1, -10, -9999].each do |id|
        expect {
          RideShare::CsvRecord.validate_id(id)
        }.must_raise ArgumentError
      end
    end

    it 'raises for nil' do
      expect {
        RideShare::CsvRecord.validate_id(nil)
      }.must_raise ArgumentError
    end
  end

  describe 'extension' do
    # It's a class that's designed to be extended.
    # How do you test that? Extend it!
    class TestRecord < RideShare::CsvRecord
      attr_reader :name
      def initialize(id:, name:)
        super(id)
        @name = name
      end

      def self.load_all(*args, **kwargs)
        @call_count = 0
        super
      end

      def self.from_csv(record)
        new(**record)
        @call_count ||= 0
        @call_count += 1
      end

      class << self
        attr_reader :call_count
      end
    end

    describe 'load_all' do
      let(:record_count) {
        CSV.read("#{TEST_DATA_DIR}/testrecords.csv", headers: true).length
      }

      it 'finds data given just a directory' do
        records = TestRecord.load_all(directory: TEST_DATA_DIR)

        expect(records.length).must_equal record_count
      end

      it 'finds data given a directory and filename' do
        file_name = 'custom_filename_test.csv'
        records = TestRecord.load_all(directory: TEST_DATA_DIR, file_name: file_name)

        expect(records.length).must_equal record_count
      end

      it 'finds data given a full path' do
        path = "#{TEST_DATA_DIR}/custom_filename_test.csv"
        records = TestRecord.load_all(full_path: path)

        expect(records.length).must_equal record_count
      end

      it 'calls `from_csv` for each record in the file' do
        TestRecord.load_all(directory: TEST_DATA_DIR)
        expect(TestRecord.call_count).must_equal record_count
      end
    end
  end
end
