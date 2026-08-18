Hospital Data Analysis & Power BI Dashboard

#Project Overview

This project analyzes hospital data using **MySQL and Microsoft Power BI**.

#The goal of the project is to clean, transform, analyze, and visualize hospital data to identify useful insights related to:

- Doctors
- Patients
- Appointments
- Departments
- Treatment costs
- Appointment status
- Patient demographics
- Insurance providers

The project follows a complete data-analysis workflow, starting from data cleaning in MySQL and ending with an interactive Power BI dashboard.
--Tools & Technologies

MySQL – Data cleaning, transformation, and analysis
SQL – Data validation, joins, aggregations, and analytical queries
Power BI – Data visualization and dashboard development

 Dataset Structure

The hospital database contains three main tables:

1. Doctors Table

Contains information about hospital doctors.

| Column | Description |
|---|---|
| DoctorID | Unique doctor identifier |
| DoctorName | Name of the doctor |
| Department | Doctor's department |
| ExperienceYears | Years of professional experience |

2. Patients Table

Contains information about patients.

| Column | Description |
|---|---|
| PatientID | Unique patient identifier |
| PatientName | Patient name |
| Age | Patient age |
| Gender | Patient gender |
| City | Patient city |
| BloodGroup | Patient blood group |
| InsuranceProvider | Insurance provider |
| RegistrationDate | Patient registration date |

3. Appointments Table

Contains information about patient appointments.

| Column | Description |
|---|---|
| AppointmentID | Unique appointment identifier |
| PatientID | Patient identifier |
| DoctorID | Doctor identifier |
| AppointmentDate | Date of appointment |
| Diagnosis | Patient diagnosis |
| TreatmentCost | Cost of treatment |
| PaymentMode | Payment method |
| AppointmentStatus | Appointment status |

Data Cleaning Process

The data was cleaned using MySQL before performing analysis.

Cleaning steps included:
- Removed unwanted spaces using `TRIM()`
- Standardized text using `LOWER()`
- Checked for NULL values
- Checked for blank values
- Identified duplicate IDs
- Investigated duplicate patient records
- Standardized categorical fields
- Modified identifier columns to appropriate `VARCHAR` types
- Added primary keys to important identifier columns
- Validated categorical values such as:
- Blood groups
- Gender
- Cities
- Insurance providers
- Appointment status
   │ PatientID
   ▼
Patients
