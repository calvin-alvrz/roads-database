--! Query 1:

/* Purpose of the query is to look for roads that are currently undergoing projects that
are going to end within the first week of October of 2023 and retrieve the following details
(rd_id, rd_name, proj_code, proj_name, proj_end_date, proj_status)*/

SELECT 
    r.rd_id AS "Road ID",
    r.rd_name AS "Road Name",
    p.proj_code AS "Project Code",
    p.proj_name AS "Project Name",
    p.proj_end_date AS "Project End Date",
    pr.proj_status AS "Status"
FROM roads r, projects p, projroad pr
WHERE pr.projectsproj_code = p.proj_code
AND r.rd_id = pr.roadsrd_id
AND proj_status = 'Active'
AND proj_end_date < '08-10-23';

--! Query 2:

/* Purpose of the query is to look for employees that are currently on sick leave 
and retrieves the following details (emp_first_name, emp_last_name, emp_phone, emp_email,
emp_status)*/

SELECT
    e.emp_first_name || ' ' || e.emp_last_name AS "Full Name",
    e.emp_phone AS "Phone Number",
    LOWER(e.emp_email) || '@atmobile.com' AS "Email",
    ep.emp_status AS "Status"
FROM employees e, empproj ep
WHERE e.emp_id = ep.employeesemp_id
AND ep.emp_status = 'Sick Leave';

--! Query 3:

/* Purpose of the query is to generate a record of the number of months an employee
holds a managerial position within a contract. It retrieves the following details
(emp_first_name, emp_last_name, job_name, cnt_number, cnt_name, cnt_start_date,
cnt_end_date, and days in the position) */

SELECT
    e.emp_first_name || ' ' || e.emp_last_name AS "Full Name",
    j.job_name AS "Job Title",
    c.cnt_number AS "Contract Number",
    c.cnt_name AS "Contract Name",
    c.cnt_start_date AS "Contract Start Date",
    c.cnt_end_date AS "Contract End Date",
    ROUND(MONTHS_BETWEEN(c.cnt_end_date,
    c.cnt_start_date), 0) AS "# Months in Position"
FROM employees e, contracts c, jobs j, empjobs ej, cntjobs cj
WHERE e.emp_id = ej.employeesemp_id
AND j.job_name = ej.jobsjob_name
AND j.job_name = cj.jobsjob_name
AND c.cnt_number = cj.contractscnt_number
AND UPPER(j.job_name) LIKE '%MANAGER';

--! Query 4:

/*Purpose of the query is to create a report with the subsections of roads that
are longer than 2 kilometres and order them in ascending order by the road's name. */
SELECT DISTINCT 
    r.rd_id AS "Road ID", 
    r.roadsrd_id AS "Subsection ID", 
    r.rd_name AS "Road Name", 
    rl.rd_est_length AS "Road Estimated Length (km)"
FROM roads r, roadloc rl
WHERE r.rd_id = rl.roadsrd_id
AND rl.rd_est_length >2
ORDER BY r.rd_name, rl.rd_est_length;


--! Query 5:

/*Purpose of the query is to return a report that summarizes the total cost of a project
regarding the actual and estimated costs on the contracts table. */