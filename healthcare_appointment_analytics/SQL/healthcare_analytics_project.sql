CREATE DATABASE IF NOT EXISTS healthcare_db;

USE healthcare_db;

CREATE TABLE IF NOT EXISTS Patients (
    Patient_ID VARCHAR(10) PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(20),
    City VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Departments (
    Department_ID VARCHAR(10) PRIMARY KEY,
    Department VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Appointments (
    Appointment_ID VARCHAR(10) PRIMARY KEY,
    Patient_ID VARCHAR(10),
    Department_ID VARCHAR(10),
    Doctor VARCHAR(100),
    Appointment_Date DATE,
    Appointment_Status VARCHAR(50),
    Visit_Type VARCHAR(50),
    Medical_Condition VARCHAR(100),
    Waiting_Time_Min INT,
    Appointment_Duration_Min INT,
    Insurance_Type VARCHAR(50),
    Billing_Amount DECIMAL(10,2),

    FOREIGN KEY (Patient_ID)
        REFERENCES Patients(Patient_ID),

    FOREIGN KEY (Department_ID)
        REFERENCES Departments(Department_ID)
);

SHOW TABLES;

DESCRIBE Patients;

DESCRIBE Departments;


ALTER TABLE Patients
ADD COLUMN Age_Group VARCHAR(20);

SELECT COUNT(*) AS Total_Patients
FROM Patients;

SELECT COUNT(*) AS Total_Departments
FROM Departments;

SELECT COUNT(*) AS Total_Appointments
FROM Appointments;

#join-patient + appointment


SELECT
    a.Appointment_ID,
    a.Patient_ID,
    p.Patient_Name,
    p.Age,
    p.Gender,
    p.City,
    a.Doctor,
    a.Appointment_Date,
    a.Appointment_Status,
    a.Visit_Type,
    a.Medical_Condition,
    a.Waiting_Time_Min,
    a.Appointment_Duration_Min,
    a.Insurance_Type,
    a.Billing_Amount
FROM Appointments a
JOIN Patients p
    ON a.Patient_ID = p.Patient_ID;

#three table join

SELECT
    a.Appointment_ID,
    p.Patient_Name,
    p.Age,
    p.Gender,
    p.City,
    d.Department,
    d.Location,
    a.Doctor,
    a.Appointment_Date,
    a.Appointment_Status,
    a.Visit_Type,
    a.Medical_Condition,
    a.Waiting_Time_Min,
    a.Appointment_Duration_Min,
    a.Insurance_Type,
    a.Billing_Amount
FROM Appointments a
JOIN Patients p
    ON a.Patient_ID = p.Patient_ID
JOIN Departments d
    ON a.Department_ID = d.Department_ID;
    
#total appoint

SELECT
    a.Appointment_ID,
    p.Patient_Name,
    d.Department,
    a.Doctor,
    a.Appointment_Status,
    a.Billing_Amount
FROM Appointments a
JOIN Patients p
    ON a.Patient_ID = p.Patient_ID
JOIN Departments d
    ON a.Department_ID = d.Department_ID
LIMIT 10;

#Total Appointments

SELECT COUNT(*) AS Total_Appointments
FROM Appointments;

#analyze appointments by department 

SELECT
    d.Department,
    COUNT(*) AS Total_Appointments
FROM Appointments a
JOIN Departments d
    ON a.Department_ID = d.Department_ID
GROUP BY d.Department
ORDER BY Total_Appointments DESC;

#Appointment Status

SELECT
    Appointment_Status,
    COUNT(*) AS Total
FROM Appointments
GROUP BY Appointment_Status
ORDER BY Total DESC;

#Appointment Status

SELECT
    Appointment_Status,
    COUNT(*) AS Total
FROM Appointments
GROUP BY Appointment_Status
ORDER BY Total DESC;
#No-Show Rate

SELECT
    ROUND(
        COUNT(CASE
            WHEN Appointment_Status = 'No Show' THEN 1
        END) * 100.0 / COUNT(*),
        2
    ) AS No_Show_Rate
FROM Appointments;

#Average Waiting Time by Department

SELECT
    d.Department,
    ROUND(AVG(a.Waiting_Time_Min), 2) AS Avg_Waiting_Time
FROM Appointments a
JOIN Departments d
    ON a.Department_ID = d.Department_ID
GROUP BY d.Department
ORDER BY Avg_Waiting_Time DESC;

#Revenue by Department 

SELECT
    d.Department,
    ROUND(SUM(a.Billing_Amount), 2) AS Total_Revenue
FROM Appointments a
JOIN Departments d
    ON a.Department_ID = d.Department_ID
GROUP BY d.Department
ORDER BY Total_Revenue DESC;

#Appointments by Visit Type

SELECT
    Visit_Type,
    COUNT(*) AS Total_Visits
FROM Appointments
GROUP BY Visit_Type
ORDER BY Total_Visits DESC;

#Appointments by Insurance Type

SELECT
    Insurance_Type,
    COUNT(*) AS Total_Appointments,
    ROUND(SUM(Billing_Amount), 2) AS Total_Revenue
FROM Appointments
GROUP BY Insurance_Type
ORDER BY Total_Revenue DESC;

#Medical Conditions

SELECT
    Medical_Condition,
    COUNT(*) AS Total_Appointments
FROM Appointments
GROUP BY Medical_Condition
ORDER BY Total_Appointments DESC;

#Doctor Performance

SELECT
    Doctor,
    COUNT(*) AS Total_Appointments,
    ROUND(AVG(Waiting_Time_Min), 2) AS Avg_Waiting_Time,
    ROUND(SUM(Billing_Amount), 2) AS Total_Revenue
FROM Appointments
GROUP BY Doctor
ORDER BY Total_Appointments DESC;