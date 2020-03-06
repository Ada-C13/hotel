require_relative 'test_helper'

describe "Driver class" do
  describe "Driver instantiation" do
    before do
      @driver = RideShare::Driver.new(
        id: 54,
        name: "Test Driver",
        vin: "12345678901234567",
        status: :AVAILABLE
      )
    end

    it "is an instance of Driver" do
      expect(@driver).must_be_kind_of RideShare::Driver
    end

    it "throws an argument error with a bad ID" do
      expect { RideShare::Driver.new(id: 0, name: "George", vin: "33133313331333133") }.must_raise ArgumentError
    end

    it "throws an argument error with a bad VIN value" do
      expect { RideShare::Driver.new(id: 100, name: "George", vin: "") }.must_raise ArgumentError
      expect { RideShare::Driver.new(id: 100, name: "George", vin: "33133313331333133extranums") }.must_raise ArgumentError
    end

    it "has a default status of :AVAILABLE" do
      expect(RideShare::Driver.new(id: 100, name: "George", vin: "12345678901234567").status).must_equal :AVAILABLE
    end

    it "sets driven trips to an empty array if not provided" do
      expect(@driver.trips).must_be_kind_of Array
      expect(@driver.trips.length).must_equal 0
    end

    it "is set up for specific attributes and data types" do
      [:id, :name, :vin, :status, :trips].each do |prop|
        expect(@driver).must_respond_to prop
      end

      expect(@driver.id).must_be_kind_of Integer
      expect(@driver.name).must_be_kind_of String
      expect(@driver.vin).must_be_kind_of String
      expect(@driver.status).must_be_kind_of Symbol
    end
  end

  describe "add_trip method" do
    before do
      pass = RideShare::Passenger.new(
        id: 1,
        name: "Test Passenger",
        phone_number: "412-432-7640"
      )
      @driver = RideShare::Driver.new(
        id: 3,
        name: "Test Driver",
        vin: "12345678912345678"
      )
      @trip = RideShare::Trip.new(
        id: 8,
        driver: @driver,
        passenger: pass,
        start_time: Time.new(2016, 8, 8),
        end_time: Time.new(2018, 8, 9),
        cost: 100,
        rating: 5
      )
    end

    it "adds the trip" do
      expect(@driver.trips).wont_include @trip
      previous = @driver.trips.length

      @driver.add_trip(@trip)

      expect(@driver.trips).must_include @trip
      expect(@driver.trips.length).must_equal previous + 1
    end
  end

  describe "average_rating method" do
    before do
      @driver = RideShare::Driver.new(
        id: 54,
        name: "Rogers Bartell IV",
        vin: "1C9EVBRM0YBC564DZ"
      )
      trip = RideShare::Trip.new(
        id: 8,
        driver: @driver,
        passenger_id: 3,
        start_time: Time.new(2016, 8, 8),
        end_time: Time.new(2016, 8, 8),
        cost: 100,
        rating: 5
      )
      @driver.add_trip(trip)
    end

    it "returns a float" do
      expect(@driver.average_rating).must_be_kind_of Float
    end

    it "returns a float within range of 1.0 to 5.0" do
      average = @driver.average_rating
      expect(average).must_be :>=, 1.0
      expect(average).must_be :<=, 5.0
    end

    it "returns zero if no driven trips" do
      driver = RideShare::Driver.new(
        id: 54,
        name: "Rogers Bartell IV",
        vin: "1C9EVBRM0YBC564DZ"
      )
      expect(driver.average_rating).must_equal 0
    end

    it "correctly calculates the average rating" do
      trip2 = RideShare::Trip.new(
        id: 8,
        driver: @driver,
        passenger_id: 3,
        start_time: Time.new(2016, 8, 8),
        end_time: Time.new(2016, 8, 9),
        cost: 200,
        rating: 1
      )
      @driver.add_trip(trip2) #added another trip to test trip in progress calculation for average
      trip3 = RideShare::Trip.new(
        id: 2,
        driver: @driver,
        passenger_id: 3,
        start_time: Time.new(2016, 8, 8),
        end_time: nil,
        cost: 1000,
        rating: 1
      )
      @driver.add_trip(trip3)
      expect(@driver.average_rating).must_be_close_to (5.0 + 1.0) / 2.0, 0.01
    end
  end

  #Wave 2: total revenue test
  describe "total_revenue" do

    before do
      @driver = RideShare::Driver.new(
        id: 54,
        name: "Rogers Bartell IV",
        vin: "1C9EVBRM0YBC564DZ"
      )
    end
   
    it 'total revenue with no trips' do
      total = @driver.total_revenue
      expect(total).must_equal 0 
    end

    it 'total revenue with trips' do
      #add trip
      trip1 = RideShare::Trip.new(
        id: 1,
        driver: @driver,
        passenger_id: 3,
        start_time: Time.new(2016, 8, 8),
        end_time: Time.new(2016, 8, 9),
        cost: 101.65,
        rating: 1
      )
      @driver.add_trip(trip1)
      trip2 = RideShare::Trip.new(
        id: 2,
        driver: @driver,
        passenger_id: 3,
        start_time: Time.new(2016, 8, 8),
        end_time: Time.new(2016, 8, 9),
        cost: 201.65,
        rating: 1
      )
      @driver.add_trip(trip2)
      trip3 = RideShare::Trip.new(
        id: 3,
        driver: @driver,
        passenger_id: 3,
        start_time: Time.new(2016, 8, 8),
        end_time: nil,
        cost: 400,
        rating: nil
      )
      @driver.add_trip(trip3)
      #expect total
      expect(@driver.total_revenue).must_equal 240
      
    end
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
