-- 1. Display the list of categories in alphabetical order according to the
-- category name
select *
from categories c
order by c.categoryname;

-- 2. Display the list of orders and their details (orderlines)
select *
from orderlines ol
join orders o on o.orderid = ol.orderid;

-- 3. Update order date of the order number 2 (ordereid) to Jan 2, 2004
select * from orders o where o.orderid = 2;
update orders
set orderdate = '2004-01-02'
where orderid = 2;
select * from orders o where o.orderid = 2;

-- 4. Re-execute the query number 2. Is there any difference between the answer
-- of these 2 queries

-- 5. Display the list of customers and their order if any
select c.*, o.*
from customers c
left join orders o on o.customerid = c.customerid;

-- 6. Display the list of products appeared in the order(s)  on Jan 1, 2004
select *
from products p
where p.prod_id in (
    select o.prod_id
    from orderlines o
    where o.orderdate = '2004-01-01'
);

-- 7. Delete all orders on Jan 1, 2004
begin;
delete
from orders
where orderdate = '2004-01-01';
select * from orders o where o.orderdate = '2004-01-01';
rollback;
select * from orders o where o.orderdate = '2004-01-01';

-- 8. Do you have any comment/remarks on the previous query (number 7)

-- 9. Display the orders in January, 2004
select *
from orders o
where o.orderdate between '2004-01-01' and '2004-01-31';

-- 10. Display the list of customers whose credit card is expired in May 2012
select *
from customers c
where c.creditcardexpiration = '2012/05';

-- 11. Display the list of products and total  ordered quantities per month
select prod_id, DATE_PART('month', orderdate), sum(quantity)
from orderlines
group by prod_id, DATE_PART('month', orderdate)
order by prod_id, DATE_PART('month', orderdate);

-- 12. Display the products that is not ordered yet
select *
from products p
where p.prod_id not in (
    select o.prod_id
    from orderlines o
);

-- 13. Display the customers and the total amount of their orders
select c.*, sum(o.totalamount)
from customers c
join orders o on o.customerid = c.customerid
group by c.customerid;

-- 14. Display the list of states and the number of customers in each state if
-- it is greater than 200
select c.state, count(c.customerid)
from customers c
where c.state is not null
group by c.state
having count(c.customerid) > 200;

-- 14.
select o.orderid, o.netamount, o.tax, o.totalamount, sum(ol.quantity * p.price)
from orders o
join orderlines ol on ol.orderid = o.orderid
join products p on p.prod_id = ol.prod_id
group by o.orderid;
