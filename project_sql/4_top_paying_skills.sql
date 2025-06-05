/*
Question: What are the top skills based on salary?
    - Look at the average salary associated with each skill for Data Analyst positions
    - Focuses on roles with specified slaried, regardless of location
    - Why? it reveals how different skills impact salary levels for Data Analysts and 
        helps idetify the most finacially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) as Demand_count,
    ROUND (AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25



