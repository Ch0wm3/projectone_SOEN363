----------------- Q1: List the names and admission dates of all patients who were classified as high-priority emergency patients during triage ------------------------

-- Tables needed to retrieve the patient's name, admission date, and triage priority: Patient, Admission, Triage_and_Assessment
-- Columns needed: name from Patient, admission_date_and_time from Admission and triage_priority_level from Triage_and_Assessment


--What we want to display in the final result: names and admission dates
SELECT DISTINCT
    p.name,
    a.admission_date_and_time::date AS admission_date

FROM Patient AS p,
-- Match the patient ids. Patient has patient_id as PK, Admission and Triage_and_Assessment has patient_id as FK
JOIN Admission AS a
    ON a.patient_id = p.patient_id
JOIN Triage_and_Assessment AS t
    ON t.admission_id = a.admission_id
-- Return the admission id when t.triage_priority_level is high and the admission_type
WHERE t.triage_priority_level = 'High' AND a.admission_type = 'Emergency'
ORDER BY admission_date, p.name;
;



----------------- Q2: Find all patients who had more than three hospital admissions. Display the patient identifier, patient name, and total number of admissions ------------------------

-- Tables needed to retrieve the patient's id, patient's name, and total number of admissions: Patient and Admission
-- Columns needed: patient_id from Patient (PK) and Admission (FK),  name from Patient

--What we want to display in the final result: patient's id, patient's name and nb of admissions
SELECT
    p.patient_id,
    p.name,
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







----------------- Q4: List all patients who had both a radiology examination and a surgical procedure during the same admission ------------------------

