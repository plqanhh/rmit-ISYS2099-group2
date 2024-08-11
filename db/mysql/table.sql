CREATE DATABASE hospital_management;
use hospital_management;

-- Patient table-- 
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    allergies TEXT,
    contact_info VARCHAR(100)
	-- created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
--     insurance_provider VARCHAR(100),
--     insurance_policy_number VARCHAR(50),
) ENGINE=InnoDB;

-- Staff table
CREATE TABLE Staffs (
	staff_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
--     mananger_id int NOT NULL,
    staff_fname VARCHAR(50),
    staff_lname VARCHAR(50),
    salary DECIMAL(10,2) NOT NULL,
    job_type ENUM('Doctor','Nurse','Admin'),
    email VARCHAR(100),
	FOREIGN KEY (department_id) REFERENCES Departments(department_id),
--     FOREIGN KEY (manager_id) REFERENCES Staffs(staff_id)
)ENGINE=InnoDB;

-- Department Table
CREATE TABLE Departments (
    department_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)ENGINE=InnoDB;

-- Treatment History Table
CREATE TABLE Treatment_History (
    treatment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    staff_id INT NOT NULL,
    description TEXT,
    treatment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
)ENGINE=InnoDB;

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    staff_id INT NOT NULL,
    appointment_time TIME NOT NULL,
    appointment_date DATE NOT NULL,
    purpose VARCHAR(50) NOT NULL,
    status ENUM('Requested','Booked'),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
)ENGINE=InnoDB;

-- Schedules Table
CREATE TABLE Schedules (
    schedule_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    shift_start DATETIME NOT NULL,
    shift_end DATETIME NOT NULL,
    availability_status ENUM('Available', 'Busy') NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
)ENGINE=InnoDB;

-- Appointment Notes Table
CREATE TABLE Appointment_Notes (
    document_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    document_type VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
)ENGINE=InnoDB;

-- Job History Table
CREATE TABLE Job_History (
    history_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    department_id INT,
    job_type ENUM('Doctor', 'Nurse', 'Admin'),
    start_date DATE,
    end_date DATE,
    changed_field ENUM('job_type', 'department_id', 'salary', 'qualification'),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
)ENGINE=InnoDB;

--Report table
CREATE TABLE Reports (
    report_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,  -- Nullable, as not all reports will be about patient
    staff_id INT,  -- Nullable, as not all reports will be about staff
    report_type ENUM('Patient Treatment History', 'Staff Workload', 'Staff Performance', 'Billing') NOT NULL,
    report_date DATETIME NOT NULL,
    report_content TEXT NOT NULL,  
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
)ENGINE=InnoDB;