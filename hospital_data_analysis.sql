# ---------- analysis of database ------------
call appoinment();
call doctor();
call patient();
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
      sum(case when 18 <o.Age and o.age<=35 then 1 else 0 end) as young,
      sum(case when 35 <o.Age and o.age<=50 then 1 else 0 end) as old_persom,
      sum(case when 50 <o.Age and o.age<=100 then 1 else 0 end)senior_citizion,
      count(t.PatientID) as total_patient
from doctors_table s
left join appointments_table t
on s.DoctorID=t.DoctorID

left join  patients_table o
on t.PatientID=o.PatientID
group by s.Department
order by total_patient desc;

# ------- count of doctors from each city ---------------
select count(distinct s.DoctorID) as total_doctor,
	   s.Department,
       count(distinct case when o.City='ahmedabad' then s.DoctorID end) as Ahmedabad,
       count(distinct case when o.City='mumbai' then s.DoctorID end) as Mumbai,
       count(distinct case when o.City='benguluru' then s.DoctorID end) as Benguluru,
       count(distinct case when o.City='jaipur' then s.DoctorID end) as Jaipur,
       count(distinct case when o.City='delhi' then s.DoctorID end) as Delhi,
       count(distinct case when o.City='pune' then s.DoctorID end) as Pune,
       count(distinct case when o.City='chennai' then s.DoctorID end) as Chennai,
       count(distinct case when o.City='lucknow' then s.DoctorID end) as lucknow,
       count(distinct case when o.City='hydrabad' then s.DoctorID end) as Hydrabad,
       count(distinct case when o.City='kolkata' then s.DoctorID end) as kolkata
from doctors_table s
left join appointments_table t
on s.DoctorID=t.DoctorID

left join patients_table o
on t.PatientID=o.PatientID
group by s.department;

# ----------- doctors those have more experience then avg exp ------------
with average_exp as (select Department,avg(ExperienceYears) as avg_ex from doctors_table group by Department)
select d.DoctorID,
       d.Department,
       d.ExperienceYears,
       av.avg_ex
from doctors_table d
left join average_exp av
on d.Department=av.Department
where d.ExperienceYears> av.avg_ex;

# --------- create view including department from doctor table -------------
create view  merg_table as select 
                     t.AppointmentID,
                     o.PatientID,
                     o.PatientName,
                     s.DoctorID,
                     s.DoctorName,
                     s.Department,
                     o.city,
                     t.Diagnosis
from doctors_table s
left join appointments_table t
on s.DoctorID=t.DoctorID

left join patients_table o
on t.PatientID=o.PatientID;
                         
# count no od doctors each doctors have group by city and department
select  city,     
       (count(distinct case when Department='cardiology' then DoctorID end)/count(case when Department='cardiology' then PatientID end)) as cardiology,
       (count(distinct case when Department='neurology' then DoctorID end)/count(case when Department='neurology' then PatientID end)) as neurology,  
	   (count(distinct case when Department='orthopedics' then DoctorID end)/count(case when Department='orthopedics' then PatientID end)) as orthopedics,     
	   (count(distinct case when Department='dermatology' then DoctorID end)/count(case when Department='dermatology' then PatientID end)) as dermatology,  
	   (count(distinct case when Department='general medicine' then DoctorID end)/count(case when Department='general medicine' then PatientID end)) as general_medicine,  
	   ( count(distinct case when Department='gynecology' then DoctorID end)/count(case when Department='gynecology' then PatientID end)) as gynecology,  
	   (count(distinct case when Department='ent' then DoctorID end)/count(case when Department='ent' then PatientID end)) as ent,  
	   (count(distinct case when Department='ophthalmology' then DoctorID end)/count(case when Department='ophthalmology' then PatientID end)) as ophthalmology, 
	   (count(distinct case when Department='urology' then DoctorID end)/count(case when Department='urology' then PatientID end)) as urology
from merg_table
group by city ;

# --------------- complete -----------------
