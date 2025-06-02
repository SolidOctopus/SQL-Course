SELECT*
FROM(
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;

SELECT 
    company_id,
    name AS company_name
FROM 
    Company_dim
Where 
    company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
)

WITH company_job_count AS ( 
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT
     company_dim.name as company_name,
     total_jobs
from company_dim
LEFT JOIN company_job_count on company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs desc;




SELECT
    job_postings_fact.job_id
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id

LIMIT 100


SELECT
    skills_dim.skills,
    Count(*) AS skill_count
FROM
    skills_job_dim
INNER JOIN
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills_dim.skills
ORDER BY
    skill_count DESC







Select *
from job_postings_fact