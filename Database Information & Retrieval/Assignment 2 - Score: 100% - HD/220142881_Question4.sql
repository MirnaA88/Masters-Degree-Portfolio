#Qn4 Task 1.1
select c.customer_id, c.name, SUM(oi.Quantity*oi.unit_price) as Total_Amount
from Customers c inner join Orders o
inner join order_items oi
on c.customer_id = o.customer_id
and oi.order_id = o.order_id
where o.status !="Canceled"
group by c.customer_id

#Qn 4 - Task 1.2
select e.employee_id, e.first_name, e.last_name,SUM(oi.Quantity*oi.unit_price) as Total_Amount
from employees e inner join Orders o
inner join order_items oi
on e.employee_id = o.salesman_id
and oi.order_id = o.order_id
where o.status !="Canceled"
group by e.employee_id

#Qn4 Task 1.3
Select emp.employee_id, emp.first_name, emp.last_name, mgr.employee_id as manager_id, 
mgr.first_name as manager_firstname, mgr.last_name as manager_lastname
from employees emp 
inner join employees mgr on emp.manager_id = mgr.employee_id
where ((emp.first_name like '%a%' or '%c%') or (emp.last_name like '%a%' or '%c%'))
and ((mgr.first_name like '%a%' or '%c%') or (mgr.last_name like '%a%' or '%c%'))
order by emp.first_name desc

#Qn4 Task 1.4
select p.product_id, p.product_name, p.list_price
from products p
left join order_items as oi
on p.product_id = oi.product_id
Where oi.product_id is null
order by p.list_price;

#Qn4 Task 1.5
Select i.warehouse_id, w.warehouse_name, SUM(oi.Quantity*oi.unit_price) as Total_Sales
from order_items oi inner join inventories i
inner join warehouses w
on oi.product_id = i.product_id
and i.warehouse_id = w.warehouse_id
group by w.warehouse_name
order by Total_Sales Desc

#Qn4 task 1.6
Select p.product_name, p.product_id, w.warehouse_name, i.quantity
from products p inner join inventories i
inner join warehouses w
on p.product_id = i.product_id
and i.warehouse_id = w.warehouse_id
group by p.product_name, w.warehouse_name
order by i.quantity desc

