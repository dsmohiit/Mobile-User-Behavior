-- What is the average App Usage Time across all users?
SELECT ROUND(AVG(app_usage_time), 2) AS "avg_app_usage_time"
FROM mobile_user_behaviour;

-- How many unique Device_Models are there in the dataset?
SELECT DISTINCT device_model AS "unique_devices"
FROM mobile_user_behaviour;

-- What is the distribution of users by Gender?
SELECT gender, (100 * COUNT(*) /(SELECT COUNT(*) FROM mobile_user_behaviour)) AS "percentage"
FROM mobile_user_behaviour
GROUP BY gender;

-- Which Operating System has the highest average Screen On Time?
SELECT operating_system, AVG(screen_on_time) AS "avg_screen_on_time"
FROM mobile_user_behaviour
GROUP BY operating_system
ORDER BY avg_screen_on_time DESC LIMIT 1;

-- What is the correlation between app_usage_time and battery_drain?
SELECT CORR(app_usage_time, battery_drain)
FROM mobile_user_behaviour;

-- Top 5 users with highest data use.
SELECT userid, data_usage
FROM mobile_user_behaviour
ORDER BY data_usage DESC LIMIT 5;

-- Average numbers of appa installed for each age group.
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

-- Which device model has the lowest avg battery drain.
SELECT device_model, ROUND(AVG(battery_drain), 2) AS avg_battery_drain
FROM mobile_user_behaviour
GROUP BY device_model
ORDER BY avg_battery_drain;

-- Diffrence in app usage time between gender across diffrent age group.
SELECT gender, age_group, ROUND(AVG(app_usage_time), 2) AS avg_app_usgae_time
FROM mobile_user_behaviour t1
JOIN age_group t2
ON t1.userid = t2.userid
GROUP BY gender, age_group
ORDER BY gender, age_group;

-- For each operating system, what is the device model with the highest average 
-- Screen on time. How does it compare to the overall average for that OS?
SELECT operating_system, device_model, AVG(screen_on_time) AS avg_screen_on_time,
ROW_NUMBER() OVER(PARTITION BY operating_system ORDER BY AVG(screen_on_time)) AS rnk
FROM mobile_user_behaviour
GROUP BY operating_system, device_model
ORDER BY operating_system, rnk;











