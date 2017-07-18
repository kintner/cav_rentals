require 'CSV'
require 'byebug'

csv_text = File.read('car_interview_data.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Car.create!(
    location: "(#{row["lat"]}, #{row["lon"]})",
    price_hour: row["hour_pricing"],
    price_day: row["daily_pricing"],
    price_week: row["week_pricing"],
    car_make: row["car_make"],
    car_model: row["car_model"],
    car_year: row["car_year"],
    automatic_transmission: row["automatic_transmission"],
    color: row["color"]
    )
end
