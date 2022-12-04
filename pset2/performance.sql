-- Slower. Avoid caculation on attributes.
select * from orderlines where quantity / 3 = 1;

-- Faster. Caculation on fixed values.
select * from orderlines where quantity = 1 * 3;

-- Explicit Joins are faster than Implicit Joins.

-- Try using IN to avoid joining tables.
