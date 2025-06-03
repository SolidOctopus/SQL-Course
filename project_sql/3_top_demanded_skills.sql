/*
Question: What are the most in-demand skills for data analysts?
    - Join job pstings to inner join table similar to query 2
    - Identify the top 5 in-demand skills for data analysts.
    - Focus on all job postings.
    - Why? This query retrieves the top 5 skills with the highest demand in the job market,
        prviding insights into the most valuable skills for job seekers. 
*/



SELECT 
    skills,
    COUNT(skills_job_dim.job_id) as Demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    Demand_count DESC
LIMIT 5 


