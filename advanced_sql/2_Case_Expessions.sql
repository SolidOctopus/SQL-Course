SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' Then 'Remote'
        WHEN job_location = 'New York' Then 'Local'
        Else 'Onsite' 
    END AS location_category
FROM
     job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;


---Practice Problem---
SELECT
    COUNT (job_id) AS number_of_jobs,
    CASE
    When salary_year_avg<= 48000 then 'Low'
    When salary_year_avg<= 100000 then 'Standard'
    When salary_year_avg > 100000 then 'High'
    Else 'Other'
    END AS Salary_Type
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    Salary_Type
ORDER BY
    number_of_jobs DESC