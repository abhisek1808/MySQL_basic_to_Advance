create database sales;
use sales;

CREATE TABLE if not exists sales_data(
	order_id VARCHAR(15) NOT NULL, 
	order_date varchar(15) NOT NULL, 
	ship_date varchar(15) NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 5) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	`year` DECIMAL(38, 0) NOT NULL
);

/* set session sql_mode='' */

load data infile 
'D:/MySQL/Day-4/sales_data_final.csv'
into table sales_data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from sales_data;
truncate table sales_data;

/* try to change order_date column from string format to date format  
 and create a new column where date values will be inserted (order_date) to (order_date_new)*/

/*changing the data type format*/
select str_to_date(order_date,'%m/%d/%Y') 
from sales_data;

/* create table */
alter table sales_data
add column order_date_new date after order_date;

/*update or insert data into the column*/
SET SQL_SAFE_UPDATES = 0;
update sales_data
set order_date_new = str_to_date(order_date,'%m/%d/%Y');

/* another example (ship_date) to (ship_date_new)*/
select str_to_date(ship_date,'%m/%d/%Y') from sales_data;

alter table sales_data
add column ship_date_new date after ship_date;

update sales_data 
set ship_date_new =  str_to_date(ship_date,'%m/%d/%Y');

select * from sales_data where ship_date_new = '2011-01-06';
select * from sales_data where ship_date_new > '2011-01-06';
select * from sales_data where ship_date_new < '2011-01-06';

/* how to know total sales of 2 months*/
select * from sales_data where ship_date_new between '2011-01-06' and '2011-05-06';

select now(); /* print Current Date and Time */
select curdate(); /*print  Current Date */
select curtime(); /* print Current Time */

/* how to check sales of last month, last week or last Year */ 
select * from sales_data 
where ship_date_new < date_sub(now(), interval 1 week); 

select * from sales_data 
where ship_date_new < date_sub('2011-02-28', interval 1 week); 

select date_sub(now() , interval 1 year); 
select date_sub(now() , interval 1 month);
select date_sub(now() , interval 3 day);

select year(now()); /* how to print current year */

/* how to print dayname  */
select dayname(now()) ;
select dayname('2023-01-15'); /* date format should be YYYY-MM-DD'*/

/*try to create a new column and and update current date*/
alter table sales_data
add column flag date after order_id;

SET SQL_SAFE_UPDATES = 0;
update sales_data
set flag = now();

alter table sales_data
modify column `year` varchar(10);

/* ALTER TABLE sales_data
modify column `year` datetime; */

/* create three new columns  and insert year, month and day values respectively
from order_date_new column*/
/* step-1*/
alter table sales_data 
add column year_new int;

alter table sales_data
add column month_new int;

alter table sales_data
add column day_new int;

/* step-2 */
update sales_data 
set year_new = year(order_date_new);

update sales_data 
set month_new = month(order_date_new);

update sales_data 
set day_new = day(order_date_new);


/* avg. sales year wise */
select year_new ,avg(sales) from sales_data group by year_new;

/* total sum of sales year wise */
select year_new ,sum(sales) from sales_data group by year_new;

/* minimum sales year wise */
select year_new ,min(sales) from sales_data group by year_new;

/* maximum sales year wise */
select year_new ,max(sales) from sales_data group by year_new;

/* total quantity of sales year wise */
select year_new ,sum(quantity) from sales_data group by year_new;

/* try to find out CTC = COST TO COMPANY */
SELECT (discount+shipping_cost) as CTC FROM sales_data;
SELECT (sales*discount+shipping_cost) as CTC FROM sales_data;

select * from sales_data LIMIT 5;

/* try to check in discount column  if discount is apllicable then update "YES" 
other wise update "NO" */
select order_id ,discount , if(discount > 0 ,'yes' , 'no') as discount_flag from sales_data ;

alter table sales_data
add column discount_flag varchar(10) after discount;

update sales_data
set discount_flag = if(discount > 0, 'yes','no');

/*how to show group wise information from discount_flag column */
select discount_flag , count(*) from sales_data group by discount_flag;
select count(*) as 'd>0' from  sales_data where discount > 0;  /*as--> aliashing */
