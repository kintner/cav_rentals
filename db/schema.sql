create table cars  (
car_id serial PRIMARY KEY,
location point,
price_hour money,
price_day money,
price_week money,
color varchar(20)
);

create type booking_type as ENUM ('billed', 'not-available')

create table bookings (
booking_id serial,
car_id integer references cars(car_id),
start_time timestamp with time zone,
end_time timestamp with time zone,
booking_type booking_type,
user_id integer references users(user_id),
calculated_cost money
);

create table users (
user_id serial primary key,
name varchar(100)
)


