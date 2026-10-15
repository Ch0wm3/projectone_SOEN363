----------------- Q1: List the names and admission dates of all patients who were classified as high-priority emergency patients during triage ------------------------

-- Tables needed to retrieve the patient's name, admission date, and triage priority: Patient, Admission, Triage_and_Assessment
-- Columns needed: name from Patient, admission_date_and_time from Admission and triage_priority_level from Triage_and_Assessment
SELECT p.name, a.admission_date_and_time, t.triage_priority_level 
FROM Patient AS p,
-- Match the patient identifiers. Patient has patient_identifier as PK, Admission and Triage_and_Assessment has patient_identifier as FK
JOIN Admission AS a
    ON p.patient_identifier = a.patient_identifier

-- Return the admission id when t.triage_priority_level is high and the admission_type
WHERE t.triage_priority_level = 'High' AND a.admission_type = 'Emergency'
;



----------------- Q2: Find all patients who had more than three hospital admissions. Display the patient identifier, patient name, and total number of admissions ------------------------









----------------- Q3: Retrieve the names, admission dates, and discharge dates of patients who were discharged without undergoing any surgical procedure during the admission. ------------------------







----------------- Q4: List all patients who had both a radiology examination and a surgical procedure during the same admission ------------------------

