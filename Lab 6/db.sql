DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS developer_links;
DROP TABLE IF EXISTS developers;
DROP TABLE IF EXISTS employers;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	user_name VARCHAR(30) NOT NULL,
	user_surname VARCHAR(50) NOT NULL,
	user_country VARCHAR(100) NOT NULL,
	user_email VARCHAR(100) NOT NULL UNIQUE,
	user_phone VARCHAR(18) NOT NULL
);

CREATE TABLE developers (
	dev_id INT PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
	is_searching_job BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE developer_links (
    link_id SERIAL PRIMARY KEY,
    dev_id INT NOT NULL REFERENCES developers(dev_id) ON DELETE CASCADE,
    link_url VARCHAR(255) NOT NULL
);

CREATE TABLE companies (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE employers (
	employer_id INT PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
	company_id INT REFERENCES companies(company_id) ON DELETE SET NULL,
	employer_position VARCHAR(100) NOT NULL
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE projects (
	project_id SERIAL PRIMARY KEY,
	dev_id INT NOT NULL REFERENCES developers(dev_id) ON DELETE CASCADE,
	category_id INT REFERENCES categories(category_id) ON DELETE SET NULL,
	project_name VARCHAR(150) NOT NULL,
	project_description TEXT NOT NULL,
	project_url VARCHAR(255) NOT NULL,
	project_active BOOLEAN NOT NULL DEFAULT TRUE
);