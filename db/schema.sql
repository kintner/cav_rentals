create table cars  (
car_id serial PRIMARY KEY,
location point,
price_hour money,
price_day money,
price_week money,
car_make varchar(20),
car_model varchar(20),
car_year varchar(20),
automatic_transmission boolean,
color varchar(20)
);

alter table cars add column location_geo geography;
update cars set location_geo = ST_SetSRID(ST_MakePoint(location[0], location[1]), 4326);


create type booking_type as ENUM ('billed', 'not-available');

create table bookings (
booking_id serial,
car_id integer references cars(car_id),
start_time timestamp with time zone,
end_time timestamp with time zone,
booking_type booking_type,
user_id integer references users(user_id),
calculated_cost money

);


create table car_exclusions  (
car_exclusions serial PRIMARY KEY,
car_id integer references cars(car_id),
day_of_week integer,
start_hour time,
end_hour time
);




create table users (
user_id serial primary key,
name varchar(100)
);


