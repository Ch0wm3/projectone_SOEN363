-- Thanh Notes: This file contains SQL queries for Q5-Q8
-- SID: 40310332

-- Q5: Find all ICU or CCU unit stays that lasted more than seven days. Display the
-- patient name, unit type, unit entry time, unit exit time, and calculated length of stay.

SELECT p.full_name,
    u.unit_type,
    u.entry_date_time,
    u.exit_date_time,
    (u.exit_date_time - u.entry_date_time) as length_of_stay
FROM Unit_Stay u
-- Thanh Notes: Joining Unit_Stay with Admission and Patient to combine rows.
Join Admission a
    ON u.admission_id = a.admission_id
Join Patient p
    ON a.patient_id = p.patient_id
-- Thanh Notes: Used WHERE in order to filter for ICU or CCU stays that lasted more than seven days.
WHERE u.unit_type IN ('ICU', 'CCU')
  AND (u.exit_date_time - u.entry_date_time) > interval '7 days';

-- Q6: Count the total number of hospital admissions for each patient. Include patients who
-- have no recorded admissions.

SELECT p.full_name,
       COUNT(a.admission_id) AS total_admissions
FROM Patient p
-- Thanh Notes: Using LEFT JOIN to include patients with no admissions and will dismiss NULL values for total_admissions
-- And will also dismiss values for patients with no admissions (total_admissions will be 0).
LEFT JOIN Admission a
       ON p.patient_id = a.patient_id
-- Thanh Notes: Grouping by patient name to get the total number of admissions per patient
-- Thanh Notes: Whitout the GROUP BY clause, the query would not correctly aggregate the total admissions per patient since we wouldn't know which patient to show the number of admissions.
GROUP BY p.full_name;


-- Q7: List all patients who entered the hospital through the Emergency Department and were later transferred to an ICU
-- or CCU during the same admission.

SELECT p.full_name,
       a.admission_id,
       u.unit_type,
       u.entry_date_time,
       u.exit_date_time
FROM Patient p
JOIN Admission a
    ON p.patient_id = a.patient_id
JOIN Unit_Stay u
    ON a.admission_id = u.admission_id
-- Thanh Notes: Check the admission source to identify patients
-- who entered through the Emergency Department.
WHERE a.admission_source = 'Emergency Department'
-- Thanh Notes: Filter for patients transferred to ICU or CCU
-- after their initial admission.
  AND u.unit_type IN ('ICU', 'CCU')
  AND u.entry_date_time > a.admission_date_time;



-- Q8: Retrieve the most frequently assigned primary ICD-9 diagnosis among admissions that included at least one ICU or CCU stay.

SELECT d.icd_9_code,
       d.official_diagnosis_title,
-- Thanh Notes: In order to prevent duplication
       STRING_AGG(DISTINCT u.unit_type, ', ') AS unit_types,
       COUNT(DISTINCT dr.admission_id) AS assignment_count
FROM Diagnosis_Record dr
JOIN ICD9_Dictionary d
    ON dr.icd_9_code = d.icd_9_code
JOIN Unit_Stay u
    ON dr.admission_id = u.admission_id
-- Thanh Notes: Only consider primary diagnoses.
WHERE dr.diagnosis_type = 'Primary'
-- Thanh Notes: Filter for admissions with ICU or CCU stays.
  AND u.unit_type IN ('ICU', 'CCU')
GROUP BY d.icd_9_code, d.official_diagnosis_title
ORDER BY assignment_count DESC
-- Thanh Notes: Return the most frequently assigned diagnosis.
LIMIT 1;
