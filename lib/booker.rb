class Booker
  attr :user, :lat, :long, :distance, :start_time, :end_time

  def initialize(user:, lat:, long:, distance:, start_time:, end_time:)
    @user = user
    @lat = lat
    @long = long
    @distance = distance
    @start_time = start_time
    @end_time = end_time
  end

  def perform_search
    Car.find_cars(lat, long, distance, start_time, end_time)
  end

  def book(car_id)
    booking = Booking.new(car_id: car_id, start_time: start_time, end_time: end_time, booking_type: 'billed', user: user)

    if Car.check_and_insert(lat, long, distance, start_time, end_time, booking)
      booking
    else
      nil
    end
  end
end
