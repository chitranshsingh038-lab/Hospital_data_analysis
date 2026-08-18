# ---------- analysis of database ------------
select * from doctors_table;
select * from patients_table;
select * from appointments_table;

# ------------ count no of appoinment each docter have -----------
select s.DoctorID,
       s.DoctorName,
       s.Department,
       count(o.PatientID) as total_patient
from doctors_table s
left join appointments_table o
on s.DoctorID=o.DoctorID
group by s.DoctorID
order by total_patient desc;

# ------------- which doctor has rejected most Appointment -------------
select s.DoctorID,
       s.DoctorName,
       s.department,
       AppointmentStatus,
       count(o.AppointmentStatus) as total_appoinments
from doctors_table s
left join Appointments_table o
on s.DoctorID=o.DoctorID
group by DoctorID,AppointmentStatus  
order by total_appoinments desc;

# ----------- avg experience of doctors ----------------
select Department,avg(ExperienceYears) as avg_experience_of_each_department from doctors_table
group by Department
order by  avg_experience_of_each_department desc;

# ---------- evg treatement_cost from each department
select s.Department,
       avg(o.TreatmentCost) as avg_treatement_cost
from doctors_table s
left join appointments_table o
on s.DoctorID=o.DoctorID
group by s.Department
order by avg_treatement_cost desc ;    

# --------------no of insurance patient have ------------------
select Gender,InsuranceProvider,count(InsuranceProvider) as no_Insurance from patients_table
group by Gender,InsuranceProvider
order by no_insurance desc;

#-------------- no of patient of each blood group -----------------
select BloodGroup,count(PatientID) as no_of_patient from patients_table
group by BloodGroup
order by no_of_patient;

# ------------- no of patient from each city ------------------- 
select City,count(PatientID) as `patient from one city` from patients_table
group by City
order by `patient from one city` desc;

#--------------- Insurance provider according to avg age ---------------
select avg(Age) as avg_age,InsuranceProvider from patients_table
group by InsuranceProvider
order by avg_age;

# ------------- avg cost of each doctor and how many cases he handeled -----------------    
select s.DoctorName,
    sum(case when o.AppointmentStatus='completed' then 1 else 0 end) as Completed,
    sum(case when o.AppointmentStatus='cancelled' then 1 else 0 end) as Canceled,
    sum(case when o.AppointmentStatus='scheduled' then 1 else 0 end) as Scheduled,
       avg(o.TreatmentCost) as avg_treatement_cost
from doctors_table as s
left join appointments_table as o
on s.DoctorID=o.DoctorID
group by s.DoctorName
order by avg_treatement_cost;

# -------------------- appointments completed from each department ----------------
select count(s.DoctorID) as total_doctors,
	   s.Department,
       sum(case when o.AppointmentStatus='completed' then 1 else 0 end) as completed,
       sum(case when o.AppointmentStatus='cancelled' then 1 else 0 end) as cancelled,
       sum(case when o.AppointmentStatus='scheduled' then 1 else 0 end) as scheduled
from doctors_table s    
left join appointments_table o
on s.DoctorID=o.DoctorID
group by s.Department
order by total_doctors desc;
   
# ----------------- avg age of patient from each department ------------------   
select s.Department, 
      sum(case when o.Age<=18 then 1 else 0 end) as teenagers,
      sum(case when 18 <o.Age and o.age>=35 then 1 else 0 end) as young,
      sum(case when 35 <o.Age and o.age>=50 then 1 else 0 end) as old_persom,
      sum(case when 50 <o.Age and o.age>=100 then 1 else 0 end)senior_citizion,
      count(t.PatientID) as total_patient
from doctors_table s
left join appointments_table t
on s.DoctorID=t.DoctorID

left join  patients_table o
on t.PatientID=o.PatientID
group by s.Department
order by total_patient desc;

select * from appointments_table;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
select * from patients_table

