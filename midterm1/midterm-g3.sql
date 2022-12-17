-- 1.	Display the list of Customer in alphabetical order according to city
select * from customers order by city;

-- 2.	Display the list of customers and theirs orders. All orders of the same
-- customer must be grouped (appeared consecutively)
select customerid, orderid
from orders
order by customerid, orderid;

-- 3.	Convert credit card expiration (customers.creditcardexpiration) into
-- datetime data type. By default, expiration day is 1st day of month

-- 4.	Display information about the value of each order (including orderid,
-- netamount, tax, totalamount, the total value of order calculated from the
-- quantity and price)  Do you have any remark on the result?
select o.orderid, o.netamount, o.tax, o.totalamount, sum(ol.quantity * p.price)
from orders o
join orderlines ol on ol.orderid = o.orderid
join products p on p.prod_id = ol.prod_id
group by o.orderid;

-- 5.	Display the list of products and the orderid of orders containing this
-- product if any
select p.prod_id, ol.orderid
from products p
left join orderlines ol on ol.prod_id = p.prod_id
order by p.prod_id, ol.orderid;

-- 6.	Display the list of products appeared in the order(s)  on Dec 31, 2004
select distinct prod_id
from orderlines
where orderdate = '2004-12-31';

-- 7.	Delete all orders on Jan 1, 2004
-- Before:
select * from orders o where o.orderdate = '2004-01-01';
-- After:
begin;
delete
from orders
where orderdate = '2004-01-01';
select * from orders o where o.orderdate = '2004-01-01';
-- Rollback:
rollback;
select * from orders o where o.orderdate = '2004-01-01';

-- 8.	Do you have any comment/remarks on the previous query (number 7)

-- 9.	Display the list of customers whose credit card is expired in June 2011
select *
from customers c
where c.creditcardexpiration = '2011/06';

-- 10.	Display the list of customers without information of state
select * from customers where state is null;

-- 11.	Display the list of customers and the number of their order per month.
-- The list is in alphabetical order of customer firstname and lastname
select c.firstname, c.lastname, o.customerid, date_part('month', o.orderdate), count(o.orderid)
from orders o
join customers c on c.customerid = o.customerid
group by c.firstname, c.lastname, o.customerid, date_part('month', o.orderdate)
order by c.firstname, c.lastname, o.customerid, date_part('month', o.orderdate);

-- 12.	Display the list of products having the greatest total ordered quantity
with prod_total as (
	select prod_id, sum(quantity) total
	from orderlines
	group by prod_id
)
select prod_id, total
from prod_total
where total = (select max(total) from prod_total)

-- 13.	Display the list of products having the total ordered quantity greater
-- than the quantity in stock
with prod_total as (
	select orderlines.prod_id, quan_in_stock, sum(quantity) total
	from orderlines
	join inventory on inventory.prod_id = orderlines.prod_id
	group by orderlines.prod_id, quan_in_stock
)
select prod_id, quan_in_stock, total
from prod_total
where total > quan_in_stock;

-- 14.	Display the list of states and the number of customers in each state if
-- it is greater than 200
select c.state, count(c.customerid)
from customers c
where c.state is not null
group by c.state
having count(c.customerid) > 200;

