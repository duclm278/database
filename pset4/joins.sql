-- 1
select d.*, l.street_address, l.city, l.state_province, c.country_name
from departments as d
join locations as l on l.location_id = d.location_id
join countries as c on c.country_id = l.country_id;

-- 2
select e.first_name, e.last_name, e.department_id, d.department_name
from employees as e
join departments as d on d.department_id = e.department_id;

-- 3
select e.first_name, e.last_name, j.job_title, e.department_id, d.department_name
from employees as e
join jobs as j on j.job_id = e.job_id
join departments as d on d.department_id = e.department_id
join locations as l on l.location_id = d.location_id
where l.city = 'London';

-- 4
select e1.employee_id, e1.last_name, e1.manager_id, e2.last_name
from employees as e1
join employees as e2 on e2.employee_id = e1.manager_id;

-- 7
select jh.employee_id, j.job_title, (jh.end_date - jh.start_date) as days
from job_history as jh
join jobs as j on j.job_id = jh.job_id
where jh.department_id = 90;

-- 11
select j.job_title, e.employee_id, e.last_name, (e.salary - j.min_salary) as diff
from employees as e
join jobs as j on j.job_id = e.job_id;

-- 12
select jh.*
from job_history as jh
join employees as e on e.employee_id = jh.employee_id
where e.salary > 10000;

-- 13
select
	d.department_id,
	d.department_name,
	d.manager_id,
	e.first_name,
	e.last_name,
	e.hire_date,
	e.salary
from departments as d
join job_history as jh on jh.employee_id = d.manager_id
join employees as e on e.employee_id = d.manager_id
group by d.department_id, e.employee_id
having date_part('year', now()) - date_part('year', min(jh.start_date)) > 15;
