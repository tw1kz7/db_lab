CREATE TABLE categories (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(50) NOT NULL UNIQUE
);

ALTER TABLE projects
ADD COLUMN category_id INT REFERENCES categories(category_id) ON DELETE SET NULL;

ALTER TABLE projects
DROP COLUMN project_category;