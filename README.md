# Mobile-User-Behavior

## Project Overview

**Project Title**: Mobile User Behaviour  
**Level**: Intermediate  

The queries analyze mobile user behavior, examining factors such as app usage time, device models, gender distribution, operating systems, battery drain, and age groups. They provide insights into average usage patterns, correlations between variables, and performance metrics across different user segments and device characteristics.

![Library_project](https://github.com/dsmohiit/Library_Management_Project_SQL/blob/main/WHAT-IS-THE-PURPOSE-OF-A-LIBRARY-MANAGEMENT-SYSTEM-min.png)

## Project Structure

- **Database Creation**: Created a database named `mobile_user_behaviour`.
- **Table Creation**: Created tables named `mobile_user_behaviour`. The table includes relevant columns and relationships.

```sql
-- Creating Table	
CREATE TABLE mobile_user_behaviour(
	UserId INT PRIMARY KEY,
	Device_Model VARCHAR(70),
	Operating_System VARCHAR(50),
	App_Usage_Time INT,
	Screen_On_Time FLOAT4,
	Battery_Drain INT,
	Number_of_Apps_Installed INT,
	Data_Usage INT,
	Age INT,
	Gender VARCHAR(10)
);

SELECT *
FROM mobile_user_behaviour;
```

- **Analytical Queries**
**Task 1 - What is the average App Usage Time across all users?**
```sql
SELECT ROUND(AVG(app_usage_time), 2) AS "avg_app_usage_time"
FROM mobile_user_behaviour;
```
**Task 2 - How many unique Device_Models are there in the dataset?**
```sql
SELECT DISTINCT device_model AS "unique_devices"
FROM mobile_user_behaviour;
```
**Task 3 - What is the distribution of users by Gender?**
```sql
SELECT gender, (100 * COUNT(*) /(SELECT COUNT(*) FROM mobile_user_behaviour)) AS "percentage"
FROM mobile_user_behaviour
GROUP BY gender;
```
**Task 4 - Which Operating System has the highest average Screen On Time?**
```sql
SELECT operating_system, AVG(screen_on_time) AS "avg_screen_on_time"
FROM mobile_user_behaviour
GROUP BY operating_system
ORDER BY avg_screen_on_time DESC LIMIT 1;
```
**Task 5 - What is the correlation between app_usage_time and battery_drain?**
```sql
SELECT CORR(app_usage_time, battery_drain)
FROM mobile_user_behaviour;
```
**Task 6 - Top 5 users with highest data use.**
```sql
SELECT userid, data_usage
FROM mobile_user_behaviour
ORDER BY data_usage DESC LIMIT 5;
```
**Task 7 - Average numbers of appa installed for each age group.**
```sql
CREATE TABLE age_group AS (SELECT userid, number_of_apps_installed,
CASE 
	WHEN age BETWEEN 18 AND 29 THEN 'group1'
	WHEN age BETWEEN 30 AND 39 THEN 'group2'
	WHEN age BETWEEN 40 AND 49 THEN 'group3'
	WHEN age BETWEEN 50 AND 59 THEN 'group4'
	ELSE 'other'
END AS age_group
FROM mobile_user_behaviour);

SELECT ROUND(AVG(number_of_apps_installed), 2) AS avg_apps_installed, age_group
FROM age_group
GROUP BY age_group
ORDER BY avg_apps_installed DESC;
```
**Task 8 - Which device model has the lowest avg battery drain.**
```sql
SELECT device_model, ROUND(AVG(battery_drain), 2) AS avg_battery_drain
FROM mobile_user_behaviour
GROUP BY device_model
ORDER BY avg_battery_drain;
```
**Task 9 - Diffrence in app usage time between gender across diffrent age group.**
```sql
SELECT gender, age_group, ROUND(AVG(app_usage_time), 2) AS avg_app_usgae_time
FROM mobile_user_behaviour t1
JOIN age_group t2
ON t1.userid = t2.userid
GROUP BY gender, age_group
ORDER BY gender, age_group;
```
**Task 10 - For each operating system, what is the device model with the highest average Screen on time. How does it compare to the overall average for that OS?**
```sql
SELECT operating_system, device_model, AVG(screen_on_time) AS avg_screen_on_time,
ROW_NUMBER() OVER(PARTITION BY operating_system ORDER BY AVG(screen_on_time)) AS rnk
FROM mobile_user_behaviour
GROUP BY operating_system, device_model
ORDER BY operating_system, rnk;
```

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
   git clone https://github.com/dsmohiit/Mobile-User-Behavior.git
   ```
2. **Set Up the Database**: Execute the SQL scripts in the `Table Query` and insert the `Mobile User Behaviour- Transformed` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `Analytical Queries` file to perform the analysis.
4. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.

## Author - Mohit Soni

This project showcases SQL skills essential for database management and analysis. 


