create database if not exists ocd_patient_worldwide;

-- 1. Count & pct of F vs M that have OCD & -- Average obsession score by gender .
 select 
 gender,
 count(`Patient ID`) as patient_count,
 round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
 from ocd_patient_dataset
 group by 1
 order by 2;
 
 --  Using ctE to get the percentage 
with data as (
select 
 gender,
 count(`Patient ID`) as patient_count,
 round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
 from ocd_patient_dataset
 group by 1
 order by 2
 ) 
 select *
 from data ; 
 
 select 
 sum(case when gender = 'Female' then patient_count else 0 end) as count_female, 
 sum(case when gender = 'Male' then patient_count else 0 end) as count_male,
 
 round(sum(case when gender ='Female' then patient_count else 0 end)/
 (sum(case when gender = 'Female' then patient_count else 0 end)+sum(case when gender = 'Male' then patient_count else 0 end))*100,2) as pct_female,
 
  round(sum(case when gender ='Male' then patient_count else 0 end)/
 (sum(case when gender = 'Female' then patient_count else 0 end)+sum(case when gender = 'Male' then patient_count else 0 end))*100,2) as pct_male

 from data
 ;
 
-- 2. Count of patients by etnicity and their respective avg obsession score .

select 
Ethnicity,
count(`Patient ID`) as patient_count,
avg(`Y-BOCS Score (Obsessions)`) avg_obs_score
from ocd_patient_dataset
group by 1
order by 2;

-- 3. Number of people diagnosed with OCD MoM.
alter table ocd_patient_dataset
modify `OCD Diagnosis Date` date;

select 
date_format(`OCD Diagnosis Date`, '%Y-%M-01 00:00:00') as month,
count(`Patient ID`) patient_count
from ocd_patient_dataset
group by 1
order by 1;
-- 4. What is the most common obsession type (count) & it's respective average obsession score.
select 
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
from ocd_patient_dataset
group by 1
order by 2;

-- 5. What is the most common compulsion type (count) & it's respective average obsession score
select 
`Compulsion Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
from ocd_patient_dataset
group by 1
order by 2;
