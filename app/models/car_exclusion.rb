class CarExclusion < ActiveRecord::Base

  def self.car_available?(car, start_time, end_time)
    if start_time.to_date == end_time.to_date
      self.for_day(car, start_time, end_time)
    else
      return false unless self.for_day(car, start_time, Time.parse("23:59"))

      return false unless self.for_day(car, end_time.to_date.to_time, end_time)

      (start_time.to_date + 1).upto(end_time.to_date - 1) do |day|
        return false if CarExclusion.where(car_id: car, day_of_week: day.wday).any?
      end

      true
    end
  end

  def self.for_day(car, start_time, end_time)
    CarExclusion.where(car_id: car).where("day_of_week = ? AND (start_hour, end_hour) OVERLAPS (?::time, ?::time)", start_time.wday, start_time.to_s(:db), end_time.to_s(:db)).empty?
  end
end
