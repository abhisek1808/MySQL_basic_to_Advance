create database dress_data;
use dress_data;

create table if not exists dress(
Dress_ID varchar(30),
Style varchar(30),
price varchar(30),
Rating varchar(30),
Size  varchar(30),
Season varchar(30),	
NeckLine varchar(30),	
SleeveLength varchar(30),	
waiseline varchar(30),	
Material varchar(30),	
FabricType varchar(30),	
Decoration varchar(30),	
Pattern_Type varchar(30),	
Recommendation varchar(30)
);

/* How to load bulk of data using sql queries or automatically */
load data infile 
'D:/MySQL/AttributeDataSet.csv'
into table dress
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from dress;

/* (constraints_1) auto_increment and 
primary key is use in test1 table 
*/
create table if not exists test1 ( 
test_id int auto_increment,
test_name varchar(30) , 
test_mail_id varchar(30),
test_adress varchar(30),
primary key (test_id));

/* data insert in table test1 */
insert into test1 values (1,'abhisek','abhi@gmail.com','bam'),
(2,'disha','disha@gmail.com','bam'),
(3,'priya','priya@gmail.com','bbsr'),
(4,'ram','ram@gmail.com','bam');

select * from test1;

/* (constraints_2) not null */
create table if not exists test2(
test_id int not null auto_increment,
test_name varchar(30) , 
test_mail_id varchar(30),
test_adress varchar(30),
primary key (test_id));

/* In table test2  some selected data are inserted and 
test_id is automatically inserted in the table */

insert into test2 (test_name,test_mail_id,test_adress) values
('abhisek','abhi@gmail.com','bam'),
('disha','disha@gmail.com','bam'),
('priya','priya@gmail.com','bbsr'),
('ram','ram@gmail.com','bam');

select * from test2;

/* (constraints_3) check  */
create table if not exists test3(
test_id int ,
test_name varchar(30) , 
test_mail_id varchar(30),
test_adress varchar(30),
test_salary int check (test_salary > 10000));


alter table test3 add check (test_id > 0);

/* In table test3 first check (test_id is greater than zero) and (test_salary = 10000) 
if two conditions satisfy then the data is inserted else it is not inserted */
insert into test3 values
(1,'abhisek','abhi@gmail.com','bam',50000),
(2,'disha','disha@gmail.com','bam',60000),
(3,'priya','priya@gmail.com','bbsr',10001),
(4,'ram','ram@gmail.com','bam',21000);

insert into test3 values (3,'priya','priya@gmail.com','bbsr',10000); /*not valid*/
insert into test3 values (0,'priya','priya@gmail.com','bbsr',10001); /* not valid*/

create table if not exists test4(
test_id int ,
test_name varchar(30), 
test_mail_id varchar(30),
test_adress varchar(30) check (test_adress = 'bam'),
test_salary int check (test_salary > 10000));

/* In table test4 first check (test_address = 'bam') and (test_salary = 10000) 
if two condition is satisfy then the data inserted else it is not inserted  
(note : inserted time your varchar is any type like uppercase,lowercase etc .) */

insert into test4 values (0,'abhisek','abhi@gmail.com','bam',50000);
insert into test4 values (2,'disha','disha@gmail.com','BAM',60000);

select * from test4 ;

/* (constraints_4) not null */
create table if not exists test5(
test_id int not null ,
test_name varchar(30) , 
test_mail_id varchar(30),
test_adress varchar(30) check (test_adress = 'bam'),
test_salary int check (test_salary > 10000));

/* if (not null) is used in a column but  you do not inserted the value then an error occurs.*/
insert into test5 (test_name,test_mail_id,test_adress,test_salary) 
values ('abhisek','abhi@gmail.com','bam',50000); /* field _id doesn't have a default value*/

/* (constraints_5) default */
create table if not exists test6(
test_id int not null default 0,
test_name varchar(30) , 
test_mail_id varchar(30),
test_adress varchar(30) check (test_adress = 'bam'),
test_salary int check (test_salary > 10000));

/* if (not null) is used in a column but you do not inserted then the default value is inserted.*/
insert into test6 (test_name,test_mail_id,test_adress,test_salary) 
values ('disha','disha@gmail.com','BAM',60000);

select * from test6;

/* (constraints_6) unique */
create table if not exists test7(
test_id int not null default 0,
test_name varchar(30) , 
test_mail_id varchar(30) unique,
test_adress varchar(30) check (test_adress = 'bam'),
test_salary int check (test_salary > 10000));

/* unique means no duplicate value is allowed to insert */
insert into test7 values (1,'disha','disha@gmail.com','BAM',60000);
insert into test7 values (2,'disha','disha@gmail.com','BAM',60000);   /*Duplicate entry 'disha@gmail.com' for key 'test7.test_mail_id'*/


/* all constraints are used in this table */
create table if not exists test8(
test_id int not null auto_increment,
test_name varchar(30) default 'unknown' not null, 
test_mail_id varchar(30) unique not null,
test_adress varchar(30) check (test_adress = 'bam') not null,
test_salary int check (test_salary > 10000) not null,
primary key(test_id));

/* error --> alter table test8 add check (test_id > 0)	
Check constraint 'test8_chk_3' cannot refer to an auto-increment column.*/
alter table test8 add check (test_id > 0);

insert into test8 values (1,'suraj','suraj@gmail.com','bam',55000);
insert into test8 (test_name,test_mail_id,test_adress,test_salary) values ('disha','disha@gmail.com','BAM',60000);
insert into test8 (test_name,test_mail_id,test_adress,test_salary) values ('sweety','disha@gmail.com','BaM',60000);/*not valid and it affected a row in table*/
insert into test8 (test_name,test_mail_id,test_adress,test_salary) values ('sweety','sweety@gmail.com','BaM',60000);

/*Error Code: 1062. Duplicate entry '1' for key 'test8.PRIMARY' because test_id is primary key and it is always unique*/
insert into test8 values (1,'ninja','ninja@gmail.com','bam',58000);
insert into test8 (test_mail_id,test_adress,test_salary) values ('abhia@gmail.com','BAM',60000);

select * from test8;

/*Q. what is the difference between unique and primary key ?*/
