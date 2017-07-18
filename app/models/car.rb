class Car < ActiveRecord::Base
  belongs_to :user

  def self.within_distance(lat, long, distance)
    where("ST_DWithin(location_geo, ST_SetSRID(ST_Point(?, ?), 4326), ?)", lat, long, distance)
  end

  def self.find_cars(lat, long, distance, start_time, end_time, car_id: nil)
    scope = Car.within_distance(lat, long, distance).
      where("car_id NOT IN (select car_id from bookings where (start_time, end_time) OVERLAPS (?, ?))", start_time, end_time)

    if car_id
      scope = scope.where(car_id: car_id)
    end

    scope.select do |car|
      CarExclusion.car_available?(car, start_time, end_time)
    end
  end

  def self.check_and_insert(lat, long, distance, start_time, end_time, booking)
    transaction do
      car = find_cars(lat, long, distance, start_time, end_time, car_id: booking.car_id).lock(true).first

      if car
        booking.save!
        true
      else
        false
      end
    end
  end
end






### cli
# First: lat, long
# Second distance
# Start time
# End time
#
# it returns 10 cars that are avilable
# then you select car and book
