SELECT user_country, COUNT(*) AS total_users
FROM users
GROUP BY user_country
ORDER BY total_users DESC;

SELECT dev_id, MIN(project_id) AS first_project_id, MAX(project_id) AS last_project_id
FROM projects
GROUP BY dev_id;

SELECT project_category,
       SUM(CASE WHEN project_active = TRUE THEN 1 ELSE 0 END) AS active_projects_sum,
       AVG(CASE WHEN project_active = TRUE THEN 1.0 ELSE 0.0 END) AS active_projects_avg
FROM projects
GROUP BY project_category;

SELECT project_category, COUNT(*) AS projects_count
FROM projects
GROUP BY project_category
HAVING COUNT(*) >= 2;

SELECT u.user_name, u.user_surname, p.project_name, p.project_category
FROM users u
INNER JOIN developers d ON u.user_id = d.dev_id
INNER JOIN projects p ON d.dev_id = p.dev_id;

SELECT u.user_name, u.user_surname, e.employer_company, e.employer_position
FROM users u
LEFT JOIN employers e ON u.user_id = e.employer_id;

SELECT u.user_name, u.user_surname, d.dev_links
FROM projects p
RIGHT JOIN developers d ON p.dev_id = d.dev_id
INNER JOIN users u ON d.dev_id = u.user_id
WHERE p.project_id IS NULL;

SELECT user_name, user_surname
FROM users
WHERE user_id IN (
    SELECT dev_id 
    FROM projects
);

SELECT user_name,
       (SELECT COUNT(*) FROM projects WHERE dev_id = users.user_id) AS total_projects
FROM users;

SELECT project_category, COUNT(*) AS total_count
FROM projects
GROUP BY project_category
HAVING COUNT(*) > (
    SELECT COUNT(*) 
    FROM employers
);