
SELECT first_name, last_name, gender 
from patients where gender='M';

select first_name, last_name 
from patients where allergies is null;

select first_name 
from patients where first_name like 'C%';

select first_name, last_name 
from patients where weight between 100 and 120;

update patients 
set allergies='NKA' where allergies is null;

select concat(first_name,' ',last_name) 
from patients;

select patients.first_name, patients.last_name, province_names.province_name 
from patients join province_names 
on patients.province_id=province_names.province_id;

select count(patient_id) 
from patients where year(birth_date) = 2010;

select first_name,last_name,max(height) 
from patients;

select * from patients 
where patient_id in(1,45,534,879,1000);

select count(*) from admissions;

select * from admissions 
where admission_date = discharge_date;

select patient_id, count(patient_id) 
from admissions where patient_id=579;

select city from patients 
where province_id = 'NS' group by city;

select first_name,last_name,birth_date 
from patients where height>160 and weight>70;

select first_name,last_name,allergies from patients 
where city='Hamilton' and allergies is not null;

select city from patients 
where city like 'a%' or city like 'e%' or city like 'i%' 
or city like 'o%' or city like 'u%' group by city;

select year(birth_date) as years 
from patients group by years;

select first_name from patients 
group by first_name having count(first_name) = 1;

select patient_id,first_name 
from patients where first_name like 's____%s';

select patients.patient_id,patients.first_name,patients.last_name
from patients join admissions on patients.patient_id=admissions.patient_id 
where admissions.diagnosis = 'Dementia';

select first_name from patients 
order by len(first_name), first_name;

select (select count(*) from patients where gender='M') as male_count,
(select count(*) from patients where gender='F') as female_count;

select first_name,last_name,allergies from patients 
where allergies='Penicillin' or allergies='Morphine' 
order by allergies, first_name, last_name;

select patient_id, diagnosis from admissions 
group by patient_id,diagnosis having count(*)>1;

select city, count(*) as total from patients 
group by city order by total desc, city;

select first_name, last_name, 'Patient' as Role from patients
union all
select first_name, last_name, 'Doctor' as Role from doctors;

select allergies, count(*) as popularity from patients 
where allergies is not null group by allergies 
order by popularity desc;

select first_name,last_name, birth_date from patients 
where year(birth_date) between 1970 and 1979
order by birth_date;

select concat(upper(last_name),',',lower(first_name)) 
from patients order by first_name desc;

select province_id, sum(height) as heights from patients
group by province_id having heights>=7000;

select max(weight)-min(weight) from patients 
where last_name='Maroni';

select day(admission_date), count(*) as number from admissions
group by day(admission_date)
order by number desc;

select * from admissions where patient_id=542 
order by admission_date desc limit 1;

select patient_id,attending_doctor_id,diagnosis from admissions 
where patient_id%2!=0 and attending_doctor_id in(1,5,19)
or
attending_doctor_id like '%2%' and len(patient_id)=3;

select doctors.first_name,doctors.last_name,count(admissions.patient_id) 
from doctors join admissions on doctors.doctor_id=admissions.attending_doctor_id
group by admissions.attending_doctor_id;

select doctors.doctor_id, concat(first_name,' ',last_name), min(admission_date), max(admission_date)
from doctors join admissions on doctors.doctor_id=admissions.attending_doctor_id
group by doctor_id;

select province_names.province_name, count(patient_id) as total from province_names join patients
on province_names.province_id=patients.province_id 
group by patients.province_id
order by total desc;

select concat(patients.first_name,' ',patients.last_name), admissions.diagnosis, 
concat(doctors.first_name,' ',doctors.last_name) from patients, admissions, doctors where
patients.patient_id=admissions.patient_id and admissions.attending_doctor_id=doctors.doctor_id;

select first_name, last_name, count(*) as total from patients
group by concat(first_name,last_name)
having count(concat(first_name,last_name))>1;

select concat(first_name,' ',last_name), round(height/30.48,1) as height,
round(weight*2.205,0) as weight, birth_date,
case
	when gender='M' then 'MALE'
    else 'FEMALE'
end as Gender_type
from patients;

SELECT
  COUNT(*) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

select patient_id, weight, height, 
case 
	when weight/((height*0.01)*(height*0.01)) >=30 then 1
    else 0
    end as isObese
from patients;

select patients.patient_id, patients.first_name, patients.last_name, doctors.specialty 
from patients join admissions on patients.patient_id=admissions.patient_id join
doctors on doctors.doctor_id=admissions.attending_doctor_id 
where admissions.diagnosis like '%Epilepsy%'
and doctors.first_name = 'Lisa';

select distinct patients.patient_id,
concat(patients.patient_id, len(patients.last_name),year(patients.birth_date))
from patients join admissions on patients.patient_id=admissions.patient_id;

select
case
	when patient_id%2=0 then 'Yes'
    else 'No'
    end as has_insurance,
sum(case
	when patient_id%2=0 then 10
  	else 50
  	end)
from admissions
group by has_insurance;