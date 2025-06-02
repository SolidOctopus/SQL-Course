SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS average_yearly_salary,
    AVG(salary_hour_avg) AS average_hourly_salary
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'  
GROUP BY
    job_schedule_type;

SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'UTC-4') AS month,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month DESC;

SELECT
    companies.name as company,
    job_health_insurance AS Health_insurance,
    job_posted_date AS date
FROM
    job_postings_fact As job_postings
LEFT JOIN company_dim AS companies
    ON job_postings.company_id = companies.company_id
WHERE
    job_health_insurance = TRUE AND
    (job_posted_date BETWEEN '04-01-2023'::DATE AND '06-30-2023'::DATE)
ORDER BY
    job_posted_date