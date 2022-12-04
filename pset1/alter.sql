-- Primary Keys
ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);

ALTER TABLE ONLY countries
	ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);

ALTER TABLE ONLY locations
	ADD CONSTRAINT locations_pkey PRIMARY KEY (location_id);

ALTER TABLE ONLY departments
	ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);

ALTER TABLE ONLY jobs
	ADD CONSTRAINT jobs_pkey PRIMARY KEY (job_id);

ALTER TABLE ONLY employees
	ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);

ALTER TABLE ONLY job_history
	ADD CONSTRAINT job_history_pkey PRIMARY KEY (employee_id, start_date);

ALTER TABLE ONLY job_grades
	ADD CONSTRAINT job_grades_pkey PRIMARY KEY (grade_level);

-- Foreign Keys
ALTER TABLE ONLY countries
    ADD CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES regions (region_id);

ALTER TABLE ONLY locations
    ADD CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES countries (country_id);

ALTER TABLE ONLY departments
    ADD CONSTRAINT fk_location_id FOREIGN KEY (location_id) REFERENCES locations (location_id);

ALTER TABLE ONLY employees
	ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE ONLY employees
	ADD CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE ONLY job_history
	ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employees (employee_id);

ALTER TABLE ONLY job_history
	ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs (job_id);

ALTER TABLE ONLY job_history
	ADD CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments (department_id);
