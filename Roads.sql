--!! To clean the slate

drop table CNTJOBS cascade constraints;
drop table EMPJOBS cascade constraints;
drop table EMPPROJ cascade constraints;
drop table PROJROAD cascade constraints;
drop table ROADLOC cascade constraints;
drop table ROADCAT cascade constraints;
drop table CONTRACTS cascade constraints;
drop table CONTRACTORS cascade constraints;
drop table JOBS cascade constraints;
drop table EMPLOYEES cascade constraints;
drop table PROJECTS cascade constraints;
drop table LOCATIONS cascade constraints;
drop table CATEGORIES cascade constraints;
drop table ROADS cascade constraints;


--!! Created Tables

CREATE TABLE CATEGORIES (
    -- Attributes
    cat_id                  NUMBER(2) PRIMARY KEY,
    cat_name                VARCHAR2(20) NOT NULL
);

CREATE TABLE LOCATIONS (
    -- Attributes
    loc_id                  NUMBER PRIMARY KEY,
    loc_name                VARCHAR2(40) NOT NULL,
    loc_start_lat           NUMBER(9,6) NOT NULL,
    loc_start_long          NUMBER(9,6) NOT NULL,
    loc_end_lat             NUMBER(9,6) NOT NULL,
    loc_end_long            NUMBER(9,6) NOT NULL,
    loc_description         VARCHAR2(60)
);

CREATE TABLE PROJECTS (
    -- Attributes
    proj_code               NUMBER PRIMARY KEY,
    proj_name               VARCHAR2(40) NOT NULL,
    proj_description        VARCHAR2(60),
    proj_start_date         DATE NOT NULL,
    proj_end_date           DATE NOT NULL
);

CREATE TABLE EMPLOYEES (
    -- Attributes
    emp_id                  NUMBER PRIMARY KEY,
    emp_first_name          VARCHAR2(15) NOT NULL,
    emp_last_name           VARCHAR2(15) NOT NULL,
    emp_hire_date           DATE NOT NULL,
    emp_dob                 DATE NOT NULL,
    emp_gender              CHAR(1) NOT NULL,
    emp_street              VARCHAR2(30) NOT NULL,
    emp_city                VARCHAR2(15) NOT NULL,
    emp_zip                 NUMBER NOT NULL,
    emp_country             VARCHAR2(20) NOT NULL,
    emp_phone               NUMBER NOT NULL,
    emp_email               VARCHAR2(20) NOT NULL
    
);

CREATE TABLE JOBS (
    -- Attributes
    job_name                VARCHAR2(25) PRIMARY KEY,
    job_description         VARCHAR2(60)
);

CREATE TABLE CONTRACTORS (
    -- Attributes
    cont_name               VARCHAR2(30) PRIMARY KEY,
    cont_contact            NUMBER NOT NULL,
    cont_street             VARCHAR2(30) NOT NULL,
    cont_city               VARCHAR2(15) NOT NULL,
    cont_zip                NUMBER NOT NULL,
    cont_country            VARCHAR2(20) NOT NULL
);

CREATE TABLE ROADS (
    -- Attributes
    rd_id                   CHAR(6) PRIMARY KEY,
    rd_name                 VARCHAR2(50) NOT NULL,
    rd_description          VARCHAR2(60),
    roadsrd_id              CHAR(6),
    -- Constraints
    CONSTRAINT fk_roads_roads_rd_id FOREIGN KEY (roadsrd_id) REFERENCES ROADS (rd_id)
);


--!! Created Foreign Keys Tables

CREATE TABLE CONTRACTS (
    -- Attributes
    cnt_number              NUMBER PRIMARY KEY,
    cnt_name                VARCHAR2(15) NOT NULL,
    cnt_description         VARCHAR2(60),
    cnt_est_cost            NUMBER(38,2) NOT NULL,
    cnt_actual_cost         NUMBER(38,2),
    cnt_start_date          DATE NOT NULL,
    cnt_end_date            DATE NOT NULL,
    projectsproj_code       NUMBER,
    contractorscont_name    VARCHAR2(20),
    -- Constraints
    CONSTRAINT fk_contracts_projects_proj_code FOREIGN KEY (projectsproj_code) REFERENCES PROJECTS (proj_code),
    CONSTRAINT fk_contracts_contractors_cont_name FOREIGN KEY (contractorscont_name) REFERENCES CONTRACTORS (cont_name)
);


--!! Created Bridging Tables

CREATE TABLE ROADCAT (
    -- Attributes
    roadsrd_id              CHAR(6), 
    categoriescat_id        NUMBER, 
    rd_status               VARCHAR2(15) NOT NULL,
    -- Constraints
    CONSTRAINT pk_roadcat_roadsrd_id PRIMARY KEY (roadsrd_id, categoriescat_id),
    CONSTRAINT fk_roadcat_roads_rd_id FOREIGN KEY (roadsrd_id) REFERENCES ROADS(rd_id),
    CONSTRAINT fk_roadcat_categories_rd_id FOREIGN KEY (categoriescat_id) REFERENCES CATEGORIES(cat_id)
);

CREATE TABLE ROADLOC (
    -- Attributes
    roadsrd_id              CHAR(6), 
    locationsloc_id         NUMBER, 
    rd_est_length           NUMBER NOT NULL,
    -- Constraints
    CONSTRAINT pk_roadloc_roadsrd_id PRIMARY KEY (roadsrd_id, locationsloc_id),
    CONSTRAINT fk_roadloc_roads_rd_id FOREIGN KEY (roadsrd_id) REFERENCES ROADS(rd_id),
    CONSTRAINT fk_roadloc_locations_loc_id FOREIGN KEY (locationsloc_id) REFERENCES LOCATIONS(loc_id)
); 

CREATE TABLE PROJROAD (
    -- Attributes
    roadsrd_id              CHAR(6), 
    projectsproj_code       NUMBER, 
    proj_status             VARCHAR2(15) NOT NULL,
    -- Constraints
    CONSTRAINT pk_projroad_roadsrd_id PRIMARY KEY (roadsrd_id, projectsproj_code),
    CONSTRAINT fk_projroad_roads_rd_id FOREIGN KEY (roadsrd_id) REFERENCES ROADS(rd_id),
    CONSTRAINT fk_projroad_projects_proj_code FOREIGN KEY (projectsproj_code) REFERENCES PROJECTS(proj_code)
);

CREATE TABLE EMPPROJ (
    -- Attributes
    projectsproj_code       NUMBER, 
    employeesemp_id         NUMBER, 
    emp_status              VARCHAR2(15) NOT NULL,
    -- Constraints
    CONSTRAINT pk_empproj_projectsproj_code PRIMARY KEY (projectsproj_code, employeesemp_id),
    CONSTRAINT fk_empproj_projects_proj_code FOREIGN KEY (projectsproj_code) REFERENCES PROJECTS(proj_code),
    CONSTRAINT fk_empproj_employees_emp_id FOREIGN KEY (employeesemp_id) REFERENCES EMPLOYEES(emp_id)
);

CREATE TABLE EMPJOBS (
    -- Attributes
    employeesemp_id         NUMBER, 
    jobsjob_name            VARCHAR2(15), 
    job_start_date          DATE NOT NULL,
    job_end_date            DATE NOT NULL,
    -- Constraints
    CONSTRAINT pk_empjobs_employeesemp_id PRIMARY KEY (employeesemp_id, jobsjob_name),
    CONSTRAINT fk_empjobs_employees_emp_id FOREIGN KEY (employeesemp_id) REFERENCES EMPLOYEES(emp_id),
    CONSTRAINT fk_empjobs_jobs_job_name FOREIGN KEY (jobsjob_name) REFERENCES JOBS(job_name)
);

CREATE TABLE CNTJOBS (
    -- Attributes
    jobsjob_name            VARCHAR(15),
    contractscnt_number     NUMBER, 
    jobs_mgmt_start_date    DATE NOT NULL,
    jobs_mgmt_end_date      DATE NOT NULL,
    -- Constraints
    CONSTRAINT pk_cntjobs_jobsjob_name PRIMARY KEY (jobsjob_name, contractscnt_number),
    CONSTRAINT fk_cntjobs_jobs_job_name FOREIGN KEY (jobsjob_name) REFERENCES JOBS(job_name),
    CONSTRAINT fk_cntjobs_contracts_cnt_number FOREIGN KEY (contractscnt_number) REFERENCES CONTRACTS(cnt_number)
);



--!! Insert
--!! Values
--!! Into
--!! Tables

-- Categories Table

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (1, 'Main Highway');

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (2, 'Secondary Road');

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (3, 'Unsealed Road');

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (4, 'Urban Road');

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (5, 'Rural Road');

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (6, 'Gravel Road');

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (7, 'Historic Road');

INSERT INTO CATEGORIES 
(cat_id, cat_name)
VALUES (8, 'Scenic Route');

--assd
-- Locations Table

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (1, 'Auckland CBD - Corner One', -36.843402, 174.767215, -36.863225, 174.758627, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (2, 'Auckland CBD - Corner Two', -36.843402, 174.767215, -36.863225, 174.758627, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (3, 'Auckland CBD - Corner Three', -36.843402, 174.767215, -36.863225, 174.758627, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (4, 'Grafton', -36.864036, 174.766138, -36.870205, 174.772018, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (5, 'Newmarket', -36.870205, 174.772018, -36.871848, 174.774187, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (6, 'Epsom', -36.870258, 174.772026, -36.887501, 174.794085, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (7, 'Greenlane', -36.887501, 174.794085, -36.895062, 174.806324, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (8, 'Howick', -36.891794, 174.928622, -36.895278, 174.933372, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (9, 'Mount Eden', -36.866562, 174.754194, -36.900084, 174.743208, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (10, 'Mount Roskill', -36.900084, 174.743208, -36.920415, 174.736380, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (11, 'Manukau', -36.996774, 174.852826, -36.987273, 174.880272, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (12, 'New Lynn', -36.914137, 174.685694, -36.913943, 174.685803, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (13, 'Ponsonby', -36.847351, 174.744175, -36.859709, 174.752651, null);

INSERT INTO LOCATIONS 
(loc_id, loc_name, loc_start_lat, loc_start_long, loc_end_lat, loc_end_long, loc_description)
VALUES (14, 'Remuera', -36.869861, 174.777596, -36.877072, 174.824984, null);

-- Projects Table

INSERT INTO PROJECTS
(proj_code, proj_name, proj_description, proj_start_date, proj_end_date)
VALUES (112829, 'Safe Street Upgrade', null, '26-08-2023', '15-09-2023');

INSERT INTO PROJECTS
(proj_code, proj_name, proj_description, proj_start_date, proj_end_date)
VALUES (221758, 'Community Enhancement 2023', null, '01-04-2023', '07-08-2023');

INSERT INTO PROJECTS
(proj_code, proj_name, proj_description, proj_start_date, proj_end_date)
VALUES (238546, 'Smooth Concrete Project', null, '16-05-2023', '15-10-2023');

INSERT INTO PROJECTS
(proj_code, proj_name, proj_description, proj_start_date, proj_end_date)
VALUES (84823, 'General Revitalization 2024', null, '31-12-2023', '09-11-2024');

INSERT INTO PROJECTS
(proj_code, proj_name, proj_description, proj_start_date, proj_end_date)
VALUES (696969, 'Chinese Moon Festival 2023', null, '26-09-2023', '03-10-2023');

INSERT INTO PROJECTS
(proj_code, proj_name, proj_description, proj_start_date, proj_end_date)
VALUES (10294, 'Plant Trees Event', null, '01-09-2023', '30-09-2023');

INSERT INTO PROJECTS
(proj_code, proj_name, proj_description, proj_start_date, proj_end_date)
VALUES (12309, 'Sewers Maintenance', null, '13-07-2023', '27-07-2023');

-- Employees Table

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (1, 'Calvin', 'Alvarez', '15-07-2021', '27-05-2000', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0276439760, 'CALVAREZ');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (2, 'Chloe', 'Kua', '23-02-2022', '11-02-2003', 'F', '29 Clay Works Ln',
'Auckland', 0600, 'New Zealand', 0274278688, 'CKUA');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (3, 'Kris', 'Cyun', '15-07-2021', '27-05-2000', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0256752313, 'KCYUN');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (4, 'Emma', 'Zhao', '15-07-2021', '07-04-1996', 'F', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0234589730, 'EZHAO');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (5, 'Michelle', 'Gass', '15-07-2021', '22-03-2000', 'F', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0278904578, 'MGASS');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (6, 'Vitor', 'Costa', '15-07-2021', '02-09-1998', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0223145689, 'VCOSTA');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (7, 'Lucy', 'Kim', '15-07-2021', '10-03-2001', 'F', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0213459807, 'LKIM');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (8, 'Keanu', 'Rodges', '15-07-2021', '27-02-1999', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0213245678, 'KRODGES');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (9, 'Bwarerei', 'Kaieti', '15-07-2021', '23-05-1998', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0209863456, 'BKAIETI');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (10, 'Matthew', 'Stockdale', '15-07-2021', '25-12-1989', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0209862356, 'MSTOCKDALE');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (11, 'Callum', 'Clow', '15-07-2021', '31-07-1987', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0235797538, 'CCLOW');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (12, 'Leonardo', 'DiCaprio', '15-07-2021', '01-06-1980', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0270952685, 'LDICAPRIO');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (13, 'Mark', 'Zuckerberg', '15-07-2021', '27-03-1985', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0226073793, 'MZUCKERBERG');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (14, 'Dylan', 'Aranha', '15-07-2021', '12-08-1996', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0207524323, 'DARANHA');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (15, 'Liv', 'Hawkins', '15-07-2021', '11-11-1987', 'F', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0214354321, 'LHAWKINS');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (16, 'Tay', 'Oh', '15-07-2021', '08-09-1999', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0207642869, 'TOH');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (17, 'Alex', 'Bialek', '15-07-2021', '10-10-1986', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0278906543, 'ABIALEK');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (18, 'Issabella', 'Stemson', '15-07-2021', '08-02-2002', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0276849864, 'ABIALEK');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (19, 'Shelby', 'Kua', '15-07-2021', '13-06-1999', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0278904321, 'ABIALEK');

INSERT INTO EMPLOYEES
(emp_id, emp_first_name, emp_last_name, emp_hire_date, emp_dob, emp_gender,
emp_street, emp_city, emp_zip, emp_country, emp_phone, emp_email)
VALUES (20, 'Jose', 'Laserna', '15-07-2021', '20-11-2001', 'M', '5 Burnley Terrace',
'Auckland', 1024, 'New Zealand', 0279086543, 'ABIALEK');

-- Jobs Table

INSERT INTO JOBS
(job_name, job_description)
VALUES ('Road Construction Manager', 'Oversees all aspects of road construction projects.');

INSERT INTO JOBS 
(job_name, job_description)
VALUES ('Civil Engineer', null);

INSERT INTO JOBS 
(job_name, job_description)
VALUES ('Heavy Equipment Operator', null);

INSERT INTO JOBS 
(job_name, job_description)
VALUES ('Surveyor', 'Measures and maps out road construction sites.');

INSERT INTO JOBS 
(job_name, job_description)
VALUES ('Traffic Control Officer', null);

INSERT INTO JOBS
(job_name, job_description)
VALUES ('Safety Inspector', 'Monitors safety practices at the construction site.');

INSERT INTO JOBS
(job_name, job_description)
VALUES ('Finance Manager', 'Handles project budgeting and financial management.');

INSERT INTO JOBS
(job_name, job_description)
VALUES ('IT Support Technician', null);

-- Contractors Table

INSERT INTO CONTRACTORS 
(cont_name, cont_contact, cont_street, cont_city, cont_zip, cont_country)
VALUES 
('CPB Contractors', 640276437584, '19 Hargreaves St', 'Auckland', 1011, 'New Zealand');

INSERT INTO CONTRACTORS 
(cont_name, cont_contact, cont_street, cont_city, cont_zip, cont_country)
VALUES 
('HEB Construction', 640271927584, '105 Wiri Station Rd', 'Auckland', 2104, 'New Zealand');

INSERT INTO CONTRACTORS 
(cont_name, cont_contact, cont_street, cont_city, cont_zip, cont_country)
VALUES 
('Fulton Hogan', 6402764739541, '10 Reliable Way', 'Auckland', 1060, 'New Zealand');

INSERT INTO CONTRACTORS (cont_name, cont_contact, cont_street, cont_city, cont_zip, cont_country)
VALUES 
('Downer', 61312345678, '50 Rose St', 'Sydney', 2000, 'Australia');

INSERT INTO CONTRACTORS 
(cont_name, cont_contact, cont_street, cont_city, cont_zip, cont_country)
VALUES 
('Fletcher Construction', 61362453784, '15 Lathams Rd', 'Melbourne', 3202, 'Australia');

-- Roads Table

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES
('CA0010', 'Queen Street', null, null);

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES
('CA0011', 'Lower Queen Street', null, 'CA0010');

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES
('CA0012', 'Upper Queen Street', null, 'CA0010');  

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0013', 'SH1', null, null);

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0014', 'SH1 Grafton Stretch', null, 'CA0013');

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0015', 'SH1 Newmarket Stretch', null, 'CA0013');

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0016', 'SH1 Epsom Stretch', null, 'CA0013');

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0017', 'SH1 Greenlane Stretch', null, 'CA0013');

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0018', 'Picton Street', null, null);

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0019', 'Dominion Road', null, null);

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0020', 'Dominion Road Mt Eden Stretch', null, 'CA0019');

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0021', 'Dominion Road Mt Roskill Stretch', null, 'CA0019');

INSERT INTO ROADS
(rd_id, rd_name, rd_description, roadsrd_id)
VALUES 
('CA0022', 'Cavendish Drive', null, null);

-- Contracts Table

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(1, 'SSU Contract A', 'Roadworks that will upgrade how safe the road is',
300000.00, 250000.00, '26-08-2023', '05-09-2023', 112829, 'Fulton Hogan');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(2, 'SSU Contract B', 'Revision of how safe the road has become',
120000.00, 130000.00, '06-09-2023', '15-09-2023', 112829, 'Fulton Hogan');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(3, 'CE 2023 Contract', 'Development and construction of decorations',
50000.00, 70000.00, '01-04-2023', '07-08-2023', 221758, 'CPB Contractors');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(4, 'SCP Contract X', 'Change the concrete of the road',
100000.00, 95000.00, '16-05-2023', '15-08-2023', 238546, 'Downer');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(5, 'SCP Contract Y', 'Revision of the progress',
30000.00, 32000.00, '16-08-2023', '20-09-2023', 238546, 'Downer');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(6, 'SCP Contract Z', 'Final details to be done',
10000.00, 9000.00, '21-09-2023', '15-10-2023', 238546, 'Downer');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(7, 'GR2024 Contract', 'Major change in the whole road',
200000.00, null, '31-12-2023', '09-11-2024', 84823, 'HEB Construction');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(8, 'CMF 2023 Contract', 'Preparations for the chinese moon festival',
50000.00, 52000.00, '26-09-2023', '03-19-2023', 696969, 'Downer');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(9, 'PTE Contract', 'Plant trees along the sidewalk',
70000.00, 65000.00, '01-09-2023', '30-09-2023', 10294, 'Downer');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(10, 'SM Contract A', 'Sewers maintenance to be done',
65000.00, 68000.00, '13-07-2023', '20-07-2023', 12309, 'Fletcher Construction');

INSERT INTO CONTRACTS
(cnt_number, cnt_name, cnt_description, cnt_est_cost, cnt_actual_cost,
cnt_start_date, cnt_end_date, projectsproj_code, contractorscont_name)
VALUES
(11, 'SM Contract B', 'Check of impacts on roads',
27000.00, 22000.00, '16-08-2023', '20-09-2023', 12309, 'Fulton Hogan');

-- Roadcat Table

INSERT INTO ROADCAT
(roadsrd_id, categoriescat_id, rd_status)
VALUES
();

-- Roadloc Table

INSERT INTO ROADLOC
(roadsrd_id, locationsloc_id, rd_est_length)
VALUES
();

-- Projroad Table

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0010', 84823, 'Inactive');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0011', 84823, 'Inactive');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0013', 238546, 'Active');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0015', 238546, 'Active');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0018', 112829, 'Finished');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0018', 10294, 'Finished');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0022', 12309, 'Finished');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0022', 221758, 'Finished');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0019', 696969, 'Active');

INSERT INTO PROJROAD
(roadsrd_id, projectsproj_code, proj_status)
VALUES
('CA0020', 696969, 'Active');

-- Empproj Table

INSERT INTO EMPPROJ
(projectsproj_code, employeesemp_id, emp_status)
VALUES
();

-- Empjobs Table

INSERT INTO EMPJOBS
(employeesemp_id, jobsjob_name, job_start_date, job_end_date)
VALUES
();

-- Cntjobs Table

INSERT INTO CNTJOBS
(jobsjob_name, contractscnt_number, cnt_start_date, cnt_end_date)
VALUES
();
