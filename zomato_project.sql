use zomato;
select * from zomato;
--  1. Build a country Map Table
create table country_map(
Country_code int primary key,
country_Name varchar(50));
insert into Country_map values
(1,'India'),
(14,'Australia'),
(30,'Brazil'),
(37,'Canada'),
(94,'Indonesia'),
(148,'New Zealand'),
(162,'Philippines'),
(166,'Qatar'),
(184,'Singapore'),
(189,'South Africa'),
(191,'Sri Lanka'),
(208,'Turkey'),
(214,'UAE'),
(215,'United Kingdom'),
(216,'United States');
select * from country_map;
-- 2)2. Build a Calendar Table using the Column Datekey
create table calender_table(
Datekey date,
year int,
Month_no int,
Month_fullname varchar(20),
Quarter varchar(5),
YearMonth varchar(20),
Weekday_No int,
weekday_name varchar(15),
financial_month varchar(20),
financial_quarter varchar(5));
show columns from calender_table;
alter table calender_table
modify Quarter date;
describe calender_table;
DESCRIBE calender_table;
ALTER TABLE calender_table
MODIFY Quarter VARCHAR(5);
describe zomato;
UPDATE zomato
SET datekey_opening = STR_TO_DATE(datekey_opening, '%d-%m-%Y');
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE zomato
MODIFY datekey_opening DATE;
TRUNCATE TABLE calender_table;
INSERT INTO calender_table
SELECT DISTINCT
datekey_opening AS Datekey,
YEAR(datekey_opening) AS Year,
MONTH(datekey_opening) AS Month_no,
MONTHNAME(datekey_opening) AS Month_fullname,
CONCAT('Q', QUARTER(datekey_opening)) AS Quarter,
DATE_FORMAT(datekey_opening,'%Y-%b') AS YearMonth,
WEEKDAY(datekey_opening)+1 AS Weekday_No,
DAYNAME(datekey_opening) AS weekday_name,
CONCAT('FM',
CASE
WHEN MONTH(datekey_opening) >= 4
THEN MONTH(datekey_opening) - 3
ELSE MONTH(datekey_opening) + 9
END
) AS financial_month,
CONCAT('FQ',
CASE
WHEN MONTH(datekey_opening) BETWEEN 4 AND 6 THEN 1
WHEN MONTH(datekey_opening) BETWEEN 7 AND 9 THEN 2
WHEN MONTH(datekey_opening) BETWEEN 10 AND 12 THEN 3
ELSE 4
END
) AS financial_quarter
FROM zomato;
SELECT * FROM calender_table;
-- 3.Find the Numbers of Resturants based on City and Country.
select * from zomato;
select * from country_map;
select c.country_name,z.city,count(z.Restaurant_ID) as total_Restaurant
from zomato z
join country_map c
on c.country_code=z.countrycode
group by c.country_name,z.city
order by total_Restaurant desc;
-- 4)Numbers of Resturants opening based on Year , Quarter , Month
select * from calender_table;
select ct.year,ct.month_no,ct.month_fullname,ct.quarter,count(z.restaurant_id) as total_restaurant
from calender_table ct
join zomato z
on ct.datekey_opening=z.datekey_opening
group by ct.year,ct.month_no,ct.month_fullname,ct.quarter
order by year asc;
-- 5. Count of Resturants based on Average Ratings
select * from zomato;
select rating,count(restaurant_id) as total_restaurant
from zomato
group by rating
order by total_restaurant desc;
-- 6. Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
select * from zomato;
select 
case
when Average_Cost_for_two < 500 then "Low"
when Average_Cost_for_two between 500 and 1000 then "Medium"
when Average_Cost_for_two between 1001 and 2000 then "High"
else "Above Premium"
end as Price_Bucket,
count(restaurant_id) as Total_Restaurant
from zomato
group by Price_Bucket;
-- 7.Percentage of Resturants based on "Has_Table_booking"
select * from zomato;
select has_table_booking,
round(count(*)*100/(select count(*) from zomato),2) as Percentage
from zomato
group by has_table_booking;
-- 8.Percentage of Resturants based on "Has_Online_delivery"
select * from zomato;
select has_online_delivery,
 round(count(*)*100/(select count(*)  from zomato),2) as Percentage
 from zomato
 group by has_online_delivery;
 -- 9)Develop Charts based on Cusines, City, Ratings
select * from zomato;
select Cuisines,
count(restaurant_id) as Total_Restaurnt
from zomato
group by Cuisines
order by  Total_Restaurnt desc
limit 10;
select city,
count(restaurant_id) as total_restaurant
from zomato
group by city
order by total_restaurant desc
limit 10;
select * from zomato;
select rating,
count(restaurant_id) as total_restaurant
from zomato
group by rating;





