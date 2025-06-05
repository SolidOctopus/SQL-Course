# Introduction
This is a small project diving into the data job market of 2023, focusing on Data Analyst roles, this project explores top paying jobs, high demand skills and where high demand meets high salary in the Data Analysis roles.

SQL queries: [project_sql folder](/project_sql/)
# Background
This project is an example on how to pinpoint top-paid and in-demand skills when exploring the job market, allowing the user to see which skill they should prioritize to learn/improve on

The data used in this project hails from [Luke Barousse's SQL course](https://github.com/lukebarousse/Int_SQL_Data_Analytics_Course)
## The questions i wanted to answer with these queries were:
1.What are the top-paying data anayst jobs?

2.What skills are required for these top-paying jobs?

3.What skills are most in demand for data analysts?

4.Which skills are associated with higher salaries?

5.What are the most optimal skills to learn?

# Tools I Used
-   **SQL**: The backbone of my analysis, allowing me to query the database
-   **PosgreSQL**: the chosen database management system, ideal for handling the job psoting data.
-   **Visual Studio Code**: My go-to for database management and executing SQL queries
-   **Git & GitgHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboation and project tracking. 
# The Analysis
### 1. Top Paying Data Analyst Jobs
    To identfy the highest-paying roles, i filtered data anayst postions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field
```sql
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
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
![Top Paying Roles](/assets/1_top_paying_jobs.png)

###  Bar graph visualizing the salary for the top 10 salaries for data analysts

### Insight:
- Salary Range: The top-paying remote Data Analyst roles offer $184,000 to $650,000, with the highest salary at Mantys.

-  Job Titles: Titles like "Director of Analytics" (Meta) and "Principal Data Analyst" (SmartAsset) show that seniority correlates with higher pay.

- Hybrid Dominance: 9/10 roles are full-time remote, highlighting flexibility as a standard for top-tier positions.

### 2. Skills for Top Paying Jobs
    To understand what skills are required for the highest-paying roles, I joined the top 10 paying jobs (from Query 1) with skills data. This reveals which technical competencies are most valued by employers offering premium salaries.

```sql
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
```
![Count of Skills](/assets/2_count_of_skills.png)

### Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts

### Insight:
- "SQL + Python + Tableau" is the baseline for top-tier Data Analyst roles.

- Cloud and big data skills differentiate salaries beyond $200K.

- Git proficiency is an underrated add-on for high-paying positions.

### 3. In-Demand Skills for Data Analysts

    To identify the skills employers prioritize most, I analyzed all Data Analyst job postings and counted how frequently each skill appeared. This reveals the baseline competencies needed to remain competitive in the job market.

```sql
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
```
![Skill Demand](/assets/3_Skill_Demand.png)

### Pie chart showing the % distribution of the top 5 skills

### Insights:

- SQL Dominance:

    - Appears in 1 out of 3 Data Analyst jobs (92K postings), making it non-negotiable.

    - Even higher than Excel, challenging the stereotype of spreadsheets as the primary tool.

- Visualization Wars:

    - Tableau leads Power BI by 18% (46K vs. 39K), but both are essential.

    - Combined, visualization tools appear in 30% of postings.

- Python’s Stronghold:

    - Required in 20% of roles, signaling its importance beyond just data engineering.

- Comparison with Top-Paying Skills (from Query 2):

    - Overlap: SQL, Python, and Tableau appear in both top-paying and most-demanded lists.

    - Divergence: Excel is highly demanded (#2) but rarely mentioned in top salaries, suggesting it’s baseline but not premium.

### 4. Skills Based on Salary
    To uncover which skills command premium salaries, I analyzed remote Data Analyst roles with disclosed pay, calculating the average salary for each skill. This reveals niche competencies that significantly boost earning potential.

```sql
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
LIMIT 25;
```
![Top-Paying Skills](/assets/4_Top_Paying_Skills.png)

### Combo graph visualizing the top paying skills average salaries vs their demand

### Insights:

- Big Data = Big Money:

    - PySpark tops the list at $208K, despite appearing in only 2 jobs.

    - Databricks (10 jobs) pays $141K, confirming demand for distributed computing skills.

- DevOps Surprises:

    - Bitbucket ($189K) and GitLab ($154K) outearn Python/Pandas, suggesting CI/CD knowledge is highly valued.

    - Kubernetes ($132K) appears despite being rare in traditional DA roles.

- Low-Demand, High-Reward:

    - Many top-paying skills (e.g., Couchbase, Watson) appear in ≤3 jobs, indicating niche specialization opportunities.

### 4. Most Optimal Skills to Learn

    To find skills that offer both job security and financial rewards, I analyzed remote Data Analyst roles, filtering for skills with >10 job postings and above-average salaries. This targets competencies that balance opportunity and earning potential.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) as demand_count,
    ROUND (AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
    
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25
```
![Top-Paying Skills](/assets/5_Most_optimal_skills.png)

### Table of the most optimal skills for data analyst sorted by salary

### Insights:

- The "Sweet Spot" Skills:

    - Snowflake & Azure: Cloud platforms offer 11-12% salary premiums with solid demand (30+ jobs), making them safe bets.

    - Go (Golang): Despite being uncommon in DA roles, it commands the highest salary ($115K) among high-demand skills.

-  Python’s Paradox

    - While Python has massive demand (#1 at 236 jobs), its salary premium is modest (+2%), suggesting it’s now a baseline expectation.

- Visualization Tools:

    - Tableau (230 jobs, $99K) and Looker (49 jobs, $103K) are ubiquitous but offer limited salary upside.

- Emerging Opportunities:

    - Big Data Tools: Hadoop ($113K) and Spark (implied by demand) bridge traditional DA and data engineering roles.

# What I Learned

During this journey, I have significantly enhanced my SQL expertise by acquiring advanced technical skills:

- Advanced Query Development: Developed proficiency in constructing complex SQL queries, including seamless table joins and the strategic use of WITH clauses for efficient temporary table operations.

- Data Aggregation Techniques: Gained expertise in employing GROUP BY and aggregate functions such as COUNT() and AVG() to effectively summarize and analyze datasets.

- Analytical Problem-Solving: Strengthened my ability to translate real-world business questions into precise, actionable SQL queries, delivering data-driven insights.

# Conclusions

## The Data Analyst Skills Hierarchy
    Based on demand, salary, and strategic value, skills fall into three tiers:

| Tier	     | Skills | Why It Matters     |
|----------|-----|------------|
| Core	   | SQL, Python, Excel	  | Non-negotiable for 90%+ of jobs. Python now rivals SQL as a baseline.  |
|Premium   | Snowflake, Azure, Go, PySpark	  | Cloud + big data skills offer 10-20% salary bumps with growing demand.   |
| Niche  | Hadoop, DataRobot, Bitbucket	  | Rare but lucrative (e.g., Go pays $115K). Ideal for specialization.    |

## Salary-Drivers vs. Commoditized Skills

- Highest Paying: PySpark ($208K), Bitbucket ($189K), Couchbase ($160K).

- Most Demanded: SQL (92K jobs), Excel (67K jobs), Python (57K jobs).

- Overlap Winners: Snowflake (37 jobs, $113K) and Azure (34 jobs, $111K) balance both.

**Main Takeaway**: Learning cloud platforms (Snowflake/Azure) is the safest way to boost earnings without sacrificing job opportunities.

## The Remote Work Advantage
- Top salaries are remote: 90% of high-paying roles ($184K+) offer full remote/hybrid flexibility.

- In-demand remote skills: Python, Tableau, and cloud tools dominate remote job postings.

## Strategic Learning Path
For max career ROI, prioritize:

- Immediate Hireability: SQL → Python → Tableau.

- Salary Growth: Add Snowflake or Azure certifications.

- Future-Proofing: Experiment with PySpark or DataRobot for niche roles.

# Closing Thoughts

This analysis reveals a shift in Data Analyst expectations:

- Beyond spreadsheets: While Excel remains popular, tools like Python and cloud platforms are now core.

- Specialization pays: Generalists earn $70K–$100K, but big data/cloud specialists command $110K–$208K.

- Remote is here to stay: Flexibility correlates with higher pay, especially for skills like Go and Databricks.