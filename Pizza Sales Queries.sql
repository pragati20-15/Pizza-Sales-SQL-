
create database Pizzabox;

create table orders(
order_id int primary key,
order_date date not null,
order_time time not null);

create table order_details(
order_details_id int primary key,
order_id int not null,
pizza_id text not null,
quantity int not null);


/*Retrieve the total number of orders placed.*/
select count(order_id) as orders_placed 
from orders;

/*Retrive the different categories of pizzas.*/
select distinct category from pizza_types;

/*Calculate the total revenue generated from pizza sales.*/
select round(sum(d.quantity * p.price), 2) as total_revenue
from order_details d
join pizzas p 
on d.pizza_id = p.pizza_id;

/*Identify the highest-priced pizza.*/
select pt.name, p.price
from pizza_types pt
join pizzas p 
on pt.pizza_type_id = p.pizza_type_id
order by p.price desc
limit 1;

/*Identify the most common pizza size ordered.*/
select p.size, count(d.order_details_id) as count
from pizzas p
join order_details d 
on p.pizza_id = d.pizza_id
group by p.size
order by count desc;

/*List the top 5 most ordered pizza types along with their quantities.*/
select pt.name,sum(d.quantity) as quantity
from pizza_types pt
join pizzas p 
on pt.pizza_type_id=p.pizza_type_id
join order_details d
on d.pizza_id=p.pizza_id
group by pt.name
order by quantity desc
limit 5;

/*Determine the distribution of orders by hour of the day.*/
select hour(order_time),count(order_id)
from orders
group by hour(order_time);

/*find the category-wise distribution of pizzas.*/
select count(name),category 
from pizza_types
group by category;

/*Determine the top 3 most ordered pizza types based on revenue.*/
select pt.name,sum(p.price*d.quantity) as revenue
from pizza_types pt
join pizzas p
on pt.pizza_type_id=p.pizza_type_id
join order_details d
on p.pizza_id=d.pizza_id
group by name
order by revenue desc
limit 3;

/*Detremine the names of pizzas whose revenue is more than 30000.*/
select pt.name,sum(p.price*d.quantity) as  revenue
from pizza_types pt
join pizzas p 
on pt.pizza_type_id=p.pizza_type_id
join order_details d
on d.pizza_id=p.pizza_id
group by name 
having revenue>30000;

/*Find the customers who have placed more than ten order.*/
select order_id ,count(*) as order_count 
from order_details 
group by order_id
having order_count>10;

/*Find pizza IDs that are in the pizzas table but not in the order_details table.*/
select pizza_id from pizzas
except
select pizza_id from order_details;

/*Find all orders placed between first 10 days.*/
select * from orders where order_date between '2015-01-01' and '2015-01-10';

/*Find all pizza types that start with the word 'Veg'.*/
select* from pizza_types where category like'Veg%';


