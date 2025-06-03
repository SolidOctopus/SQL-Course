/*
-Identify the top 10 highest-paying Data Analyst roles available remotely
- Focus on job postings with specified salaries (remove nulls)
- Why? Highlight the top-paying opprotinites for Data analysts, offering insights into the most optimal skill to pursue as a Data Analyst
*/

SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    company_dim.name AS company_name,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date

FROM
job_postings_fact

LEFT JOIN company_dim ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC

LIMIT 10;

dfd