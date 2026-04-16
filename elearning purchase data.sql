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


select * from learners;
select * from courses;
select * from purchases;


select l.full_name as learner_name,c.course_name ,c.category,p.Quantity,
format(c.unit_price * p.Quantity,2) as total_amount,p.purchase_date from purchases p
join learners l ON p.learner_id=l.learner_id
join courses c ON p.course_id=c.course_id;

Insert into learners values 
(6,"harsha","China");


 -- All learners even without purchases
select l.full_name as learner_name,c.course_name,p.Quantity from learners l
left join purchases p ON p.learner_id=l.learner_id
left join courses c ON p.course_id=c.course_id;

 -- All courses if not purchased
 
 select c.course_id,c.course_name,l.full_name as learner_name,p.Quantity
 from purchases p
 Right join courses c ON p.course_id=c.course_id
 Left join learners l ON p.learner_id=l.learner_id;
 
 -- Q1. Display each learner’s total spending (quantity × unit_price) along with their country.
select l.full_name as learner_name,l.country,FORMAT(SUM(p.Quantity*c.unit_price),2) as total_spent
from learners l
left join purchases p on l.learner_id=p.learner_id
left join courses c on p.course_id=c.course_id
Group by l.learner_id,learner_name,l.country
order by Sum(p.Quantity*c.unit_price) desc;

 -- Q2. Find the top 3 most purchased courses based on total quantity sold.
 select c.course_name,c.course_id,sum(p.Quantity) as total_quantity
 from purchases p
 join courses c on p.course_id=c.course_id
 group by c.course_id,c.course_name
 order by total_quantity DESC
 limit 3;
 
 -- Q3. Show each course category’s total revenue and the number of unique learners who purchased from that category.
select c.category,format(sum(c.unit_price*p.Quantity),2) as total_revenue,count(distinct(p.learner_id))
from purchases p
join courses c on p.course_id=c.course_id
group by c.category;

 -- Q4. List all learners who have purchased courses from more than one category.
select l.learner_id,l.full_name,count(distinct(c.category)) as count_category
from purchases p
join learners l on p.learner_id=l.learner_id
join courses c on p.course_id=c.course_id
group by l.learner_id,l.full_name
having count_category>1;



-- Q5. Identify courses that have not been purchased at all.

insert into courses values
(106,"Excel advanced","Analytics",2547.52);
select * from purchases ;
select * from courses ;

select c.course_name from courses c
join purchases p on p.course_id=c.course_id
where p.course_id is NULL;

-- Q6. Which country generates the highest total revenue?

select l.Country,format(sum(p.Quantity*c.unit_price),2) as total_revenue
from learners l
join purchases p on l.learner_id=p.learner_id
join courses c on p.course_id=c.course_id
group by l.country 
order by sum(p.Quantity*c.unit_price) DESC
limit 1;


 -- Q7. Average spending per learner
select format(avg(total_spent),2) as average_spent 
from (
  select sum(p.Quantity*c.unit_price) as total_spent
  from purchases p
  join courses c on p.course_id=c.course_id
  group by p.learner_id) as learner_total;
  
  
 -- Q8. Course with highest revenue

select c.course_id,c.course_name,format(sum(p.Quantity*c.unit_price),2) as total_revenue
from purchases p
join courses c on p.course_id=c.course_id
group by c.course_id,c.course_name
order by sum(p.Quantity*c.unit_price)  DESC
limit 1;


 -- Q9. Monthly revenue trend
select date_format(p.purchase_date,'%Y-%m') as purchase_month,format(sum(p.Quantity*c.unit_price),2) as monthly_revenue
from purchases p
join courses c on p.course_id=c.course_id
group by purchase_month
order by purchase_month;


 -- Q10. Repeat buyers (learners with more than one purchase)

select l.learner_id,l.full_name,count(p.purchase_id) as total_purchase
from learners l
join purchases p on l.learner_id=p.learner_id
group by l.learner_id,l.full_name
Having total_purchase>1;












