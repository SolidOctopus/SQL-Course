SELECT *
FROM january_jobs;

SELECT *
FROM february_jobs_jobs;

SELECT *
FROM march_jobs_jobs;

-- Get jobs and companies from january
SELECT
    job_title_short,
    job_id,
    job_location
FROM
    january_jobs

UNION ALL

-- Get jobs and companies from February
SELECT
    job_title_short,
    job_id,
    job_location
FROM
    february_jobs

UNION ALL

-- Get jobs and companies from March
SELECT
    job_title_short,
    job_id,
    job_location
FROM
    march_jobs



-----Practice problem (I dont think this is possible to do with Unions 2:54:40)

SELECT 
    job_postings_fact.job_id,
    skills_job_dim.skill_id,
    skills_dim.skills,
    skills_dim.type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    on skills_job_dim.job_id = skills_dim.skill_id
WHERE
     salary_year_avg > 70000 AND
    (job_posted_date BETWEEN '01-01-2023'::DATE AND '04-01-2023'::DATE)
