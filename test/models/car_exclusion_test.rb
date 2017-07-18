require_relative '../test_helper'

class CarExclusionTest < ActiveSupport::TestCase
  setup do
    @car = Car.create!
    CarExclusion.create!(car_id: @car.id, day_of_week: 1, start_hour: "03:00", end_hour: "09:00")
    CarExclusion.create!(car_id: @car.id, day_of_week: 2, start_hour: "00:00", end_hour: "09:00")
    CarExclusion.create!(car_id: @car.id, day_of_week: 4, start_hour: "11:30", end_hour: "12:00")
  end

  test "it handles a single day booking" do
    assert CarExclusion.car_available?(@car, Time.parse("2017-07-17 9:30"), Time.parse("2017-07-17 10:30"))

    refute CarExclusion.car_available?(@car, Time.parse("2017-07-17 7:30"), Time.parse("2017-07-17 10:30"))
  end

  test "it handles a two day booking" do
    assert CarExclusion.car_available?(@car, Time.parse("2017-07-16 9:30"), Time.parse("2017-07-17 2:30"))

    refute CarExclusion.car_available?(@car, Time.parse("2017-07-16 9:30"), Time.parse("2017-07-17 4:30"))
  end


  test "it handles a multiple day booking" do
    assert CarExclusion.car_available?(@car, Time.parse("2017-07-18 9:30"), Time.parse("2017-07-20 10:30"))

    refute CarExclusion.car_available?(@car, Time.parse("2017-07-18 9:30"), Time.parse("2017-07-20 11:35"))
  end
end
