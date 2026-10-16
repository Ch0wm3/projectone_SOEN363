----------------- Q1: List the names and admission dates of all patients who were classified as high-priority emergency patients during triage ------------------------

-- Tables needed to retrieve the patient's name, admission date, and triage priority: Patient, Admission, Triage_Assessment
-- Columns needed:
--   - full_name from Patient
--   - admission_date_and_time from Admission
--   - triage_priority_level from Triage_Assessment
--   - patient_id from Patient (PK) and Admission (FK)
--   - admission_type from Admission


--What we want to display in the final result: names and admission dates
SELECT DISTINCT
    p.full_name,
    a.admission_date_and_time::date AS admission_date

FROM Patient AS p
-- Match the patient ids. Patient has patient_id as PK, Admission and Triage_Assessment has patient_id as FK
JOIN Admission AS a
    ON a.patient_id = p.patient_id
JOIN Triage_Assessment AS t
    ON t.admission_id = a.admission_id
-- Return the admission id when t.triage_priority_level is high and the admission_type
WHERE t.triage_priority_level = 'High' AND a.admission_type = 'Emergency'
ORDER BY admission_date, p.full_name;
;



----------------- Q2: Find all patients who had more than three hospital admissions. Display the patient identifier, patient name, and total number of admissions ------------------------

-- Tables needed to retrieve the patient's id, patient's name, and total number of admissions: Patient and Admission
-- Columns needed: patient_id from Patient (PK) and Admission (FK),  full_name from Patient, admission_id from Admission

--What we want to display in the final result: patient's id, patient's name and nb of admissions
SELECT
    p.patient_id,
    p.full_name,
    -- Count how many admissions each patient has
    COUNT(a.admission_id) AS total_admissions
FROM Patient AS p

-- Match the patient ids. Patient has patient_id as PK, Admission has patient_id as FK
JOIN Admission AS a
    ON a.patient_id = p.patient_id

-- Group the rows with the same patient id 
GROUP BY
    p.patient_id

-- Filter out the patients with less than three admissions ('HAVING' instead of 'WHERE' because it is after an aggregation)
HAVING COUNT(a.admission_id) > 3

-- Sort by descending order of number of admissions
ORDER BY total_admissions DESC;





----------------- Q3: Retrieve the names, admission dates, and discharge dates of patients who were discharged without undergoing any surgical procedure during the admission. ------------------------

-- Tables needed to retrieve the patient's name, admission dates, and discharge dates: Patient, Admission, and Discharge_Record
-- Columns needed: 
--   - patient_id from Patient (PK) and Admission (FK),
--   - admission_id from Admission (PK) and Discharge_Record (FK) 
--   - full_name from Patient
--   - admission_date_and_time from Admission
--   - discharge_date_and_time from Discharge
--   - final_admission_status from Admission


SELECT
    p.full_name,
    a.admission_date_and_time::date AS admission_date,
    d.discharge_date_and_time::date AS discharge_date
FROM Patient AS p
-- Match each admission to the patient who had it using patient_id.
JOIN Admission AS a
    ON a.patient_id = p.patient_id
-- Match the discharge record to the admission to retrieve its discharge date.
JOIN Discharge_Record AS d
    ON d.admission_id = a.admission_id
-- Keep admissions whose final status is Discharged.
WHERE a.final_admission_status = 'Discharged'
  -- Keep only admissions for which no surgical procedure record exists.
  AND NOT EXISTS (
      SELECT 1
      FROM Surgical_Procedure AS sp
      WHERE sp.admission_id = a.admission_id
  )
-- Sort the results by admission date, then by patient name.
ORDER BY admission_date, p.full_name;

----------------- Q4: List all patients who had both a radiology examination and a surgical procedure during the same admission ------------------------
