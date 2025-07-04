/*
Question: What skills are required for the top_paying data analyst jobs?
    -Use the top 10 highest-paying Data Analyst jobs from first query
    -Add the specific skills required for these roles
    -Why? It provides a dtailed look at wich high-paying jobs demand certain skills,
        helping job seekers understand which skills to devlop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        company_dim.name AS company_name,
        job_postings_fact.salary_year_avg
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
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
top_paying_jobs.salary_year_avg DESC;

/*
Breakdown of most demanded skills for Data Analysts in 2023
SQL is leading with a bold count of 8
Python follows closesly with a bold count of 7
Tableau is also highly sought after, with a bold count of 6
Other skills like R, Snowflake, Pnadas, and Excel show varying degrees of demand.
*/
;

sdf