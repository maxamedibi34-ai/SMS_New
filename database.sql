CREATE DATABASE IF NOT EXISTS school_management_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE school_management_system;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS activity_logs; DROP TABLE IF EXISTS students; DROP TABLE IF EXISTS parents; DROP TABLE IF EXISTS classes; DROP TABLE IF EXISTS academic_years; DROP TABLE IF EXISTS users; DROP TABLE IF EXISTS school_settings;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE users (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(80) NOT NULL UNIQUE,
 password VARCHAR(255) NOT NULL,
 full_name VARCHAR(150) NOT NULL,
 email VARCHAR(190) NULL,
 phone VARCHAR(40) NULL,
 role ENUM('admin','teacher','parent','cashier','student','manager','technician') NOT NULL DEFAULT 'teacher',
 language ENUM('so','en') NOT NULL DEFAULT 'so',
 theme ENUM('light','dark') NOT NULL DEFAULT 'light',
 is_active TINYINT(1) NOT NULL DEFAULT 1,
 failed_attempts INT NOT NULL DEFAULT 0,
 locked_until DATETIME NULL,
 last_login DATETIME NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 INDEX idx_users_role_active(role,is_active)
) ENGINE=InnoDB;
CREATE TABLE academic_years (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, name VARCHAR(30) NOT NULL UNIQUE, start_date DATE NULL, end_date DATE NULL, is_current TINYINT(1) NOT NULL DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE classes (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50) NOT NULL, grade_level TINYINT UNSIGNED NOT NULL, academic_year_id INT UNSIGNED NULL, deleted_at DATETIME NULL, UNIQUE KEY uq_class_year(name,academic_year_id), CONSTRAINT fk_class_year FOREIGN KEY(academic_year_id) REFERENCES academic_years(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE parents (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, user_id BIGINT UNSIGNED NULL, full_name VARCHAR(150) NOT NULL, phone VARCHAR(40) NULL, email VARCHAR(190) NULL, address VARCHAR(255) NULL, emergency_contact VARCHAR(40) NULL, verified TINYINT(1) NOT NULL DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, deleted_at DATETIME NULL, CONSTRAINT fk_parent_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL, INDEX idx_parent_phone(phone)) ENGINE=InnoDB;
CREATE TABLE students (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, student_code VARCHAR(40) NOT NULL UNIQUE, full_name VARCHAR(150) NOT NULL, class_name VARCHAR(50) NOT NULL, class_id INT UNSIGNED NULL, gender ENUM('male','female','other') NULL, date_of_birth DATE NULL, parent_id BIGINT UNSIGNED NULL, parent_phone VARCHAR(40) NULL, status ENUM('active','inactive','transferred','graduated') NOT NULL DEFAULT 'active', admission_date DATE NULL, photo_path VARCHAR(255) NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, deleted_at DATETIME NULL, CONSTRAINT fk_student_class FOREIGN KEY(class_id) REFERENCES classes(id) ON DELETE SET NULL, CONSTRAINT fk_student_parent FOREIGN KEY(parent_id) REFERENCES parents(id) ON DELETE SET NULL, INDEX idx_students_name(full_name), INDEX idx_students_class(class_name), INDEX idx_students_status(status), INDEX idx_students_deleted(deleted_at)) ENGINE=InnoDB;
CREATE TABLE activity_logs (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, user_id BIGINT UNSIGNED NULL, action VARCHAR(60) NOT NULL, entity_type VARCHAR(60) NOT NULL, entity_id BIGINT NULL, details TEXT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, CONSTRAINT fk_log_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL, INDEX idx_logs_entity(entity_type,entity_id), INDEX idx_logs_date(created_at)) ENGINE=InnoDB;
CREATE TABLE school_settings (setting_key VARCHAR(100) PRIMARY KEY, setting_value TEXT NULL, updated_by BIGINT UNSIGNED NULL, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, CONSTRAINT fk_setting_user FOREIGN KEY(updated_by) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
INSERT INTO school_settings(setting_key,setting_value) VALUES ('school_name','Dugsiga Tusaalaha'),('default_language','so'),('currency','USD'),('idle_timeout_minutes','30');
