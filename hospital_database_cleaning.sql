#-------------- DATA CLEANING OF HOSPITAL DATABASE -----------------
use hospital_database;

# ------ Cleaning doctor_table ------
select * from appointments_table;

# ------ removing unwanted space ------
update appointments_table
set AppointmentID=trim(AppointmentID),
    PatientID=trim(PatientID),
    DoctorID=trim(DoctorID),
    AppointmentDate=trim(AppointmentDate),
    Diagnosis=lower(trim(Diagnosis)),
    TreatmentCost=Trim(TreatmentCost),
    PaymentMode=lower(trim(PaymentMode)),
    AppointmentStatus=lower(trim(AppointmentStatus));

# ------ identifying any null value in table if exist ------
select * from appointments_table
where PatientID=' ' or PatientID is null
   or DoctorID=' '  or DoctorID is null
   or AppointmentDate=' ' or AppointmentDate is null
   or Diagnosis=' ' or Diagnosis is null
   or TreatmentCost=' ' or TreatmentCost is null
   or PaymentMode=' ' or PaymentMode is null
   or AppointmentStatus=' ' or AppointmentStatus is null;
   
# ------ identifying any duplicate value in rows ------
select Diagnosis,count(Diagnosis) as no_of_diagnosis from appointments_table
group by Diagnosis
order by no_of_diagnosis;

select PaymentMode,count(PaymentMode) as total_transaction from appointments_table
group by PaymentMode
order by total_transaction asc;

select AppointmentStatus,count(AppointmentStatus) as total_cases from appointments_table
group by AppointmentStatus
order by total_cases;

# ------ modifying Appointments_table from text to varchar ------
alter table appointments_table
modify AppointmentID varchar(50);

# ------ identifying any duplicate value if exist -----
select AppointmentID,count(AppointmentID) as duplicateID from appointments_table
group by AppointmentID
order by duplicateID desc;

# ------ declaring Appointment id a primary key ---------
alter table appointments_table
add primary key(AppointmentID);

commit;

# --------- cleaning doctor_table ---------
select * from doctors_table;

# -------- identifying any null value in database ---------
select DoctorID,count(DoctorID) as doctor_id from doctors_table
group by DoctorID
order by doctor_id;

# -------- triming unwanted space ----------
update doctors_table
set DoctorID = trim(DoctorID), 
    DoctorName = lower(trim(DoctorName)),
    Department = lower(trim(Department)),
    ExperienceYears=trim(ExperienceYears);
      
# -------- identifying any null value in any column ---------
select * from doctors_table
where DoctorID=' ' or DoctorID is null
   or DoctorName=' ' or DoctorName is null
   or Department=' ' or Department is null
   or ExperienceYears=' ' or ExperienceYears is null;

# ------- identifying any duplicate key in any column ---------
select Department,count(Department) as total_department from doctors_table
group by Department
order by total_department;

# -------- declering size of DoctorID and declaring it a primary key --------
alter table doctors_table
modify DoctorID varchar(20),
add primary key(DoctorID);
   
# -------- Cleaning patients_table --------
select * from patients_table;

# -------- identifying any null value in any column ----------
select * from patients_table
where PatientID =' ' or PatientID is null
   or PatientName=' ' or PatientName is null
   or Age=' ' or Age is null
   or Gender=' ' or Gender is null
   or City=' ' or City is null
   or BloodGroup=' ' or BloodGroup is null
   or InsuranceProvider=' ' or InsuranceProvider is null
   or RegistrationDate =' ' or RegistrationDate is null; 
   
# ----------- identifying any duplicate value -------------
select PatientID,count(PatientID) as Count_of_duplicates from patients_table
group by PatientID
having Count_of_duplicates >1;

select PatientName,count(PatientName) as no_of_patient,City from patients_table
group by PatientName,City
order by no_of_patient desc;
   
#----------- removing(treming) unwanted space from each cell ------------
update  patients_table
set PatientID=trim(PatientID),
    PatientName=trim(lower(PatientName)),
    Age=trim(Age),
    Gender=trim(lower(Gender)),
    City=trim(lower(City)),
    BloodGroup=trim(lower(BloodGroup)),
    InsuranceProvider=trim(lower(InsuranceProvider)),
    RegistrationDate=trim(RegistrationDate);
   
# ------------------ declering PatientID as primary key --------------------
alter table patients_table
modify PatientID varchar(20),
add primary key(PatientID);   

# ------------------ Identifying any wrong spelling if exist -----------------
select distinct BloodGroup
from patients_table
order by BloodGroup;

select gender,count(gender) as no_of_patient from patients_table
group by gender;

select city,count(city) as count_city from patients_table
group by city
order by count_city desc;

# ----------------------------- completed ---------------------------------

