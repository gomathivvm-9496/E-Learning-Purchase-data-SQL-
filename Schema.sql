select version();
create database if not exists elearning_purchase_data;
use elearning_purchase_data;

create table learners(
learner_id INT Primary Key ,
full_name varchar(100),
Country varchar(100));

create table courses(
course_id  INT Primary Key ,
course_name varchar(50),
category varchar(50),
unit_price  decimal(10,2)
);

create table purchases(
purchase_id  INT Primary Key ,
learner_id INT,
course_id INT,
Quantity INT,
purchase_date date,
foreign key(learner_id) references learners(learner_id),
foreign key(course_id) references courses(course_id)
);

Insert into courses values
(101,"Digital marketing","marketing",5782.25),
(102,"SQL for Advanced","Database",2587.36),
(103,"Excel for beginners","Analytics",4872.26),
(104,"Power BI","Analytics",7582.15),
(105,"Python for Masterclass","Programming",1254.55);

Insert into learners values
(1,"Anitha","India"),
(2,"BanuRekha","USA"),
(3,"Chandru","Spain"),
(4,"Dhanshith","Canada"),
(5,"Girija","UK");



Insert into purchases values
(1001,1,102,1,'2025-01-22'),
(1002,2,103,1,'2025-03-12'),
(1003,3,105,2,'2025-06-19'),
(1004,4,104,1,'2025-10-25'),
(1005,5,101,1,'2025-12-30'),
(1006,2,102,1,'2025-08-06'),
(1007,4,104,1,'2025-02-02'),
(1008,1,103,1,'2025-11-26');



