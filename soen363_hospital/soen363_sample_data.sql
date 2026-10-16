-- Original prompt:
-- Data sources and generation notes
-- Source for the hospital entities in soen363_sql_data.sql:
-- AI-generated fictional synthetic data for educational use. No MIMIC-III data
-- or real patient information is included. ICD-9 codes are used as labels for
-- fictional cases; the accompanying descriptions are educational summaries.
-- Prompt used: "Generate completely fictional, synthetic hospital records for
-- every table in this hospital schema for educational use only. Do not use or
-- imitate real patients or include personally identifiable information.
-- Ensure unique primary keys, valid foreign keys, chronological timestamps,
-- procedures and examinations within their admissions, and a primary ICD-9
-- diagnosis for each completed admission. Include enough variation to exercise
-- all 20 required SQL queries, including repeat admissions, no-admission and
-- no-radiology patients, emergency triage, unit transfers, critical-care stays
-- of different lengths, surgeries, radiology, secondary diagnoses, and a death."
-- Cleaning/transformation: records were generated directly for this schema;
-- ids, references, dates, and query scenarios were reviewed for
-- consistency. No external patient data was imported or transformed.
-- Import method: from soen363_hospital/, execute
-- psql -v ON_ERROR_STOP=1 --single-transaction -d <database> -f soen363_sql_data.sql -f soen363_sample_data.sql.


-- Update prompt:
-- "Generate a complete PostgreSQL sample-data script for the exact schema in
-- soen363_sql_data.sql. Use only the tables and columns defined there; do not
-- add, rename, or omit columns. Output INSERT statements for every table in
-- soen363_sql_data.sql, in an order that satisfies all foreign keys. Use
-- explicit column lists and ensure every primary key is unique and every
-- foreign-key value refers to an inserted row.
--
-- Use entirely fictional hospital records. Do not use real people or real
-- patient information. Include at least one admission still marked Admitted 
-- and at least one Deceased admission. For every admission marked Completed,
-- Discharged, or Deceased, include at least
-- one Diagnosis_Record with diagnosis_type = 'Primary'.
--
-- Do not store diagnosis codes in Admission or
-- Discharge_Record. Represent unit transfers with multiple Unit_Stay rows for
-- the same admission and chronological entry/exit timestamps; this schema has
-- no previous-stay pointer. Ensure exit_date_time is null or no earlier than
-- entry_date_time, oxygen_saturation is between 0 and 100, pain_level is
-- between 0 and 10, and final_admission_status is one of Admitted, Completed,
-- Discharged, or Deceased. Use integer professional_id and unit_id references,
-- not professional names or unit types as foreign keys. Make the dataset more 
-- diverse and with more testability than the previous dataset.
--
-- Return executable PostgreSQL INSERT statements only, with no Markdown
-- fences. Use explicit NULL values where appropriate and ensure all
-- timestamps and clinical events are chronologically plausible."

INSERT INTO Healthcare_Professional (
    professional_id, full_name, role
) VALUES
(1, 'Dr. Mira Patel', 'Physician'),
(2, 'Dr. Jonah Reed', 'Physician'),
(3, 'Dr. Elena Roy', 'Physician'),
(4, 'Dr. Rowan Ellis', 'Physician'),
(5, 'Dr. Alex Chen', 'Physician'),
(6, 'Nurse Ren Lee', 'Nurse'),
(7, 'Nurse Kai Morgan', 'Nurse'),
(8, 'Tech Rowan Kim', 'Radiology Technician'),
(9, 'Tech Alex Noor', 'Radiology Technician');

INSERT INTO Hospital_Unit (
    unit_id, unit_type
) VALUES
(1, 'Emergency'),
(2, 'CCU'),
(3, 'MICU'),
(4, 'General Ward'),
(5, 'ICU'),
(6, 'Surgery'),
(7, 'SICU');

INSERT INTO Patient (
    patient_id, full_name, health_insurance_number, date_of_birth, gender, address, telephone_number, emergency_contact_info, life_status
) VALUES
(1, 'Ava Laurent', 710000001, '1968-04-12', 'Female', '101 Fictional Rue, Montreal, QC', '5145551001', 'Noah Laurent (spouse), 5145551101', 'Alive'),
(2, 'Noah Chen', 710000002, '1954-09-30', 'Male', '202 Sample Avenue, Laval, QC', '4505551002', 'Mei Chen (daughter), 4505551102', 'Alive'),
(3, 'Mia Haddad', 710000003, '1992-02-18', 'Female', '303 Example Street, Montreal, QC', '5145551003', 'Samir Haddad (brother), 5145551103', 'Alive'),
(4, 'Liam Roy', 710000004, '1941-11-05', 'Male', '404 Imaginary Road, Longueuil, QC', '4505551004', 'Claire Roy (daughter), 4505551104', 'Alive'),
(5, 'Emma Park', 710000005, '2001-07-22', 'Female', '505 Placeholder Lane, Brossard, QC', '4505551005', 'Jin Park (parent), 4505551105', 'Alive'),
(6, 'Oliver Nguyen', 710000006, '1960-01-09', 'Male', '606 Mock Boulevard, Montreal, QC', '5145551006', 'Linh Nguyen (spouse), 5145551106', 'Alive'),
(7, 'Zoe Martin', 710000007, '1947-06-14', 'Female', '707 Fictional Crescent, Laval, QC', '4505551007', 'Paul Martin (son), 4505551107', 'Deceased'),
(8, 'Ethan Tremblay', 710000008, '1958-12-01', 'Male', '808 Sample Court, Montreal, QC', '5145551008', 'Rose Tremblay (spouse), 5145551108', 'Alive'),
(9, 'Sofia Diallo', 710000009, '1983-03-27', 'Female', '909 Example Place, Westmount, QC', '5145551009', 'Aminata Diallo (sister), 5145551109', 'Alive'),
(10, 'Lucas Bouchard', 710000010, '1976-10-10', 'Male', '110 Imaginary Drive, Montreal, QC', '5145551010', 'Julie Bouchard (spouse), 5145551110', 'Alive'),
(11, 'Maya Wilson', 710000011, '1939-05-16', 'Female', '111 Placeholder Terrace, Laval, QC', '4505551011', 'Eli Wilson (son), 4505551111', 'Alive'),
(12, 'Jules Beaulieu', 710000012, '1998-08-03', 'Nonbinary', '112 Fictional Walk, Montreal, QC', '5145551012', 'Camille Beaulieu (friend), 5145551112', 'Alive');

INSERT INTO ICD9_Dictionary (
    icd_9_code, official_diagnosis_title, description, disease_category
) VALUES
('410.91', 'Acute myocardial infarction, unspecified', 'Acute heart attack, site unspecified', 'Circulatory'),
('428.0', 'Congestive heart failure, unspecified', 'Heart failure without further specification', 'Circulatory'),
('486', 'Pneumonia, organism unspecified', 'Pneumonia with no organism specified', 'Respiratory'),
('038.9', 'Unspecified septicemia', 'Systemic infection, organism unspecified', 'Infectious'),
('540.9', 'Acute appendicitis without mention of peritonitis', 'Acute inflammation of the appendix', 'Digestive'),
('820.8', 'Closed fracture of unspecified part of neck of femur', 'Closed fracture of the hip region', 'Injury'),
('493.90', 'Asthma, unspecified', 'Asthma without further specification', 'Respiratory'),
('434.91', 'Cerebral artery occlusion with infarction', 'Ischemic stroke', 'Circulatory'),
('491.21', 'Obstructive chronic bronchitis with exacerbation', 'COPD with acute exacerbation', 'Respiratory'),
('599.0', 'Urinary tract infection, site not specified', 'Urinary tract infection', 'Genitourinary'),
('414.01', 'Coronary atherosclerosis of native coronary artery', 'Coronary artery disease', 'Circulatory'),
('789.00', 'Abdominal pain, unspecified site', 'Abdominal pain without further specification', 'Symptoms'),
('518.81', 'Acute respiratory failure', 'Acute failure of respiratory function', 'Respiratory'),
('250.00', 'Diabetes mellitus without complication, type II or unspecified type', 'Type 2 diabetes without documented complication', 'Endocrine'),
('401.9', 'Essential hypertension, unspecified', 'High blood pressure without further specification', 'Circulatory');

INSERT INTO Admission (
    admission_id, patient_id, admission_date_time, reason_for_visit, admission_type, admission_source, insurance_info, patient_current_condition, admitting_healthcare_professional_id, final_admission_status
) VALUES
(1, 1, '2026-01-05 08:15', 'Severe chest pain', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Chest pain and diaphoresis', 1, 'Discharged'),
(2, 1, '2026-03-17 14:00', 'Worsening shortness of breath', 'Urgent', 'Family Doctor Referral', 'Fictional Plan A', 'Peripheral edema and dyspnea', 2, 'Discharged'),
(3, 1, '2026-05-02 09:00', 'Intermittent chest discomfort', 'Elective', 'Walk-in', 'Fictional Plan A', 'Stable, mild chest discomfort', 1, 'Discharged'),
(4, 1, '2026-08-01 10:00', 'Fever and productive cough', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Febrile with productive cough', 3, 'Discharged'),
(5, 2, '2026-02-01 09:30', 'Fever with low blood pressure', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Febrile and hypotensive', 2, 'Discharged'),
(6, 3, '2026-02-12 18:00', 'Right lower abdominal pain', 'Emergency', 'Emergency Department', 'Fictional Plan C', 'Abdominal pain and nausea', 3, 'Discharged'),
(7, 4, '2026-03-20 07:45', 'Fall with right hip pain', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Unable to bear weight', 1, 'Discharged'),
(8, 5, '2026-04-11 19:00', 'Wheezing and cough', 'Emergency', 'Walk-in', 'Fictional Plan C', 'Wheezing without hypoxemia', 3, 'Discharged'),
(9, 6, '2026-04-22 06:45', 'Sudden weakness and slurred speech', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Right-sided weakness and aphasia', 2, 'Discharged'),
(10, 7, '2026-05-04 03:20', 'Severe dyspnea and edema', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Acute pulmonary edema', 1, 'Deceased'),
(11, 8, '2026-05-22 10:00', 'Acute respiratory distress', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Low oxygen saturation; treatment ongoing', 3, 'Admitted'),
(12, 9, '2026-06-03 11:15', 'Painful urination and fever', 'Urgent', 'Family Doctor Referral', 'Fictional Plan C', 'Fever and flank tenderness', 2, 'Discharged'),
(13, 10, '2026-06-16 08:30', 'Acute coronary syndrome', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Chest pain with ischemic ECG changes', 1, 'Discharged'),
(14, 11, '2026-07-07 15:10', 'Fall with hip pain', 'Emergency', 'Ambulance', 'Fictional Plan B', 'Pain and reduced mobility', 3, 'Discharged'),
(15, 1, '2026-08-22 12:00', 'Fever and flank pain', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Flank pain and urinary symptoms', 2, 'Discharged'),
(16, 6, '2026-09-02 16:20', 'Right upper abdominal pain', 'Emergency', 'Walk-in', 'Fictional Plan A', 'Abdominal tenderness and nausea', 1, 'Discharged'),
(17, 2, '2026-09-18 08:00', 'Sepsis with respiratory distress', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Febrile with oxygen requirement', 2, 'Discharged');

-- Anais Note: based on the implementation of Query 1, triage priority uses the values Low, Medium, and High. 

INSERT INTO Triage_Assessment (
    assessment_id, admission_id, assessment_date_time, assessment_results, healthcare_professional_in_charge, blood_pressure, heart_rate, respiratory_rate, body_temperature, oxygen_saturation, pain_level, reported_symptoms, known_allergies, current_medications, triage_priority_level
) VALUES
(1, 1, '2026-01-05 08:25', 'Possible cardiac event', 6, '160/95', 102, 22, 36.8, 95.0, 8, 'Chest pain, sweating', 'None reported', 'Atorvastatin', 'High'),
(2, 2, '2026-03-17 14:10', 'Possible fluid overload', 6, '142/88', 96, 22, 37.1, 92.0, 3, 'Dyspnea, ankle swelling', 'None reported', 'Amlodipine', 'Medium'),
(3, 3, '2026-05-02 09:10', 'Stable cardiac symptoms', 7, '130/82', 78, 16, 36.7, 98.0, 2, 'Intermittent chest discomfort', 'None reported', 'Atorvastatin', 'Low'),
(4, 4, '2026-08-01 10:10', 'Respiratory infection suspected', 7, '128/78', 98, 21, 38.4, 93.0, 2, 'Fever, cough, fatigue', 'None reported', 'None', 'Medium'),
(5, 5, '2026-02-01 09:40', 'Sepsis alert', 6, '88/54', 124, 29, 39.2, 90.0, 5, 'Fever, chills, confusion', 'Sulfa drugs', 'Metformin', 'High'),
(6, 6, '2026-02-12 18:10', 'Surgical abdomen suspected', 7, '118/74', 96, 18, 37.8, 98.0, 8, 'Right lower quadrant pain, nausea', 'None reported', 'None', 'Medium'),
(7, 7, '2026-03-20 07:55', 'Probable hip fracture', 6, '148/86', 92, 20, 36.6, 96.0, 9, 'Hip pain after fall', 'Latex', 'Lisinopril', 'High'),
(8, 8, '2026-04-11 19:10', 'Asthma exacerbation', 7, '112/70', 108, 26, 37.0, 94.0, 3, 'Wheezing and cough', 'Peanuts', 'Rescue inhaler', 'Low'),
(9, 9, '2026-04-22 06:50', 'Stroke alert', 6, '176/98', 88, 18, 36.9, 96.0, 1, 'Facial droop, weakness, slurred speech', 'None reported', 'Aspirin', 'High'),
(10, 10, '2026-05-04 03:30', 'Acute heart failure', 7, '150/92', 120, 30, 36.4, 82.0, 4, 'Severe dyspnea, leg edema', 'Aspirin', 'Furosemide', 'High'),
(11, 11, '2026-05-22 10:10', 'Respiratory failure suspected', 6, '136/84', 112, 30, 37.2, 86.0, 2, 'Shortness of breath, fatigue', 'None reported', 'Tiotropium', 'High'),
(12, 12, '2026-06-03 11:25', 'Urinary infection suspected', 7, '122/78', 94, 18, 38.1, 98.0, 5, 'Dysuria, fever, flank pain', 'Penicillin', 'None', 'Low'),
(13, 13, '2026-06-16 08:40', 'Acute coronary syndrome', 6, '158/92', 106, 23, 36.8, 94.0, 7, 'Chest pressure, nausea', 'None reported', 'None', 'High'),
(14, 14, '2026-07-07 15:20', 'Possible fracture', 7, '144/82', 86, 18, 36.5, 97.0, 8, 'Hip pain after fall', 'None reported', 'Amlodipine', 'Medium'),
(15, 15, '2026-08-22 12:10', 'Possible kidney infection', 6, '124/76', 102, 20, 38.6, 97.0, 6, 'Flank pain, urinary frequency', 'None reported', 'Atorvastatin', 'Medium'),
(16, 16, '2026-09-02 16:30', 'Biliary disease suspected', 7, '132/80', 90, 18, 37.4, 98.0, 7, 'Right upper quadrant pain, nausea', 'None reported', 'Aspirin', 'Medium'),
(17, 17, '2026-09-18 08:10', 'Sepsis and respiratory distress', 6, '92/58', 118, 28, 39.0, 89.0, 3, 'Fever, chills, shortness of breath', 'Sulfa drugs', 'Metformin', 'High');

INSERT INTO Clinical_Note (
    clinical_note_id, admission_id, note_type, note_date_time, patients_symptoms, physical_examination, initial_clinical_findings, suspected_medical_condition, planned_diagnostic_examinations, initial_treatment_plan, note_content
) VALUES
(1, 1, 'Emergency Assessment', '2026-01-05 08:40', 'Chest pain for one hour', 'Diaphoretic, tachycardic', 'Ischemic ECG changes', 'Acute myocardial infarction', 'ECG, troponin, chest X-ray', 'Aspirin, anticoagulation, cardiology review', 'Fictional patient admitted for acute cardiac assessment.'),
(2, 2, 'Emergency Assessment', '2026-03-17 14:25', 'Dyspnea and ankle swelling', 'Bibasilar crackles, peripheral edema', 'Elevated cardiac markers suspected', 'Congestive heart failure', 'Chest X-ray, echocardiogram', 'Oxygen, diuretic, monitored admission', 'Symptoms improved after initial diuresis.'),
(3, 3, 'Emergency Assessment', '2026-05-02 09:25', 'Intermittent chest discomfort', 'Comfortable at rest', 'No acute ECG change', 'Coronary artery disease', 'ECG, serial cardiac enzymes', 'Observation and medication review', 'Stable for observation and subsequent discharge.'),
(4, 4, 'Emergency Assessment', '2026-08-01 10:25', 'Fever and productive cough', 'Crackles at right lung base', 'Fever and mild hypoxemia', 'Pneumonia', 'Chest X-ray, blood tests', 'Oxygen as needed, antibiotics', 'Respiratory symptoms monitored during admission.'),
(5, 5, 'Emergency Assessment', '2026-02-01 09:55', 'Fever, chills, confusion', 'Hypotension and tachycardia', 'Sepsis with poor perfusion', 'Sepsis', 'Blood cultures, chest X-ray, lactate', 'IV fluids, antibiotics, critical care', 'Transferred to medical intensive care for close monitoring.'),
(6, 6, 'Emergency Assessment', '2026-02-12 18:25', 'Right lower abdominal pain', 'Rebound tenderness', 'Elevated white cell count', 'Acute appendicitis', 'Abdominal CT, blood tests', 'NPO, IV fluids, surgical consultation', 'Surgical team reviewed the fictional case.'),
(7, 7, 'Emergency Assessment', '2026-03-20 08:10', 'Hip pain after fall', 'Shortened, externally rotated leg', 'Imaging consistent with fracture', 'Femoral neck fracture', 'Hip X-ray, preoperative assessment', 'Analgesia and orthopedic consultation', 'Operative repair planned after stabilization.'),
(8, 8, 'Emergency Assessment', '2026-04-11 19:25', 'Wheezing and cough', 'Diffuse expiratory wheezes', 'Reduced peak flow', 'Asthma exacerbation', 'Peak flow and chest X-ray', 'Nebulized bronchodilator and steroids', 'Breathing improved after treatment.'),
(9, 9, 'Emergency Assessment', '2026-04-22 07:00', 'Weakness and slurred speech', 'Right-sided weakness, aphasia', 'Acute stroke symptoms', 'Cerebral artery occlusion with infarction', 'Head CT, brain MRI', 'Stroke protocol and specialist review', 'Admitted for stroke treatment and monitoring.'),
(10, 10, 'Emergency Assessment', '2026-05-04 03:45', 'Severe dyspnea', 'Bilateral crackles, leg edema', 'Pulmonary edema and hypoxemia', 'Congestive heart failure', 'Chest X-ray, ECG, cardiac markers', 'Oxygen, IV diuretic, critical care', 'Condition deteriorated despite resuscitative treatment.'),
(11, 11, 'Emergency Assessment', '2026-05-22 10:25', 'Shortness of breath', 'Increased work of breathing', 'Hypoxemia', 'Acute respiratory failure', 'Chest X-ray, blood gas', 'Oxygen and respiratory support', 'Treatment remains in progress.'),
(12, 12, 'Emergency Assessment', '2026-06-03 11:40', 'Dysuria, fever, flank pain', 'Flank tenderness', 'Urinalysis suggests infection', 'Urinary tract infection', 'Urine culture, renal ultrasound', 'Fluids and antibiotics', 'Admitted for treatment of urinary infection.'),
(13, 13, 'Emergency Assessment', '2026-06-16 08:55', 'Chest pressure and nausea', 'Pale, mildly diaphoretic', 'Ischemic ECG changes', 'Acute myocardial infarction', 'ECG, troponin, chest X-ray', 'Urgent cardiac intervention', 'Cardiology team accepted the patient for treatment.'),
(14, 14, 'Emergency Assessment', '2026-07-07 15:35', 'Hip pain after fall', 'Pain with movement', 'Closed fracture on X-ray', 'Femoral neck fracture', 'Hip X-ray, blood tests', 'Analgesia and orthopedic consultation', 'Admitted for fracture repair and recovery.'),
(15, 15, 'Emergency Assessment', '2026-08-22 12:25', 'Fever and flank pain', 'Costovertebral angle tenderness', 'Urinalysis positive for infection', 'Urinary tract infection', 'Urine culture, blood tests', 'Antibiotics and hydration', 'Observed until symptoms improved.'),
(16, 16, 'Emergency Assessment', '2026-09-02 16:45', 'Right upper abdominal pain', 'Right upper quadrant tenderness', 'Ultrasound suggests gallbladder inflammation', 'Abdominal pain', 'Abdominal ultrasound, blood tests', 'IV fluids and surgical review', 'Further evaluation supported operative treatment.'),
(17, 17, 'Emergency Assessment', '2026-09-18 08:25', 'Fever and shortness of breath', 'Hypotension, increased work of breathing', 'Sepsis with respiratory compromise', 'Sepsis', 'Blood cultures, chest X-ray, lactate', 'IV fluids, antibiotics, critical care', 'Transferred for critical care and ongoing treatment.'),
(18, 1, 'Discharge Summary', '2026-01-09 10:45', 'Chest pain resolved', 'Comfortable and ambulatory', 'Cardiac status stable', 'Acute myocardial infarction', 'Outpatient cardiac follow-up', 'Continue prescribed cardiac medications', 'Recovery was uncomplicated; discharged home with cardiac follow-up.'),
(19, 5, 'Discharge Summary', '2026-02-12 14:15', 'Fever resolved', 'Stable vital signs', 'Infection responding to treatment', 'Sepsis', 'Follow-up blood tests', 'Complete prescribed antibiotic course', 'Recovery progressing; discharged home with follow-up instructions.'),
(20, 6, 'Discharge Summary', '2026-02-15 08:45', 'Abdominal pain resolved', 'Incision clean and dry', 'Postoperative status stable', 'Acute appendicitis', 'Surgical clinic follow-up', 'Activity restrictions reviewed', 'Recovery satisfactory following appendectomy.'),
(21, 7, 'Discharge Summary', '2026-03-28 08:45', 'Hip pain controlled', 'Mobilizing with assistance', 'Postoperative status stable', 'Femoral neck fracture', 'Orthopedic follow-up', 'Continue rehabilitation and medications', 'Recovery continues at the rehabilitation facility.'),
(22, 10, 'Discharge Summary', '2026-05-07 05:45', 'Severe respiratory distress', 'No response to resuscitation', 'Death during admission', 'Congestive heart failure', 'No further examination', 'Resuscitation unsuccessful', 'Patient died during the hospital stay.'),
(23, 13, 'Discharge Summary', '2026-06-19 10:45', 'Chest discomfort resolved', 'Stable after procedure', 'Cardiac status improved', 'Acute myocardial infarction', 'Cardiology clinic follow-up', 'Continue prescribed medications', 'Recovery stable after cardiac intervention.'),
(24, 14, 'Discharge Summary', '2026-07-12 09:45', 'Hip pain improved', 'Mobilizing with walker', 'Fracture repair stable', 'Femoral neck fracture', 'Orthopedic clinic follow-up', 'Continue physiotherapy', 'Recovery progressing at home.'),
(25, 17, 'Discharge Summary', '2026-09-28 09:45', 'Breathing improved', 'Stable on room air', 'Infection resolving', 'Sepsis', 'Family physician follow-up', 'Complete medications and return if symptoms recur', 'Recovery was stable at discharge.');

INSERT INTO Diagnostic_Order (
    diagnostic_order_id, admission_id, requesting_physician, requested_examination, request_date_time, clinical_reason_for_examination, priority, order_status
) VALUES
(1, 1, 1, 'Chest X-ray', '2026-01-05 08:45', 'Assess chest pain', 'Urgent', 'Completed'),
(2, 2, 2, 'Echocardiogram', '2026-03-17 14:30', 'Assess cardiac function', 'High', 'Completed'),
(3, 3, 1, 'Chest X-ray', '2026-05-02 09:30', 'Evaluate chest discomfort', 'Routine', 'Completed'),
(4, 4, 3, 'Chest X-ray', '2026-08-01 10:30', 'Assess suspected pneumonia', 'High', 'Completed'),
(5, 5, 2, 'Chest X-ray', '2026-02-01 10:00', 'Assess infection source', 'Urgent', 'Completed'),
(6, 6, 3, 'Abdominal CT', '2026-02-12 18:30', 'Assess suspected appendicitis', 'Urgent', 'Completed'),
(7, 7, 1, 'Right hip X-ray', '2026-03-20 08:15', 'Assess fall injury', 'Urgent', 'Completed'),
(8, 8, 3, 'Chest X-ray', '2026-04-11 19:30', 'Assess respiratory symptoms', 'Routine', 'Completed'),
(9, 9, 2, 'Head CT', '2026-04-22 07:05', 'Stroke evaluation', 'Urgent', 'Completed'),
(10, 10, 1, 'Chest X-ray', '2026-05-04 03:50', 'Assess pulmonary edema', 'Urgent', 'Completed'),
(11, 11, 3, 'Chest X-ray', '2026-05-22 10:30', 'Assess respiratory failure', 'Urgent', 'In Progress'),
(12, 12, 2, 'Renal ultrasound', '2026-06-03 11:45', 'Rule out urinary obstruction', 'High', 'Completed'),
(13, 13, 1, 'Chest X-ray', '2026-06-16 09:00', 'Assess chest pain', 'Urgent', 'Completed'),
(14, 14, 3, 'Left hip X-ray', '2026-07-07 15:40', 'Assess fall injury', 'High', 'Completed'),
(15, 15, 2, 'Renal ultrasound', '2026-08-22 12:30', 'Assess flank pain', 'High', 'Completed'),
(16, 16, 1, 'Abdominal ultrasound', '2026-09-02 16:50', 'Assess right upper quadrant pain', 'High', 'Completed'),
(17, 17, 2, 'Chest X-ray', '2026-09-18 08:30', 'Assess respiratory compromise', 'Urgent', 'Completed');


INSERT INTO Radiology_Report (
    examination_id, diagnostic_order_id, examination_type, examination_date_time, body_area_examined, referring_physician, radiology_technician, examination_status, medical_images_link, findings, interpretation, conclusion
) VALUES
(1, 1, 'X-ray', '2026-01-05 09:05', 'Chest', 1, 8, 'Completed', 'https://example.org/synthetic-images/exam-1', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(2, 2, 'Ultrasound', '2026-03-17 15:00', 'Heart', 2, 9, 'Completed', 'https://example.org/synthetic-images/exam-2', 'Ultrasound examination of Heart; synthetic findings documented.', 'Images reviewed for the requested heart assessment.', 'See findings and interpretation; fictional educational record.'),
(3, 3, 'X-ray', '2026-05-02 10:00', 'Chest', 1, 8, 'Completed', 'https://example.org/synthetic-images/exam-3', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(4, 4, 'X-ray', '2026-08-01 11:00', 'Chest', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-4', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(5, 5, 'X-ray', '2026-02-01 10:20', 'Chest', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-5', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(6, 6, 'CT', '2026-02-12 19:10', 'Abdomen', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-6', 'CT examination of Abdomen; synthetic findings documented.', 'Images reviewed for the requested abdomen assessment.', 'See findings and interpretation; fictional educational record.'),
(7, 7, 'X-ray', '2026-03-20 08:40', 'Right hip', 1, 8, 'Completed', 'https://example.org/synthetic-images/exam-7', 'X-ray examination of Right hip; synthetic findings documented.', 'Images reviewed for the requested right hip assessment.', 'See findings and interpretation; fictional educational record.'),
(8, 8, 'X-ray', '2026-04-11 20:00', 'Chest', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-8', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(9, 9, 'CT', '2026-04-22 07:20', 'Head', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-9', 'CT examination of Head; synthetic findings documented.', 'Images reviewed for the requested head assessment.', 'See findings and interpretation; fictional educational record.'),
(10, 10, 'X-ray', '2026-05-04 04:05', 'Chest', 1, 9, 'Completed', 'https://example.org/synthetic-images/exam-10', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(11, 11, 'X-ray', '2026-05-22 10:55', 'Chest', 3, 8, 'In Progress', NULL, 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(12, 12, 'Ultrasound', '2026-06-03 12:20', 'Kidneys', 2, 9, 'Completed', 'https://example.org/synthetic-images/exam-12', 'Ultrasound examination of Kidneys; synthetic findings documented.', 'Images reviewed for the requested kidneys assessment.', 'See findings and interpretation; fictional educational record.'),
(13, 13, 'X-ray', '2026-06-16 09:20', 'Chest', 1, 8, 'Completed', 'https://example.org/synthetic-images/exam-13', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(14, 14, 'X-ray', '2026-07-07 16:00', 'Left hip', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-14', 'X-ray examination of Left hip; synthetic findings documented.', 'Images reviewed for the requested left hip assessment.', 'See findings and interpretation; fictional educational record.'),
(15, 15, 'Ultrasound', '2026-08-22 13:00', 'Kidneys', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-15', 'Ultrasound examination of Kidneys; synthetic findings documented.', 'Images reviewed for the requested kidneys assessment.', 'See findings and interpretation; fictional educational record.'),
(16, 16, 'Ultrasound', '2026-09-02 17:20', 'Abdomen', 1, 9, 'Completed', 'https://example.org/synthetic-images/exam-16', 'Ultrasound examination of Abdomen; synthetic findings documented.', 'Images reviewed for the requested abdomen assessment.', 'See findings and interpretation; fictional educational record.'),
(17, 17, 'X-ray', '2026-09-18 09:00', 'Chest', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-17', 'X-ray examination of Chest; synthetic findings documented.', 'Images reviewed for the requested chest assessment.', 'See findings and interpretation; fictional educational record.'),
(18, 1, 'X-ray', '2026-01-05 09:10', 'Chest', 1, 9, 'Completed', 'https://example.org/synthetic-images/exam-18', 'Additional chest views; synthetic findings documented.', 'Additional views reviewed for the requested chest assessment.', 'Additional views included in the same ordered examination.');

INSERT INTO Diagnosis_Record (
    diagnosis_id, admission_id, icd_9_code, diagnosis_date_time, diagnosis_type, diagnosing_physician
) VALUES
(1, 1, '410.91', '2026-01-05 09:30', 'Primary', 1),
(2, 1, '401.9', '2026-01-05 10:00', 'Secondary', 1),
(3, 2, '428.0', '2026-03-17 16:00', 'Primary', 2),
(4, 2, '401.9', '2026-03-17 16:15', 'Secondary', 2),
(5, 3, '414.01', '2026-05-02 11:00', 'Primary', 1),
(6, 4, '486', '2026-08-01 12:00', 'Primary', 3),
(7, 5, '038.9', '2026-02-01 11:00', 'Primary', 2),
(8, 5, '250.00', '2026-02-01 11:15', 'Secondary', 2),
(9, 6, '540.9', '2026-02-12 20:00', 'Primary', 3),
(10, 7, '820.8', '2026-03-20 09:00', 'Primary', 1),
(11, 7, '401.9', '2026-03-20 09:15', 'Secondary', 1),
(12, 8, '493.90', '2026-04-11 20:30', 'Primary', 3),
(13, 9, '434.91', '2026-04-22 08:00', 'Primary', 2),
(14, 10, '428.0', '2026-05-04 04:30', 'Primary', 1),
(15, 10, '401.9', '2026-05-04 04:45', 'Secondary', 1),
(16, 11, '518.81', '2026-05-22 11:30', 'Primary', 3),
(17, 12, '599.0', '2026-06-03 13:00', 'Primary', 2),
(18, 13, '410.91', '2026-06-16 10:00', 'Primary', 1),
(19, 13, '414.01', '2026-06-16 10:15', 'Secondary', 1),
(20, 14, '820.8', '2026-07-07 16:30', 'Primary', 3),
(21, 15, '599.0', '2026-08-22 13:30', 'Primary', 2),
(22, 16, '789.00', '2026-09-02 18:00', 'Primary', 1),
(23, 16, '401.9', '2026-09-02 18:15', 'Secondary', 1),
(24, 17, '038.9', '2026-09-18 10:00', 'Primary', 2),
(25, 17, '518.81', '2026-09-18 10:15', 'Secondary', 2);


INSERT INTO Surgical_Procedure (
    surgical_procedure_id, admission_id, procedure_type, procedure_date_time, performing_surgeon, procedure_status, procedure_notes
) VALUES
(1, 1, 'Percutaneous coronary intervention', '2026-01-05 13:00', 4, 'Completed', 'Fictional coronary stent placement; stable afterward.'),
(2, 6, 'Laparoscopic appendectomy', '2026-02-12 22:00', 5, 'Completed', 'Uncomplicated fictional appendectomy.'),
(3, 7, 'Hip hemiarthroplasty', '2026-03-20 10:00', 4, 'Completed', 'Right hip repair under spinal anesthesia.'),
(4, 13, 'Percutaneous coronary intervention', '2026-06-16 11:00', 5, 'Completed', 'Fictional coronary intervention with stable result.'),
(5, 14, 'Hip hemiarthroplasty', '2026-07-08 09:00', 4, 'Completed', 'Left hip repair; transferred to general ward.'),
(6, 16, 'Laparoscopic cholecystectomy', '2026-09-03 10:00', 5, 'Completed', 'Uncomplicated fictional gallbladder removal.');

INSERT INTO Unit_Stay (
    unit_stay_id, admission_id, unit_id, ward_and_room, bed_number, entry_date_time, exit_date_time, responsible_physician, reason_for_transfer
) VALUES
(1, 1, 1, 'ER-A / Room 3', '3', '2026-01-05 08:15', '2026-01-05 10:00', 1, 'Initial emergency assessment'),
(2, 1, 2, 'CCU / Room 2', '2', '2026-01-05 10:30', '2026-01-07 10:30', 4, 'Post-intervention cardiac monitoring'),
(3, 1, 4, 'Ward 4A / Room 8', '8A', '2026-01-07 11:00', '2026-01-09 10:30', 1, 'Stable for step-down care'),
(4, 2, 1, 'ER-B / Room 1', '1', '2026-03-17 14:00', '2026-03-17 16:00', 2, 'Initial assessment'),
(5, 2, 3, 'MICU / Room 1', '1', '2026-03-17 16:30', '2026-03-19 12:00', 2, 'Cardiac monitoring and diuresis'),
(6, 2, 4, 'Ward 3B / Room 4', '4B', '2026-03-19 12:30', '2026-03-22 09:00', 2, 'Improving after treatment'),
(7, 3, 1, 'ER-A / Room 4', '4', '2026-05-02 09:00', '2026-05-02 11:00', 1, 'Initial assessment'),
(8, 3, 4, 'Ward 2A / Room 6', '6A', '2026-05-02 11:30', '2026-05-04 08:30', 1, 'Observation and medication review'),
(9, 4, 1, 'ER-B / Room 2', '2', '2026-08-01 10:00', '2026-08-01 12:00', 3, 'Initial assessment'),
(10, 4, 4, 'Ward 3A / Room 9', '9A', '2026-08-01 12:30', '2026-08-04 11:00', 3, 'Antibiotic treatment'),
(11, 5, 1, 'ER-A / Room 1', '1', '2026-02-01 09:30', '2026-02-01 10:30', 2, 'Sepsis protocol initiated'),
(12, 5, 5, 'ICU / Room 2', '2', '2026-02-01 11:00', '2026-02-10 11:00', 2, 'Critical care for sepsis'),
(13, 5, 4, 'Ward 4B / Room 5', '5B', '2026-02-10 12:00', '2026-02-12 14:00', 2, 'Stable for step-down care'),
(14, 6, 1, 'ER-A / Room 5', '5', '2026-02-12 18:00', '2026-02-12 20:00', 3, 'Initial surgical assessment'),
(15, 6, 6, 'OR 2', '2', '2026-02-12 21:30', '2026-02-13 00:30', 5, 'Appendectomy'),
(16, 6, 4, 'Ward 2C / Room 3', '3C', '2026-02-13 01:00', '2026-02-15 08:30', 5, 'Postoperative recovery'),
(17, 7, 1, 'ER-B / Room 3', '3', '2026-03-20 07:45', '2026-03-20 09:00', 1, 'Fracture stabilization'),
(18, 7, 6, 'OR 1', '1', '2026-03-20 09:30', '2026-03-20 12:00', 4, 'Hip repair'),
(19, 7, 7, 'SICU / Room 1', '1', '2026-03-20 12:30', '2026-03-21 10:00', 4, 'Immediate postoperative monitoring'),
(20, 7, 5, 'ICU / Room 2', '2', '2026-03-21 10:30', '2026-03-24 10:00', 4, 'Ongoing critical care'),
(21, 7, 4, 'Ward 5A / Room 6', '6A', '2026-03-24 10:30', '2026-03-28 08:30', 4, 'Rehabilitation and mobility support'),
(22, 8, 1, 'ER-A / Room 2', '2', '2026-04-11 19:00', '2026-04-11 21:00', 3, 'Initial respiratory assessment'),
(23, 8, 4, 'Ward 3C / Room 7', '7C', '2026-04-11 21:30', '2026-04-11 22:30', 3, 'Observation after bronchodilator'),
(24, 9, 1, 'ER-A / Room 1', '1', '2026-04-22 06:45', '2026-04-22 08:30', 2, 'Stroke protocol'),
(25, 9, 5, 'ICU / Room 3', '3', '2026-04-22 09:00', '2026-04-25 09:00', 2, 'Post-stroke monitoring'),
(26, 9, 4, 'Ward 4A / Room 2', '2A', '2026-04-25 09:30', '2026-04-30 09:00', 2, 'Neurologic rehabilitation'),
(27, 10, 1, 'ER-B / Room 4', '4', '2026-05-04 03:20', '2026-05-04 04:00', 1, 'Resuscitation and stabilization'),
(28, 10, 2, 'CCU / Room 1', '1', '2026-05-04 04:30', '2026-05-07 05:30', 1, 'Critical cardiac care'),
(29, 11, 1, 'ER-B / Room 5', '5', '2026-05-22 10:00', '2026-05-22 11:00', 3, 'Respiratory stabilization'),
(30, 11, 5, 'ICU / Room 4', '4', '2026-05-22 11:30', '2026-05-23 10:00', 3, 'Respiratory support'),
(31, 11, 4, 'Ward 3A / Room 1', '1A', '2026-05-23 10:30', NULL, 3, 'Ongoing treatment'),
(32, 12, 1, 'ER-A / Room 6', '6', '2026-06-03 11:15', '2026-06-03 13:00', 2, 'Initial assessment'),
(33, 12, 4, 'Ward 2B / Room 8', '8B', '2026-06-03 13:30', '2026-06-06 10:00', 2, 'Antibiotic treatment'),
(34, 13, 1, 'ER-B / Room 1', '1', '2026-06-16 08:30', '2026-06-16 10:30', 1, 'Cardiac assessment'),
(35, 13, 2, 'CCU / Room 3', '3', '2026-06-16 12:00', '2026-06-18 10:00', 4, 'Post-intervention monitoring'),
(36, 14, 1, 'ER-A / Room 3', '3', '2026-07-07 15:10', '2026-07-07 17:00', 3, 'Fracture assessment'),
(37, 14, 4, 'Ward 5B / Room 4', '4B', '2026-07-07 17:30', '2026-07-12 09:00', 4, 'Postoperative recovery'),
(38, 15, 1, 'ER-B / Room 2', '2', '2026-08-22 12:00', '2026-08-22 14:00', 2, 'Initial assessment'),
(39, 15, 4, 'Ward 3B / Room 9', '9B', '2026-08-22 14:30', '2026-08-25 09:00', 2, 'Hydration and antibiotic treatment'),
(40, 16, 1, 'ER-A / Room 4', '4', '2026-09-02 16:20', '2026-09-02 18:30', 1, 'Initial abdominal assessment'),
(41, 16, 6, 'OR 3', '3', '2026-09-03 09:00', '2026-09-03 11:30', 5, 'Cholecystectomy'),
(42, 16, 4, 'Ward 2A / Room 7', '7A', '2026-09-03 12:00', '2026-09-06 09:00', 5, 'Postoperative recovery'),
(43, 17, 1, 'ER-B / Room 6', '6', '2026-09-18 08:00', '2026-09-18 09:30', 2, 'Sepsis protocol'),
(44, 17, 3, 'MICU / Room 3', '3', '2026-09-18 10:00', '2026-09-25 10:00', 2, 'Critical care for sepsis'),
(45, 17, 4, 'Ward 4C / Room 2', '2C', '2026-09-25 10:30', '2026-09-28 09:00', 2, 'Stable for step-down care');

INSERT INTO General_Ward (
    progress_note_id, unit_stay_id, nursing_monitoring_notes, physician_follow_up_examination, medications_and_treatments_administered, progress_notes, additional_tests_requested, recovery_evaluation
) VALUES
(1, 3, 'Vitals stable every four hours', 'Cardiology review completed', 'Cardiac medications continued', 'Ambulating without chest pain', 'None', 'Good recovery'),
(2, 6, 'Daily weight and oxygen checks', 'Edema reduced on examination', 'Diuretic therapy continued', 'Breathing improved', 'Repeat echocardiogram arranged', 'Recovering well'),
(3, 8, 'Routine observations', 'No acute cardiac findings', 'Home medications reviewed', 'No recurrent symptoms', 'None', 'Stable for discharge'),
(4, 10, 'Temperature monitored', 'Lung exam improving', 'Antibiotics and fluids', 'Cough reduced', 'None', 'Recovering from infection'),
(5, 13, 'Vitals stable', 'Infection resolving', 'Antibiotics continued', 'Eating and mobilizing', 'Follow-up blood tests', 'Recovered sufficiently for discharge'),
(6, 16, 'Pain and wound checks', 'Incision clean and dry', 'Analgesics as needed', 'Tolerating meals', 'None', 'Good postoperative recovery'),
(7, 21, 'Mobility assistance provided', 'Orthopedic review completed', 'Analgesia and thrombosis prevention', 'Walking with support', 'Physiotherapy assessment', 'Progressing with rehabilitation'),
(8, 23, 'Respiratory observations', 'Wheezing improved', 'Inhaled bronchodilator', 'No oxygen required', 'None', 'Stable for discharge'),
(9, 26, 'Neurologic checks continued', 'Weakness improving', 'Stroke medications continued', 'Participating in therapy', 'Rehabilitation review', 'Recovering with mild residual weakness'),
(10, 31, 'Continuous monitoring', 'Respiratory plan reviewed', 'Oxygen and inhaled therapy', 'Treatment remains in progress', 'Repeat chest imaging pending', 'Ongoing care'),
(11, 33, 'Temperature and intake monitored', 'Flank tenderness reduced', 'Antibiotics and fluids', 'Urinary symptoms resolved', 'Culture review completed', 'Recovered'),
(12, 37, 'Pain controlled', 'Postoperative hip review', 'Analgesia and physiotherapy', 'Mobilizing with walker', 'Follow-up imaging arranged', 'Progressing with recovery'),
(13, 39, 'Urine output monitored', 'Symptoms improved', 'Antibiotics and hydration', 'Afebrile before discharge', 'None', 'Recovered'),
(14, 42, 'Wound checks continued', 'Abdominal tenderness resolved', 'Analgesia and fluids', 'Tolerating regular diet', 'None', 'Good recovery'),
(15, 45, 'Vitals stable', 'Infection responding to treatment', 'Antibiotics completed', 'Breathing comfortably', 'None', 'Recovered sufficiently for discharge');

INSERT INTO Discharge_Record (
    discharge_record_id, admission_id, discharge_date_time, discharge_destination, patients_condition_at_discharge, prescribed_medications, follow_up_instructions, scheduled_follow_up_appointments, responsible_physician
) VALUES
(1, 1, '2026-01-09 11:00', 'Home', 'Stable, chest pain resolved', 'Aspirin, atorvastatin, beta blocker', 'Cardiac rehabilitation and low-sodium diet', '2026-01-23 10:00 Cardiology clinic', 1),
(2, 2, '2026-03-22 10:00', 'Home', 'Breathing improved, edema reduced', 'Diuretic and cardiac medications', 'Daily weights and medication review', '2026-04-05 09:00 Cardiology clinic', 2),
(3, 3, '2026-05-04 09:00', 'Home', 'Stable without recurrent symptoms', 'Continue home cardiac medications', 'Return if chest pain recurs', '2026-05-18 11:00 Family physician', 1),
(4, 4, '2026-08-04 12:00', 'Home', 'Afebrile, breathing comfortably', 'Oral antibiotics', 'Complete medication course and rest', '2026-08-11 10:00 Family physician', 3),
(5, 5, '2026-02-12 15:00', 'Home', 'Infection improved, stable vital signs', 'Complete antibiotic course', 'Hydration and return if fever recurs', '2026-02-19 10:30 Family physician', 2),
(6, 6, '2026-02-15 09:00', 'Home', 'Pain controlled after surgery', 'Acetaminophen as needed', 'Avoid strenuous activity for two weeks', '2026-03-01 09:00 Surgery clinic', 5),
(7, 7, '2026-03-28 09:00', 'Rehabilitation Center', 'Stable, mobilizing with assistance', 'Analgesia and thrombosis prevention', 'Continue daily physiotherapy', '2026-04-04 13:00 Orthopedic clinic', 4),
(8, 8, '2026-04-11 23:00', 'Home', 'Wheezing resolved', 'Rescue inhaler and short steroid course', 'Avoid known triggers', '2026-04-25 14:00 Family physician', 3),
(9, 9, '2026-04-30 10:00', 'Rehabilitation Center', 'Improved with mild weakness', 'Antiplatelet and cholesterol medication', 'Continue speech and physical therapy', '2026-05-07 13:00 Neurology clinic', 2),
(10, 10, '2026-05-07 06:00', 'Deceased', 'Deceased during the hospital stay', NULL, NULL, NULL, 1),
(11, 12, '2026-06-06 11:00', 'Home', 'Afebrile, urinary symptoms resolved', 'Oral antibiotics', 'Increase fluid intake', '2026-06-20 10:00 Family physician', 2),
(12, 13, '2026-06-19 11:00', 'Home', 'Stable following cardiac intervention', 'Aspirin and cardiac medications', 'Cardiac rehabilitation and medication review', '2026-07-03 09:00 Cardiology clinic', 1),
(13, 14, '2026-07-12 10:00', 'Home', 'Stable, mobilizing with walker', 'Analgesia as needed', 'Continue physiotherapy', '2026-07-26 10:00 Orthopedic clinic', 4),
(14, 15, '2026-08-25 10:00', 'Home', 'Afebrile, flank pain resolved', 'Oral antibiotics', 'Complete treatment and maintain hydration', '2026-09-08 10:00 Family physician', 2),
(15, 16, '2026-09-06 10:00', 'Home', 'Pain resolved after surgery', 'Acetaminophen as needed', 'Follow postoperative instructions', '2026-09-20 10:00 Surgery clinic', 5),
(16, 17, '2026-09-28 10:00', 'Home', 'Stable, breathing comfortably', 'Complete prescribed antibiotic course', 'Return if fever or breathing difficulty recurs', '2026-10-05 09:30 Family physician', 2);

-- Additional fictional records to provide broader query coverage.
INSERT INTO Patient (
    patient_id, full_name, health_insurance_number, date_of_birth, gender,
    address, telephone_number, emergency_contact_info, life_status
) VALUES
(13, 'Riley Laurent', 710000013, '1972-02-11', 'Female', '13 Sample Road, Montreal, QC', '5145551013', 'Alex Laurent, 5145551113', 'Alive'),
(14, 'Morgan Chen', 710000014, '1988-06-24', 'Male', '14 Fictional Avenue, Laval, QC', '4505551014', 'Jamie Chen, 4505551114', 'Alive'),
(15, 'Casey Haddad', 710000015, '1965-10-08', 'Nonbinary', '15 Example Street, Montreal, QC', '5145551015', 'Rana Haddad, 5145551115', 'Alive'),
(16, 'Jordan Roy', 710000016, '1959-03-19', 'Female', '16 Imaginary Road, Longueuil, QC', '4505551016', 'Taylor Roy, 4505551116', 'Alive'),
(17, 'Avery Park', 710000017, '1948-12-02', 'Male', '17 Placeholder Lane, Brossard, QC', '4505551017', 'Min Park, 4505551117', 'Deceased'),
(18, 'Quinn Nguyen', 710000018, '1990-07-13', 'Female', '18 Mock Boulevard, Montreal, QC', '5145551018', 'Linh Nguyen, 5145551118', 'Alive'),
(19, 'Taylor Martin', 710000019, '1978-01-26', 'Male', '19 Fictional Crescent, Laval, QC', '4505551019', 'Robin Martin, 4505551119', 'Alive'),
(20, 'Sky Tremblay', 710000020, '2003-09-05', 'Female', '20 Sample Court, Montreal, QC', '5145551020', 'Rose Tremblay, 5145551120', 'Alive'),
(21, 'Drew Diallo', 710000021, '1952-04-17', 'Male', '21 Example Place, Westmount, QC', '5145551021', 'Aminata Diallo, 5145551121', 'Alive'),
(22, 'Reese Bouchard', 710000022, '1985-11-29', 'Female', '22 Imaginary Drive, Montreal, QC', '5145551022', 'Julie Bouchard, 5145551122', 'Alive'),
(23, 'Finley Wilson', 710000023, '1996-05-03', 'Nonbinary', '23 Placeholder Terrace, Laval, QC', '4505551023', 'Eli Wilson, 4505551123', 'Alive'),
(24, 'Emery Beaulieu', 710000024, '2000-08-21', 'Male', '24 Fictional Walk, Montreal, QC', '5145551024', 'Camille Beaulieu, 5145551124', 'Alive');

INSERT INTO Admission (
    admission_id, patient_id, admission_date_time, reason_for_visit, admission_type,
    admission_source, insurance_info, patient_current_condition,
    admitting_healthcare_professional_id, final_admission_status
) VALUES
(18, 13, '2026-10-01 07:30', 'Fall with wrist pain', 'Emergency', 'Ambulance', 'Fictional Plan D', 'Wrist pain and swelling', 3, 'Discharged'),
(19, 13, '2026-10-10 09:00', 'Fever and cough', 'Urgent', 'Walk-in', 'Fictional Plan D', 'Fever and productive cough', 2, 'Discharged'),
(20, 14, '2026-10-02 11:15', 'Chest pressure', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Chest pressure with nausea', 1, 'Discharged'),
(21, 15, '2026-10-03 08:20', 'Abdominal pain', 'Emergency', 'Walk-in', 'Fictional Plan C', 'Right lower quadrant tenderness', 3, 'Completed'),
(22, 16, '2026-10-04 14:10', 'Wheezing', 'Urgent', 'Family Doctor Referral', 'Fictional Plan A', 'Mild respiratory distress', 3, 'Discharged'),
(23, 17, '2026-10-05 02:40', 'Sepsis and hypotension', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Septic shock with poor perfusion', 2, 'Deceased'),
(24, 18, '2026-10-06 10:00', 'Sudden weakness', 'Emergency', 'Ambulance', 'Fictional Plan D', 'Right-sided weakness', 2, 'Discharged'),
(25, 19, '2026-10-07 16:30', 'High blood glucose', 'Urgent', 'Family Doctor Referral', 'Fictional Plan C', 'Hyperglycemia under evaluation', 1, 'Admitted'),
(26, 20, '2026-10-08 06:50', 'Right lower abdominal pain', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Abdominal tenderness and nausea', 3, 'Discharged'),
(27, 21, '2026-10-09 12:05', 'Shortness of breath', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Low oxygen saturation', 2, 'Discharged'),
(28, 22, '2026-10-11 09:45', 'Fever and urinary symptoms', 'Urgent', 'Walk-in', 'Fictional Plan D', 'Fever with flank tenderness', 2, 'Discharged'),
(29, 23, '2026-10-12 07:10', 'Hip pain after a fall', 'Emergency', 'Ambulance', 'Fictional Plan C', 'Unable to bear weight', 3, 'Completed'),
(30, 14, '2026-10-13 13:25', 'Recurrent chest discomfort', 'Urgent', 'Family Doctor Referral', 'Fictional Plan B', 'Stable chest discomfort', 1, 'Discharged'),
(31, 18, '2026-10-14 08:35', 'Painful urination', 'Urgent', 'Walk-in', 'Fictional Plan D', 'Dysuria and urinary frequency', 2, 'Discharged'),
(32, 21, '2026-10-15 09:00', 'Fever and cough', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Cough under evaluation', 3, 'Admitted');

INSERT INTO Triage_Assessment (
    assessment_id, admission_id, assessment_date_time, assessment_results,
    healthcare_professional_in_charge, blood_pressure, heart_rate, respiratory_rate,
    body_temperature, oxygen_saturation, pain_level, reported_symptoms, known_allergies,
    current_medications, triage_priority_level
) VALUES
(18, 18, '2026-10-01 07:40', 'Possible wrist fracture', 7, '132/78', 84, 17, 36.7, 98.0, 7, 'Wrist pain after fall', 'None reported', 'None', 'Medium'),
(19, 19, '2026-10-10 09:10', 'Respiratory infection suspected', 6, '124/76', 96, 21, 38.2, 95.0, 2, 'Fever and cough', 'None reported', 'None', 'Low'),
(20, 20, '2026-10-02 11:25', 'Cardiac symptoms', 6, '154/92', 104, 22, 36.8, 96.0, 6, 'Chest pressure and nausea', 'Latex', 'Amlodipine', 'High'),
(21, 21, '2026-10-03 08:30', 'Possible appendicitis', 7, '118/72', 98, 19, 37.5, 98.0, 8, 'Abdominal pain and nausea', 'None reported', 'None', 'Medium'),
(22, 22, '2026-10-04 14:20', 'Asthma exacerbation', 6, '116/74', 106, 25, 37.1, 93.0, 3, 'Wheezing and shortness of breath', 'Peanuts', 'Rescue inhaler', 'Medium'),
(23, 23, '2026-10-05 02:50', 'Sepsis alert', 7, '82/48', 128, 30, 39.1, 88.0, 4, 'Fever, chills, confusion', 'Sulfa drugs', 'Metformin', 'High'),
(24, 24, '2026-10-06 10:10', 'Stroke alert', 6, '172/96', 90, 19, 36.9, 97.0, 1, 'Sudden weakness and slurred speech', 'None reported', 'Aspirin', 'High'),
(25, 25, '2026-10-07 16:40', 'Hyperglycemia', 7, '138/84', 92, 18, 37.0, 98.0, 1, 'Thirst and fatigue', 'None reported', 'Metformin', 'Low'),
(26, 26, '2026-10-08 07:00', 'Surgical abdomen suspected', 6, '120/76', 100, 20, 37.8, 97.0, 8, 'Right lower abdominal pain', 'None reported', 'None', 'Medium'),
(27, 27, '2026-10-09 12:15', 'Respiratory compromise', 7, '130/80', 110, 28, 37.3, 89.0, 2, 'Shortness of breath', 'None reported', 'Inhaler', 'High'),
(28, 28, '2026-10-11 09:55', 'Urinary infection suspected', 6, '126/78', 98, 18, 38.3, 97.0, 5, 'Fever and flank pain', 'Penicillin', 'None', 'Low'),
(29, 29, '2026-10-12 07:20', 'Possible hip fracture', 7, '146/86', 88, 18, 36.6, 96.0, 9, 'Hip pain after fall', 'None reported', 'Lisinopril', 'High'),
(30, 30, '2026-10-13 13:35', 'Stable cardiac symptoms', 6, '136/82', 82, 17, 36.7, 98.0, 3, 'Intermittent chest discomfort', 'None reported', 'Amlodipine', 'Low'),
(31, 31, '2026-10-14 08:45', 'Urinary symptoms', 7, '122/74', 90, 17, 37.2, 99.0, 4, 'Dysuria and frequency', 'None reported', 'None', 'Low'),
(32, 32, '2026-10-15 09:10', 'Respiratory infection evaluation', 6, '128/78', 94, 20, 37.9, 95.0, 2, 'Fever and cough', 'None reported', 'None', 'Medium');

INSERT INTO Clinical_Note (
    clinical_note_id, admission_id, note_type, note_date_time, patients_symptoms,
    physical_examination, initial_clinical_findings, suspected_medical_condition,
    planned_diagnostic_examinations, initial_treatment_plan, note_content
) VALUES
(26, 18, 'Emergency Assessment', '2026-10-01 07:55', 'Wrist pain after a fall', 'Swelling and reduced range of motion', 'Fracture to be ruled out', 'Wrist injury', 'Wrist X-ray', 'Splint and analgesia', 'Fictional wrist injury assessed.'),
(27, 19, 'Urgent Care Note', '2026-10-10 09:25', 'Fever and productive cough', 'Crackles at left base', 'Respiratory infection suspected', 'Pneumonia', 'Chest X-ray', 'Antibiotics and fluids', 'Fictional respiratory illness assessed.'),
(28, 20, 'Emergency Assessment', '2026-10-02 11:40', 'Chest pressure', 'Mild diaphoresis', 'ECG changes require evaluation', 'Acute cardiac syndrome', 'ECG, troponin, chest X-ray', 'Cardiac monitoring and specialist review', 'Fictional cardiac assessment.'),
(29, 21, 'Emergency Assessment', '2026-10-03 08:45', 'Right lower abdominal pain', 'Localized tenderness', 'Possible appendicitis', 'Acute appendicitis', 'Abdominal CT', 'NPO, IV fluids, surgical review', 'Fictional abdominal assessment.'),
(30, 22, 'Urgent Care Note', '2026-10-04 14:35', 'Wheezing', 'Expiratory wheezes', 'Mild airflow obstruction', 'Asthma exacerbation', 'Chest X-ray', 'Bronchodilator and observation', 'Fictional asthma assessment.'),
(31, 23, 'Emergency Assessment', '2026-10-05 03:05', 'Fever and confusion', 'Hypotension and tachycardia', 'Sepsis with poor perfusion', 'Sepsis', 'Blood cultures and chest X-ray', 'IV fluids, antibiotics, critical care', 'Fictional critical illness record.'),
(32, 24, 'Emergency Assessment', '2026-10-06 10:25', 'Sudden weakness', 'Right-sided weakness', 'Acute stroke symptoms', 'Cerebral infarction', 'Head CT', 'Stroke protocol and monitoring', 'Fictional stroke assessment.'),
(33, 25, 'Admission Note', '2026-10-07 17:00', 'Thirst and fatigue', 'No acute distress', 'Elevated blood glucose', 'Hyperglycemia', 'Laboratory monitoring', 'Medication adjustment and observation', 'Fictional admission remains in progress.'),
(34, 26, 'Emergency Assessment', '2026-10-08 07:15', 'Abdominal pain and nausea', 'Right lower quadrant tenderness', 'Surgical abdomen suspected', 'Appendicitis', 'Abdominal CT', 'NPO and surgical consultation', 'Fictional appendicitis assessment.'),
(35, 27, 'Emergency Assessment', '2026-10-09 12:30', 'Shortness of breath', 'Increased work of breathing', 'Hypoxemia', 'Pneumonia', 'Chest X-ray', 'Oxygen and antibiotics', 'Fictional respiratory assessment.'),
(36, 28, 'Urgent Care Note', '2026-10-11 10:10', 'Fever and flank pain', 'Flank tenderness', 'Urinary infection suspected', 'Urinary tract infection', 'Urine culture and renal ultrasound', 'Antibiotics and hydration', 'Fictional urinary infection assessment.'),
(37, 29, 'Emergency Assessment', '2026-10-12 07:35', 'Hip pain after fall', 'Unable to bear weight', 'Fracture suspected', 'Femoral neck fracture', 'Hip X-ray', 'Analgesia and orthopedic consultation', 'Fictional fracture assessment.'),
(38, 30, 'Urgent Care Note', '2026-10-13 13:50', 'Intermittent chest discomfort', 'Comfortable at rest', 'No acute instability', 'Coronary artery disease', 'ECG and cardiac enzymes', 'Medication review and follow-up', 'Fictional repeat cardiac visit.'),
(39, 31, 'Urgent Care Note', '2026-10-14 09:00', 'Dysuria and frequency', 'No flank tenderness', 'Urinary symptoms under evaluation', 'Urinary tract infection', 'Urinalysis and culture', 'Oral antibiotics', 'Fictional urinary assessment.'),
(40, 32, 'Emergency Assessment', '2026-10-15 09:25', 'Fever and cough', 'Mild crackles', 'Respiratory infection suspected', 'Pneumonia', 'Chest X-ray and blood tests', 'Observation and supportive care', 'Fictional admission remains in progress.');

INSERT INTO Diagnostic_Order (
    diagnostic_order_id, admission_id, requesting_physician, requested_examination,
    request_date_time, clinical_reason_for_examination, priority, order_status
) VALUES
(18, 18, 3, 'Left wrist X-ray', '2026-10-01 08:00', 'Evaluate fall injury', 'High', 'Completed'),
(19, 19, 2, 'Chest X-ray', '2026-10-10 09:30', 'Evaluate cough and fever', 'Routine', 'Completed'),
(20, 20, 1, 'Chest X-ray', '2026-10-02 11:50', 'Assess chest symptoms', 'Urgent', 'Completed'),
(21, 21, 3, 'Abdominal CT', '2026-10-03 09:00', 'Evaluate suspected appendicitis', 'Urgent', 'Completed'),
(22, 22, 3, 'Chest X-ray', '2026-10-04 14:45', 'Exclude other respiratory cause', 'Routine', 'Completed'),
(23, 23, 2, 'Chest X-ray', '2026-10-05 03:15', 'Assess infection source', 'Urgent', 'Completed'),
(24, 24, 2, 'Head CT', '2026-10-06 10:35', 'Stroke evaluation', 'Urgent', 'Completed'),
(25, 26, 3, 'Abdominal CT', '2026-10-08 07:30', 'Assess appendicitis', 'Urgent', 'Completed'),
(26, 27, 2, 'Chest X-ray', '2026-10-09 12:45', 'Assess hypoxemia', 'Urgent', 'Completed'),
(27, 28, 2, 'Renal ultrasound', '2026-10-11 10:20', 'Evaluate flank pain', 'High', 'Completed'),
(28, 29, 3, 'Left hip X-ray', '2026-10-12 07:45', 'Assess suspected fracture', 'Urgent', 'Completed'),
(29, 32, 3, 'Chest X-ray', '2026-10-15 09:40', 'Evaluate respiratory infection', 'Routine', 'In Progress');

INSERT INTO Radiology_Report (
    examination_id, diagnostic_order_id, examination_type, examination_date_time,
    body_area_examined, referring_physician, radiology_technician, examination_status,
    medical_images_link, findings, interpretation, conclusion
) VALUES
(19, 18, 'X-ray', '2026-10-01 08:20', 'Left wrist', 3, 8, 'Completed', 'https://example.org/synthetic-images/exam-19', 'No displaced fracture identified in the fictional study.', 'Mild soft-tissue swelling is present.', 'No acute bony injury identified.'),
(20, 19, 'X-ray', '2026-10-10 09:50', 'Chest', 2, 9, 'Completed', 'https://example.org/synthetic-images/exam-20', 'Patchy left basilar opacity.', 'Appearance may represent early infection.', 'Correlate with symptoms and treatment.'),
(21, 20, 'X-ray', '2026-10-02 12:10', 'Chest', 1, 8, 'Completed', 'https://example.org/synthetic-images/exam-21', 'Cardiac silhouette within expected limits.', 'No focal air-space opacity.', 'No acute chest finding.'),
(22, 21, 'CT', '2026-10-03 09:25', 'Abdomen', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-22', 'Appendix appears enlarged in the fictional study.', 'Findings are consistent with acute inflammation.', 'Surgical consultation advised.'),
(23, 22, 'X-ray', '2026-10-04 15:00', 'Chest', 3, 8, 'Completed', 'https://example.org/synthetic-images/exam-23', 'No focal pulmonary opacity.', 'No acute cardiopulmonary abnormality.', 'No acute chest finding.'),
(24, 23, 'X-ray', '2026-10-05 03:30', 'Chest', 2, 9, 'Completed', 'https://example.org/synthetic-images/exam-24', 'Bilateral patchy opacities.', 'Findings may be infectious.', 'Correlate with sepsis evaluation.'),
(25, 24, 'CT', '2026-10-06 10:50', 'Head', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-25', 'No acute intracranial hemorrhage.', 'No large acute territorial finding identified.', 'Continue stroke assessment.'),
(26, 25, 'CT', '2026-10-08 07:45', 'Abdomen', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-26', 'Appendiceal inflammation is visible.', 'Findings support acute appendicitis.', 'Surgical review advised.'),
(27, 26, 'X-ray', '2026-10-09 13:00', 'Chest', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-27', 'Mild right basilar opacity.', 'Possible early infectious change.', 'Correlate clinically.'),
(28, 27, 'Ultrasound', '2026-10-11 10:40', 'Kidneys', 2, 9, 'Completed', 'https://example.org/synthetic-images/exam-28', 'No hydronephrosis.', 'No obstructive process identified.', 'Urinary infection remains a clinical diagnosis.'),
(29, 28, 'X-ray', '2026-10-12 08:05', 'Left hip', 3, 8, 'Completed', 'https://example.org/synthetic-images/exam-29', 'Femoral neck fracture is present.', 'Imaging confirms the suspected fracture.', 'Orthopedic management advised.'),
(30, 29, 'X-ray', '2026-10-15 10:00', 'Chest', 3, 9, 'In Progress', NULL, 'Examination is not yet finalized.', 'Interpretation pending.', 'Conclusion pending.'),
(31, 18, 'X-ray', '2026-10-01 08:25', 'Left wrist', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-31', 'Additional wrist views show no displaced fracture.', 'Additional views support the initial interpretation.', 'No acute bony injury identified.');

INSERT INTO Diagnosis_Record (
    diagnosis_id, admission_id, icd_9_code, diagnosis_date_time, diagnosis_type, diagnosing_physician
) VALUES
(26, 18, '820.8', '2026-10-01 08:35', 'Primary', 3),
(27, 19, '486', '2026-10-10 10:00', 'Primary', 2),
(28, 20, '410.91', '2026-10-02 12:30', 'Primary', 1),
(29, 21, '540.9', '2026-10-03 10:00', 'Primary', 3),
(30, 22, '493.90', '2026-10-04 15:15', 'Primary', 3),
(31, 23, '038.9', '2026-10-05 03:45', 'Primary', 2),
(32, 24, '434.91', '2026-10-06 11:00', 'Primary', 2),
(33, 25, '250.00', '2026-10-07 17:10', 'Primary', 1),
(34, 26, '540.9', '2026-10-08 08:00', 'Primary', 3),
(35, 27, '486', '2026-10-09 13:15', 'Primary', 2),
(36, 28, '599.0', '2026-10-11 11:00', 'Primary', 2),
(37, 29, '820.8', '2026-10-12 08:30', 'Primary', 3),
(38, 30, '414.01', '2026-10-13 14:30', 'Primary', 1),
(39, 31, '599.0', '2026-10-14 09:30', 'Primary', 2),
(40, 32, '486', '2026-10-15 10:15', 'Primary', 3),
(41, 19, '401.9', '2026-10-10 10:10', 'Secondary', 2),
(42, 20, '401.9', '2026-10-02 12:40', 'Secondary', 1),
(43, 23, '518.81', '2026-10-05 04:00', 'Secondary', 2),
(44, 25, '401.9', '2026-10-07 17:20', 'Secondary', 1),
(45, 27, '518.81', '2026-10-09 13:25', 'Secondary', 2),
(46, 29, '401.9', '2026-10-12 08:40', 'Secondary', 3);

INSERT INTO Surgical_Procedure (
    surgical_procedure_id, admission_id, procedure_type, procedure_date_time,
    performing_surgeon, procedure_status, procedure_notes
) VALUES
(7, 21, 'Laparoscopic appendectomy', '2026-10-03 12:00', 5, 'Completed', 'Fictional uncomplicated appendectomy.'),
(8, 26, 'Laparoscopic appendectomy', '2026-10-08 10:00', 4, 'Completed', 'Fictional procedure with stable recovery.'),
(9, 29, 'Hip fracture repair', '2026-10-12 11:00', 5, 'Completed', 'Fictional repair followed by rehabilitation.');

INSERT INTO Unit_Stay (
    unit_stay_id, admission_id, unit_id, ward_and_room, bed_number, entry_date_time,
    exit_date_time, responsible_physician, reason_for_transfer
) VALUES
(46, 18, 1, 'ER-C / Room 1', '1', '2026-10-01 07:30', '2026-10-01 09:00', 3, 'Initial injury assessment'),
(47, 18, 4, 'Ward 1A / Room 2', '2A', '2026-10-01 09:15', '2026-10-02 10:00', 3, 'Observation after wrist injury'),
(48, 19, 1, 'ER-C / Room 2', '2', '2026-10-10 09:00', '2026-10-10 10:30', 2, 'Respiratory assessment'),
(49, 19, 4, 'Ward 2D / Room 1', '1D', '2026-10-10 10:45', '2026-10-12 10:00', 2, 'Antibiotic treatment'),
(50, 20, 1, 'ER-D / Room 1', '1', '2026-10-02 11:15', '2026-10-02 13:00', 1, 'Cardiac assessment'),
(51, 20, 2, 'CCU / Room 4', '4', '2026-10-02 13:15', '2026-10-05 09:00', 4, 'Cardiac monitoring'),
(52, 21, 1, 'ER-D / Room 2', '2', '2026-10-03 08:20', '2026-10-03 11:00', 3, 'Surgical assessment'),
(53, 21, 6, 'OR 4', '4', '2026-10-03 11:30', '2026-10-03 13:00', 5, 'Appendectomy'),
(54, 21, 4, 'Ward 1B / Room 3', '3B', '2026-10-03 13:30', '2026-10-05 09:00', 5, 'Postoperative recovery'),
(55, 22, 1, 'ER-C / Room 3', '3', '2026-10-04 14:10', '2026-10-04 16:00', 3, 'Respiratory assessment'),
(56, 22, 4, 'Ward 2C / Room 2', '2C', '2026-10-04 16:15', '2026-10-06 10:00', 3, 'Observation and bronchodilator therapy'),
(57, 23, 1, 'ER-D / Room 3', '3', '2026-10-05 02:40', '2026-10-05 04:00', 2, 'Sepsis resuscitation'),
(58, 23, 5, 'ICU / Room 5', '5', '2026-10-05 04:15', '2026-10-05 06:20', 2, 'Critical care'),
(59, 24, 1, 'ER-C / Room 4', '4', '2026-10-06 10:00', '2026-10-06 12:00', 2, 'Stroke protocol'),
(60, 24, 5, 'ICU / Room 6', '6', '2026-10-06 12:15', '2026-10-08 12:00', 2, 'Neurologic monitoring'),
(61, 25, 1, 'ER-D / Room 4', '4', '2026-10-07 16:30', '2026-10-07 18:00', 1, 'Hyperglycemia assessment'),
(62, 25, 4, 'Ward 3D / Room 1', '1D', '2026-10-07 18:15', NULL, 1, 'Ongoing monitoring'),
(63, 26, 1, 'ER-C / Room 5', '5', '2026-10-08 06:50', '2026-10-08 09:00', 3, 'Surgical assessment'),
(64, 26, 6, 'OR 5', '5', '2026-10-08 09:30', '2026-10-08 11:00', 4, 'Appendectomy'),
(65, 26, 4, 'Ward 1C / Room 4', '4C', '2026-10-08 11:30', '2026-10-10 09:00', 4, 'Postoperative recovery'),
(66, 27, 1, 'ER-D / Room 5', '5', '2026-10-09 12:05', '2026-10-09 14:00', 2, 'Respiratory stabilization'),
(67, 27, 5, 'ICU / Room 7', '7', '2026-10-09 14:15', '2026-10-11 09:00', 2, 'Oxygen and respiratory support'),
(68, 28, 1, 'ER-C / Room 6', '6', '2026-10-11 09:45', '2026-10-11 12:00', 2, 'Urinary infection assessment'),
(69, 28, 4, 'Ward 2E / Room 2', '2E', '2026-10-11 12:15', '2026-10-13 09:00', 2, 'Antibiotic treatment'),
(70, 29, 1, 'ER-D / Room 6', '6', '2026-10-12 07:10', '2026-10-12 09:00', 3, 'Fracture assessment'),
(71, 29, 6, 'OR 6', '6', '2026-10-12 09:30', '2026-10-12 12:00', 5, 'Hip fracture repair'),
(72, 29, 4, 'Ward 5C / Room 1', '1C', '2026-10-12 12:30', '2026-10-16 09:00', 5, 'Postoperative rehabilitation'),
(73, 30, 1, 'ER-C / Room 7', '7', '2026-10-13 13:25', '2026-10-13 15:00', 1, 'Cardiac reassessment'),
(74, 31, 1, 'ER-D / Room 7', '7', '2026-10-14 08:35', '2026-10-14 10:00', 2, 'Urinary assessment'),
(75, 31, 4, 'Ward 2F / Room 3', '3F', '2026-10-14 10:15', '2026-10-16 09:00', 2, 'Antibiotic treatment'),
(76, 32, 1, 'ER-C / Room 8', '8', '2026-10-15 09:00', '2026-10-15 11:00', 3, 'Respiratory assessment'),
(77, 32, 4, 'Ward 3E / Room 2', '2E', '2026-10-15 11:15', NULL, 3, 'Ongoing evaluation');

INSERT INTO General_Ward (
    progress_note_id, unit_stay_id, nursing_monitoring_notes, physician_follow_up_examination,
    medications_and_treatments_administered, progress_notes, additional_tests_requested,
    recovery_evaluation
) VALUES
(16, 49, 'Temperature checked every four hours', 'Breath sounds improving', 'Antibiotics administered', 'Cough reduced', 'Repeat chest assessment', 'Improving'),
(17, 54, 'Vitals stable', 'Abdominal tenderness reduced', 'Analgesia and fluids', 'Tolerating diet', 'None', 'Recovering after surgery'),
(18, 56, 'Respiratory rate monitored', 'Wheezing reduced', 'Bronchodilator administered', 'Breathing comfortably', 'None', 'Stable for discharge'),
(19, 62, 'Glucose checks continued', 'Hydration reviewed', 'Medication adjusted', 'Treatment ongoing', 'Repeat glucose testing', 'Ongoing care'),
(20, 65, 'Wound checks completed', 'Incision clean and dry', 'Analgesia administered', 'Mobilizing independently', 'None', 'Recovering well'),
(21, 72, 'Mobility assistance provided', 'Orthopedic examination completed', 'Analgesia and thrombosis prevention', 'Walking with support', 'Physiotherapy review', 'Progressing with rehabilitation'),
(22, 77, 'Temperature and oxygen monitored', 'Mild cough persists', 'Supportive care provided', 'Observation continues', 'Repeat chest imaging if symptoms worsen', 'Ongoing care');

INSERT INTO Discharge_Record (
    discharge_record_id, admission_id, discharge_date_time, discharge_destination,
    patients_condition_at_discharge, prescribed_medications, follow_up_instructions,
    scheduled_follow_up_appointments, responsible_physician
) VALUES
(17, 18, '2026-10-02 10:15', 'Home', 'Wrist pain improved', 'Acetaminophen as needed', 'Return if pain or swelling worsens', '2026-10-09 10:00 Orthopedic clinic', 3),
(18, 19, '2026-10-12 10:15', 'Home', 'Fever reduced and breathing improved', 'Complete antibiotic course', 'Follow up if cough worsens', '2026-10-19 09:00 Family physician', 2),
(19, 20, '2026-10-05 09:15', 'Home', 'Stable after cardiac monitoring', 'Continue cardiac medications', 'Cardiology follow-up and return for chest pain', '2026-10-12 10:00 Cardiology clinic', 1),
(20, 21, '2026-10-05 09:15', 'Home', 'Recovering after appendectomy', 'Acetaminophen as needed', 'Avoid strenuous activity', '2026-10-12 09:30 Surgery clinic', 5),
(21, 22, '2026-10-06 10:15', 'Home', 'Wheezing resolved', 'Rescue inhaler as needed', 'Avoid known triggers', '2026-10-20 11:00 Family physician', 3),
(22, 23, '2026-10-05 06:30', 'Deceased', 'Deceased during the hospital stay', NULL, NULL, NULL, 2),
(23, 24, '2026-10-08 12:15', 'Rehabilitation Center', 'Weakness improving', 'Continue antiplatelet therapy', 'Continue physical therapy', '2026-10-15 13:00 Neurology clinic', 2),
(24, 26, '2026-10-10 09:15', 'Home', 'Pain controlled after appendectomy', 'Acetaminophen as needed', 'Follow postoperative instructions', '2026-10-17 10:00 Surgery clinic', 4),
(25, 27, '2026-10-11 09:15', 'Home', 'Breathing improved', 'Complete antibiotics and use inhaler as directed', 'Return for recurrent shortness of breath', '2026-10-18 09:30 Family physician', 2),
(26, 28, '2026-10-13 09:15', 'Home', 'Fever resolved', 'Complete antibiotic course', 'Maintain hydration', '2026-10-20 10:00 Family physician', 2),
(27, 29, '2026-10-16 09:15', 'Rehabilitation Center', 'Stable after hip repair', 'Analgesia as needed', 'Continue physiotherapy', '2026-10-23 14:00 Orthopedic clinic', 5),
(28, 30, '2026-10-13 15:15', 'Home', 'Chest discomfort resolved', 'Continue current medications', 'Follow up with cardiology', '2026-10-20 10:00 Cardiology clinic', 1),
(29, 31, '2026-10-16 09:15', 'Home', 'Urinary symptoms improved', 'Complete antibiotic course', 'Return if fever develops', '2026-10-23 09:00 Family physician', 2);

-- Additional hand-entered fictional cohort for broader testing.
INSERT INTO Patient (
    patient_id, full_name, health_insurance_number, date_of_birth, gender,
    address, telephone_number, emergency_contact_info, life_status
) VALUES
(25, 'Amara Bennett', 710000025, '1971-02-14', 'Female', '25 Sample Street, Montreal, QC', '5145551025', 'Nora Bennett, 5145551125', 'Alive'),
(26, 'Devon Singh', 710000026, '1982-06-03', 'Male', '26 Fictional Avenue, Laval, QC', '4505551026', 'Asha Singh, 4505551126', 'Alive'),
(27, 'Priya Okafor', 710000027, '1995-09-20', 'Female', '27 Example Road, Montreal, QC', '5145551027', 'Tomi Okafor, 5145551127', 'Alive'),
(28, 'Elliot Dubois', 710000028, '1949-12-11', 'Male', '28 Mock Crescent, Longueuil, QC', '4505551028', 'Remy Dubois, 4505551128', 'Alive'),
(29, 'Sasha Khan', 710000029, '1963-04-07', 'Nonbinary', '29 Placeholder Lane, Brossard, QC', '4505551029', 'Mina Khan, 4505551129', 'Alive'),
(30, 'Nico Silva', 710000030, '1955-08-19', 'Male', '30 Synthetic Boulevard, Montreal, QC', '5145551030', 'Rui Silva, 5145551130', 'Alive'),
(31, 'Leila Roy', 710000031, '1989-03-25', 'Female', '31 Fictional Walk, Laval, QC', '4505551031', 'Ari Roy, 4505551131', 'Alive'),
(32, 'Rory Cohen', 710000032, '1976-11-02', 'Male', '32 Imaginary Place, Montreal, QC', '5145551032', 'Noam Cohen, 5145551132', 'Alive'),
(33, 'Imani Diaz', 710000033, '2000-01-30', 'Female', '33 Sample Court, Brossard, QC', '4505551033', 'Elena Diaz, 4505551133', 'Alive'),
(34, 'Theo Martin', 710000034, '1944-05-16', 'Male', '34 Example Terrace, Montreal, QC', '5145551034', 'Luca Martin, 5145551134', 'Alive'),
(35, 'Mina Bennett', 710000035, '1967-10-09', 'Female', '35 Mock Street, Laval, QC', '4505551035', 'Sam Bennett, 4505551135', 'Alive'),
(36, 'Arlo Singh', 710000036, '1991-07-12', 'Male', '36 Fictional Road, Montreal, QC', '5145551036', 'Kiran Singh, 5145551136', 'Alive'),
(37, 'Noor Okafor', 710000037, '1950-02-28', 'Nonbinary', '37 Placeholder Avenue, Longueuil, QC', '4505551037', 'Ada Okafor, 4505551137', 'Alive'),
(38, 'Remy Dubois', 710000038, '1984-12-04', 'Male', '38 Synthetic Crescent, Montreal, QC', '5145551038', 'Camille Dubois, 5145551138', 'Alive'),
(39, 'Asha Khan', 710000039, '1973-06-21', 'Female', '39 Imaginary Lane, Laval, QC', '4505551039', 'Mira Khan, 4505551139', 'Alive'),
(40, 'Tomi Silva', 710000040, '1960-09-15', 'Male', '40 Sample Drive, Montreal, QC', '5145551040', 'Rafa Silva, 5145551140', 'Alive'),
(41, 'Ari Roy', 710000041, '1998-03-08', 'Female', '41 Example Walk, Brossard, QC', '4505551041', 'Lena Roy, 4505551141', 'Alive'),
(42, 'Noam Cohen', 710000042, '1946-08-31', 'Male', '42 Mock Avenue, Montreal, QC', '5145551042', 'Eli Cohen, 5145551142', 'Alive'),
(43, 'Elena Diaz', 710000043, '1987-01-17', 'Female', '43 Fictional Place, Laval, QC', '4505551043', 'Inez Diaz, 4505551143', 'Alive'),
(44, 'Luca Martin', 710000044, '1979-04-23', 'Male', '44 Synthetic Road, Montreal, QC', '5145551044', 'Maya Martin, 5145551144', 'Alive'),
(45, 'Sam Bennett', 710000045, '1938-11-06', 'Male', '45 Placeholder Court, Longueuil, QC', '4505551045', 'Nora Bennett, 4505551145', 'Deceased'),
(46, 'Kiran Singh', 710000046, '1993-05-29', 'Female', '46 Sample Terrace, Montreal, QC', '5145551046', 'Dev Singh, 5145551146', 'Alive'),
(47, 'Ada Okafor', 710000047, '1957-02-13', 'Female', '47 Example Boulevard, Laval, QC', '4505551047', 'Tomi Okafor, 4505551147', 'Alive'),
(48, 'Camille Dubois', 710000048, '2002-10-01', 'Nonbinary', '48 Imaginary Street, Montreal, QC', '5145551048', 'Remy Dubois, 5145551148', 'Alive'),
(49, 'Mira Khan', 710000049, '1942-07-07', 'Female', '49 Fictional Crescent, Brossard, QC', '4505551049', 'Asha Khan, 4505551149', 'Deceased');

INSERT INTO Admission (
    admission_id, patient_id, admission_date_time, reason_for_visit, admission_type,
    admission_source, insurance_info, patient_current_condition,
    admitting_healthcare_professional_id, final_admission_status
) VALUES
(33, 25, '2026-10-16 08:00', 'Chest discomfort', 'Emergency', 'Emergency Department', 'Plan E', 'Stable chest discomfort', 1, 'Discharged'),
(34, 25, '2026-10-18 09:10', 'Migraine symptoms', 'Urgent', 'Walk-in', 'Plan E', 'Headache with light sensitivity', 2, 'Discharged'),
(35, 26, '2026-10-17 11:00', 'Fever and cough', 'Emergency', 'Walk-in', 'Plan B', 'Fever with productive cough', 3, 'Discharged'),
(36, 27, '2026-10-18 07:45', 'Abdominal pain', 'Emergency', 'Emergency Department', 'Plan C', 'Right lower abdominal tenderness', 3, 'Completed'),
(37, 28, '2026-10-19 14:20', 'Fall with shoulder pain', 'Urgent', 'Ambulance', 'Plan A', 'Shoulder pain and bruising', 4, 'Discharged'),
(38, 29, '2026-10-20 06:30', 'Severe breathing difficulty', 'Emergency', 'Emergency Department', 'Plan D', 'Acute respiratory distress', 2, 'Discharged'),
(39, 30, '2026-10-21 13:00', 'Urinary symptoms', 'Urgent', 'Family Doctor Referral', 'Plan E', 'Dysuria and fever', 1, 'Discharged'),
(40, 31, '2026-10-22 10:05', 'Wheezing and cough', 'Emergency', 'Emergency Department', 'Plan C', 'Respiratory symptoms under evaluation', 3, 'Admitted'),
(41, 32, '2026-10-23 08:15', 'Sudden weakness', 'Emergency', 'Ambulance', 'Plan B', 'Weakness and slurred speech', 2, 'Discharged'),
(42, 33, '2026-10-24 16:40', 'Right hip pain', 'Emergency', 'Emergency Department', 'Plan A', 'Unable to bear weight after fall', 4, 'Completed'),
(43, 34, '2026-10-25 09:25', 'Chest pain', 'Urgent', 'Family Doctor Referral', 'Plan D', 'Intermittent chest pressure', 1, 'Discharged'),
(44, 35, '2026-10-26 12:10', 'Asthma exacerbation', 'Emergency', 'Walk-in', 'Plan B', 'Wheezing and reduced peak flow', 3, 'Discharged'),
(45, 36, '2026-10-27 05:55', 'Acute abdominal pain', 'Emergency', 'Emergency Department', 'Plan C', 'Abdominal pain with nausea', 5, 'Discharged'),
(46, 37, '2026-10-28 18:30', 'Severe infection', 'Emergency', 'Ambulance', 'Plan A', 'Fever and low blood pressure', 2, 'Admitted'),
(47, 38, '2026-10-29 10:20', 'Back pain', 'Urgent', 'Walk-in', 'Plan D', 'Back pain after lifting', 4, 'Discharged'),
(48, 39, '2026-10-30 07:15', 'Pneumonia symptoms', 'Emergency', 'Emergency Department', 'Plan E', 'Fever and low oxygen saturation', 3, 'Discharged'),
(49, 40, '2026-10-31 14:05', 'Abdominal discomfort', 'Urgent', 'Family Doctor Referral', 'Plan B', 'Mild abdominal tenderness', 1, 'Discharged'),
(50, 41, '2026-11-01 09:50', 'Chest pressure', 'Emergency', 'Emergency Department', 'Plan C', 'Chest pressure with nausea', 5, 'Completed'),
(51, 42, '2026-11-02 11:30', 'Urinary infection symptoms', 'Urgent', 'Walk-in', 'Plan A', 'Fever and flank tenderness', 2, 'Discharged'),
(52, 43, '2026-11-03 08:40', 'Headache and vision change', 'Emergency', 'Emergency Department', 'Plan D', 'Headache under evaluation', 1, 'Discharged'),
(53, 44, '2026-11-04 15:15', 'Breathing difficulty', 'Emergency', 'Ambulance', 'Plan B', 'Shortness of breath', 3, 'Discharged'),
(54, 45, '2026-11-05 04:20', 'Severe sepsis', 'Emergency', 'Emergency Department', 'Plan C', 'Septic shock', 2, 'Deceased'),
(55, 46, '2026-11-06 13:45', 'Knee pain after sports injury', 'Urgent', 'Walk-in', 'Plan E', 'Knee swelling and pain', 4, 'Discharged'),
(56, 47, '2026-11-07 08:05', 'Persistent cough', 'Emergency', 'Emergency Department', 'Plan A', 'Cough and mild hypoxemia', 3, 'Admitted'),
(57, 25, '2026-11-08 10:30', 'Flank pain', 'Urgent', 'Family Doctor Referral', 'Plan E', 'Flank pain with urinary frequency', 2, 'Discharged'),
(58, 26, '2026-11-09 07:25', 'Dizziness', 'Emergency', 'Emergency Department', 'Plan B', 'Dizziness without loss of consciousness', 1, 'Discharged'),
(59, 27, '2026-11-10 12:55', 'Gallbladder pain', 'Emergency', 'Walk-in', 'Plan C', 'Right upper quadrant pain', 5, 'Completed'),
(60, 28, '2026-11-11 09:35', 'Skin infection', 'Urgent', 'Walk-in', 'Plan A', 'Localized skin redness', 4, 'Discharged'),
(61, 29, '2026-11-12 06:50', 'Fracture follow-up', 'Emergency', 'Ambulance', 'Plan D', 'Pain after another fall', 3, 'Discharged'),
(62, 49, '2026-11-13 02:15', 'Cardiac arrest', 'Emergency', 'Emergency Department', 'Plan D', 'Resuscitation unsuccessful', 1, 'Deceased');

INSERT INTO Triage_Assessment (
    assessment_id, admission_id, assessment_date_time, assessment_results,
    healthcare_professional_in_charge, blood_pressure, heart_rate, respiratory_rate,
    body_temperature, oxygen_saturation, pain_level, reported_symptoms, known_allergies,
    current_medications, triage_priority_level
) VALUES
(33, 33, '2026-10-16 08:10', 'Stable cardiac symptoms', 6, '138/84', 88, 17, 36.8, 98.0, 4, 'Chest discomfort', 'None reported', 'None', 'Low'),
(34, 34, '2026-10-18 09:20', 'Migraine suspected', 7, '124/76', 80, 16, 36.7, 99.0, 6, 'Headache and light sensitivity', 'None reported', 'None', 'Low'),
(35, 35, '2026-10-17 11:10', 'Respiratory infection', 6, '126/78', 102, 23, 38.4, 94.0, 2, 'Fever and cough', 'Penicillin', 'None', 'Medium'),
(36, 36, '2026-10-18 07:55', 'Possible appendicitis', 7, '116/70', 98, 20, 37.7, 98.0, 8, 'Abdominal pain and nausea', 'None reported', 'None', 'Medium'),
(37, 37, '2026-10-19 14:30', 'Shoulder injury', 6, '132/80', 86, 18, 36.6, 98.0, 7, 'Shoulder pain after fall', 'Latex', 'None', 'Low'),
(38, 38, '2026-10-20 06:40', 'Respiratory emergency', 7, '148/90', 122, 31, 37.5, 84.0, 3, 'Severe shortness of breath', 'None reported', 'Inhaler', 'High'),
(39, 39, '2026-10-21 13:10', 'Urinary infection suspected', 6, '120/74', 96, 18, 38.1, 98.0, 5, 'Dysuria and fever', 'Sulfa drugs', 'None', 'Low'),
(40, 40, '2026-10-22 10:15', 'Asthma assessment', 7, '118/72', 108, 27, 37.0, 92.0, 2, 'Wheezing and cough', 'Peanuts', 'Rescue inhaler', 'Medium'),
(41, 41, '2026-10-23 08:25', 'Stroke alert', 6, '170/96', 92, 19, 36.9, 96.0, 1, 'Weakness and slurred speech', 'None reported', 'Aspirin', 'High'),
(42, 42, '2026-10-24 16:50', 'Hip fracture suspected', 7, '150/88', 94, 20, 36.5, 97.0, 9, 'Hip pain and inability to walk', 'None reported', 'Lisinopril', 'High'),
(43, 43, '2026-10-25 09:35', 'Cardiac symptoms', 6, '156/94', 100, 22, 36.8, 95.0, 6, 'Chest pain', 'None reported', 'Amlodipine', 'Medium'),
(44, 44, '2026-10-26 12:20', 'Asthma exacerbation', 7, '112/70', 112, 28, 37.2, 91.0, 3, 'Wheezing', 'Peanuts', 'Inhaler', 'Medium'),
(45, 45, '2026-10-27 06:05', 'Acute abdomen', 6, '118/74', 104, 21, 37.8, 97.0, 8, 'Abdominal pain and nausea', 'None reported', 'None', 'High'),
(46, 46, '2026-10-28 18:40', 'Sepsis alert', 7, '84/50', 126, 30, 39.0, 89.0, 4, 'Fever and chills', 'Penicillin', 'Metformin', 'High'),
(47, 47, '2026-10-29 10:30', 'Musculoskeletal back pain', 6, '128/82', 84, 17, 36.7, 98.0, 6, 'Back pain after lifting', 'None reported', 'None', 'Low'),
(48, 48, '2026-10-30 07:25', 'Pneumonia suspected', 7, '132/78', 108, 29, 38.2, 88.0, 2, 'Cough and shortness of breath', 'None reported', 'Inhaler', 'High'),
(49, 49, '2026-10-31 14:15', 'Abdominal assessment', 6, '122/76', 82, 17, 36.9, 98.0, 3, 'Abdominal discomfort', 'None reported', 'None', 'Low'),
(50, 50, '2026-11-01 10:00', 'Cardiac emergency', 7, '162/96', 110, 24, 36.7, 94.0, 7, 'Chest pressure and nausea', 'Latex', 'Aspirin', 'High'),
(51, 51, '2026-11-02 11:40', 'Urinary infection', 6, '124/78', 100, 19, 38.4, 97.0, 5, 'Flank tenderness and fever', 'Sulfa drugs', 'None', 'Medium'),
(52, 52, '2026-11-03 08:50', 'Headache evaluation', 7, '140/86', 90, 18, 37.0, 98.0, 5, 'Headache and vision change', 'None reported', 'None', 'Low'),
(53, 53, '2026-11-04 15:25', 'Respiratory distress', 6, '130/80', 116, 29, 37.3, 87.0, 2, 'Shortness of breath', 'None reported', 'Inhaler', 'High'),
(54, 54, '2026-11-05 04:30', 'Septic shock', 7, '78/46', 132, 32, 39.4, 86.0, 4, 'Fever and confusion', 'None reported', 'None', 'High'),
(55, 55, '2026-11-06 13:55', 'Knee injury', 6, '126/78', 88, 18, 36.8, 99.0, 7, 'Knee pain and swelling', 'None reported', 'None', 'Low'),
(56, 56, '2026-11-07 08:15', 'Respiratory assessment', 7, '134/82', 102, 25, 37.6, 92.0, 2, 'Persistent cough', 'Penicillin', 'None', 'Medium'),
(57, 57, '2026-11-08 10:40', 'Possible kidney infection', 6, '120/76', 98, 20, 38.0, 97.0, 6, 'Flank pain and frequency', 'None reported', 'None', 'Medium'),
(58, 58, '2026-11-09 07:35', 'Dizziness assessment', 7, '116/72', 86, 17, 36.6, 98.0, 2, 'Dizziness', 'None reported', 'None', 'Low'),
(59, 59, '2026-11-10 13:05', 'Gallbladder symptoms', 6, '128/80', 96, 19, 37.4, 98.0, 7, 'Right upper quadrant pain', 'None reported', 'None', 'Medium'),
(60, 60, '2026-11-11 09:45', 'Skin infection', 7, '122/76', 92, 18, 37.5, 98.0, 4, 'Redness and tenderness', 'None reported', 'None', 'Low'),
(61, 61, '2026-11-12 07:00', 'Possible fracture', 6, '148/88', 90, 20, 36.5, 96.0, 8, 'Pain after fall', 'Latex', 'None', 'High'),
(62, 62, '2026-11-13 02:25', 'Cardiac arrest', 7, '80/48', 130, 30, 36.0, 82.0, 0, 'Unresponsive', 'None reported', 'None', 'High');

INSERT INTO Clinical_Note (
    clinical_note_id, admission_id, note_type, note_date_time, patients_symptoms,
    physical_examination, initial_clinical_findings, suspected_medical_condition,
    planned_diagnostic_examinations, initial_treatment_plan, note_content
) VALUES
(41, 33, 'Emergency Assessment', '2026-10-16 08:20', 'Intermittent chest discomfort', 'Comfortable at rest', 'No acute instability', 'Coronary artery disease', 'ECG and cardiac enzymes', 'Observation and medication review', 'Fictional chest discomfort assessment.'),
(42, 34, 'Urgent Care Note', '2026-10-18 09:30', 'Headache and light sensitivity', 'Neurologic exam nonfocal', 'Migraine symptoms', 'Migraine', 'Clinical assessment', 'Fluids and symptom relief', 'Fictional headache visit.'),
(43, 35, 'Emergency Assessment', '2026-10-17 11:20', 'Fever and cough', 'Crackles at right base', 'Respiratory infection suspected', 'Pneumonia', 'Chest X-ray and blood tests', 'Antibiotics and fluids', 'Fictional respiratory assessment.'),
(44, 36, 'Emergency Assessment', '2026-10-18 08:05', 'Abdominal pain and nausea', 'Right lower quadrant tenderness', 'Possible appendicitis', 'Acute appendicitis', 'Abdominal CT', 'NPO and surgical consultation', 'Fictional surgical assessment.'),
(45, 37, 'Urgent Care Note', '2026-10-19 14:40', 'Shoulder pain after fall', 'Bruising and reduced motion', 'No neurovascular deficit', 'Shoulder injury', 'Shoulder X-ray', 'Sling and analgesia', 'Fictional fall assessment.'),
(46, 38, 'Emergency Assessment', '2026-10-20 06:50', 'Severe breathing difficulty', 'Increased work of breathing', 'Hypoxemia', 'Respiratory failure', 'Chest X-ray and blood gas', 'Oxygen and respiratory support', 'Fictional respiratory emergency.'),
(47, 39, 'Urgent Care Note', '2026-10-21 13:20', 'Dysuria and fever', 'Mild flank tenderness', 'Urinalysis suggests infection', 'Urinary tract infection', 'Urine culture', 'Antibiotics and hydration', 'Fictional urinary assessment.'),
(48, 40, 'Emergency Assessment', '2026-10-22 10:25', 'Wheezing and cough', 'Expiratory wheezing', 'Reduced peak flow', 'Asthma exacerbation', 'Chest X-ray and peak flow', 'Bronchodilator and observation', 'Fictional case remains under care.'),
(49, 41, 'Emergency Assessment', '2026-10-23 08:35', 'Weakness and slurred speech', 'Right-sided weakness', 'Stroke symptoms', 'Cerebral infarction', 'Head CT', 'Stroke protocol', 'Fictional stroke assessment.'),
(50, 42, 'Emergency Assessment', '2026-10-24 17:00', 'Hip pain after fall', 'Unable to bear weight', 'Fracture suspected', 'Femoral neck fracture', 'Hip X-ray', 'Analgesia and orthopedic review', 'Fictional fracture assessment.'),
(51, 43, 'Urgent Care Note', '2026-10-25 09:45', 'Chest pressure', 'Regular heart rhythm', 'Cardiac evaluation required', 'Acute coronary syndrome', 'ECG and troponin', 'Cardiac monitoring', 'Fictional cardiac assessment.'),
(52, 44, 'Emergency Assessment', '2026-10-26 12:30', 'Wheezing', 'Reduced air entry', 'Asthma flare', 'Asthma exacerbation', 'Peak flow measurement', 'Nebulized bronchodilator', 'Fictional asthma assessment.'),
(53, 45, 'Emergency Assessment', '2026-10-27 06:15', 'Abdominal pain and nausea', 'Generalized tenderness', 'Surgical cause to rule out', 'Acute abdominal condition', 'Abdominal CT', 'NPO and IV fluids', 'Fictional abdominal assessment.'),
(54, 46, 'Emergency Assessment', '2026-10-28 18:50', 'Fever and chills', 'Hypotension and tachycardia', 'Sepsis suspected', 'Sepsis', 'Blood cultures and lactate', 'IV fluids and antibiotics', 'Fictional admission remains active.'),
(55, 47, 'Urgent Care Note', '2026-10-29 10:40', 'Back pain after lifting', 'Paraspinal tenderness', 'No weakness noted', 'Mechanical back pain', 'Clinical examination', 'Analgesia and mobility advice', 'Fictional back pain assessment.'),
(56, 48, 'Emergency Assessment', '2026-10-30 07:35', 'Cough and shortness of breath', 'Crackles and low oxygen', 'Possible pneumonia', 'Pneumonia', 'Chest X-ray and blood tests', 'Oxygen and antibiotics', 'Fictional respiratory assessment.'),
(57, 49, 'Urgent Care Note', '2026-10-31 14:25', 'Abdominal discomfort', 'Mild abdominal tenderness', 'No acute findings', 'Abdominal pain', 'Laboratory evaluation', 'Observation', 'Fictional abdominal visit.'),
(58, 50, 'Emergency Assessment', '2026-11-01 10:10', 'Chest pressure and nausea', 'Diaphoretic', 'ECG changes under review', 'Acute myocardial infarction', 'ECG, troponin, chest X-ray', 'Urgent cardiac treatment', 'Fictional cardiac admission.'),
(59, 51, 'Urgent Care Note', '2026-11-02 12:00', 'Fever and flank tenderness', 'Flank tenderness', 'Urinary infection likely', 'Urinary tract infection', 'Urine culture and ultrasound', 'Antibiotics and fluids', 'Fictional urinary visit.'),
(60, 52, 'Emergency Assessment', '2026-11-03 09:00', 'Headache and vision change', 'Alert and oriented', 'Neurologic cause to evaluate', 'Headache', 'Head CT', 'Observation and reassessment', 'Fictional neurologic assessment.'),
(61, 53, 'Emergency Assessment', '2026-11-04 15:35', 'Shortness of breath', 'Increased work of breathing', 'Hypoxemia', 'Acute respiratory failure', 'Chest X-ray', 'Oxygen and respiratory support', 'Fictional respiratory admission.'),
(62, 54, 'Emergency Assessment', '2026-11-05 04:40', 'Fever and confusion', 'Hypotension and poor perfusion', 'Septic shock', 'Sepsis', 'Blood cultures and lactate', 'Resuscitation and antibiotics', 'Fictional fatal admission.'),
(63, 55, 'Urgent Care Note', '2026-11-06 14:05', 'Knee pain and swelling', 'Joint swelling, stable gait', 'Soft-tissue injury possible', 'Knee injury', 'Knee X-ray', 'Ice and analgesia', 'Fictional sports injury.'),
(64, 56, 'Emergency Assessment', '2026-11-07 08:25', 'Persistent cough', 'Mild crackles', 'Respiratory infection suspected', 'Pneumonia', 'Chest X-ray', 'Observation and treatment', 'Fictional admission remains active.'),
(65, 57, 'Urgent Care Note', '2026-11-08 10:50', 'Flank pain and urinary frequency', 'Flank tenderness', 'Infection suspected', 'Urinary tract infection', 'Urinalysis and ultrasound', 'Antibiotics and hydration', 'Fictional repeat visit.'),
(66, 58, 'Emergency Assessment', '2026-11-09 07:45', 'Dizziness', 'No focal neurologic deficit', 'Stable examination', 'Dizziness', 'ECG and clinical reassessment', 'Observation', 'Fictional dizziness assessment.'),
(67, 59, 'Emergency Assessment', '2026-11-10 13:15', 'Right upper quadrant pain', 'Localized tenderness', 'Gallbladder disease suspected', 'Abdominal pain', 'Abdominal ultrasound', 'Surgical review', 'Fictional gallbladder assessment.'),
(68, 60, 'Urgent Care Note', '2026-11-11 10:00', 'Skin redness and tenderness', 'Localized erythema', 'Cellulitis suspected', 'Skin infection', 'Clinical examination', 'Oral antibiotics', 'Fictional skin infection assessment.'),
(69, 61, 'Emergency Assessment', '2026-11-12 07:15', 'Pain after fall', 'Reduced mobility', 'Fracture suspected', 'Femoral neck fracture', 'Hip X-ray', 'Analgesia and imaging', 'Fictional repeat fall assessment.'),
(70, 62, 'Emergency Assessment', '2026-11-13 02:35', 'Unresponsive', 'Resuscitation unsuccessful', 'Cardiac arrest', 'Acute myocardial infarction', 'Emergency resuscitation', 'Resuscitation attempted', 'Fictional fatal cardiac event.');

INSERT INTO Diagnostic_Order (
    diagnostic_order_id, admission_id, requesting_physician, requested_examination,
    request_date_time, clinical_reason_for_examination, priority, order_status
) VALUES
(30, 33, 1, 'Chest X-ray', '2026-10-16 08:30', 'Assess chest discomfort', 'Routine', 'Completed'),
(31, 35, 3, 'Chest X-ray', '2026-10-17 11:30', 'Evaluate fever and cough', 'High', 'Completed'),
(32, 36, 3, 'Abdominal CT', '2026-10-18 08:15', 'Evaluate suspected appendicitis', 'Urgent', 'Completed'),
(33, 37, 4, 'Shoulder X-ray', '2026-10-19 14:50', 'Assess fall injury', 'Routine', 'Completed'),
(34, 38, 2, 'Chest X-ray', '2026-10-20 07:00', 'Evaluate respiratory distress', 'Urgent', 'Completed'),
(35, 39, 1, 'Renal ultrasound', '2026-10-21 13:30', 'Evaluate urinary symptoms', 'High', 'Completed'),
(36, 41, 2, 'Head CT', '2026-10-23 08:45', 'Stroke assessment', 'Urgent', 'Completed'),
(37, 42, 4, 'Hip X-ray', '2026-10-24 17:10', 'Assess possible fracture', 'Urgent', 'Completed'),
(38, 43, 1, 'Chest X-ray', '2026-10-25 10:00', 'Assess chest symptoms', 'High', 'Completed'),
(39, 44, 3, 'Chest X-ray', '2026-10-26 12:45', 'Evaluate asthma symptoms', 'Routine', 'Completed'),
(40, 45, 5, 'Abdominal CT', '2026-10-27 06:30', 'Evaluate abdominal pain', 'Urgent', 'Completed'),
(41, 46, 2, 'Chest X-ray', '2026-10-28 19:00', 'Assess infection source', 'Urgent', 'In Progress'),
(42, 48, 3, 'Chest X-ray', '2026-10-30 07:45', 'Evaluate low oxygen saturation', 'Urgent', 'Completed'),
(43, 50, 5, 'Chest X-ray', '2026-11-01 10:20', 'Assess chest pain', 'Urgent', 'Completed'),
(44, 51, 2, 'Renal ultrasound', '2026-11-02 12:10', 'Evaluate flank tenderness', 'High', 'Completed'),
(45, 52, 1, 'Head CT', '2026-11-03 09:10', 'Evaluate headache and vision change', 'High', 'Completed'),
(46, 53, 3, 'Chest X-ray', '2026-11-04 15:45', 'Evaluate respiratory distress', 'Urgent', 'Completed'),
(47, 54, 2, 'Chest X-ray', '2026-11-05 04:50', 'Assess suspected infection', 'Urgent', 'Completed'),
(48, 56, 3, 'Chest X-ray', '2026-11-07 08:35', 'Evaluate cough', 'High', 'In Progress'),
(49, 59, 5, 'Abdominal ultrasound', '2026-11-10 13:25', 'Evaluate right upper quadrant pain', 'High', 'Completed');

INSERT INTO Radiology_Report (
    examination_id, diagnostic_order_id, examination_type, examination_date_time,
    body_area_examined, referring_physician, radiology_technician, examination_status,
    medical_images_link, findings, interpretation, conclusion
) VALUES
(32, 30, 'X-ray', '2026-10-16 08:50', 'Chest', 1, 8, 'Completed', 'https://example.org/synthetic-images/exam-32', 'No focal opacity identified.', 'Cardiac silhouette within expected limits.', 'No acute chest finding.'),
(33, 31, 'X-ray', '2026-10-17 11:50', 'Chest', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-33', 'Mild basilar opacity.', 'Possible early infection.', 'Correlate clinically.'),
(34, 32, 'CT', '2026-10-18 08:35', 'Abdomen', 3, 8, 'Completed', 'https://example.org/synthetic-images/exam-34', 'Appendiceal enlargement noted.', 'Findings support appendicitis.', 'Surgical consultation advised.'),
(35, 33, 'X-ray', '2026-10-19 15:10', 'Shoulder', 4, 9, 'Completed', 'https://example.org/synthetic-images/exam-35', 'No displaced fracture.', 'Soft-tissue swelling present.', 'No acute bony injury.'),
(36, 34, 'X-ray', '2026-10-20 07:20', 'Chest', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-36', 'Bilateral patchy opacities.', 'Findings may reflect infection.', 'Correlate with oxygenation.'),
(37, 35, 'Ultrasound', '2026-10-21 13:50', 'Kidneys', 1, 9, 'Completed', 'https://example.org/synthetic-images/exam-37', 'No hydronephrosis.', 'No obstruction identified.', 'No sonographic obstruction.'),
(38, 36, 'CT', '2026-10-23 09:00', 'Head', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-38', 'No acute hemorrhage.', 'No large acute territorial finding.', 'Continue stroke evaluation.'),
(39, 37, 'X-ray', '2026-10-24 17:25', 'Hip', 4, 9, 'Completed', 'https://example.org/synthetic-images/exam-39', 'Femoral neck fracture identified.', 'Imaging confirms fracture.', 'Orthopedic management advised.'),
(40, 38, 'X-ray', '2026-10-25 10:15', 'Chest', 1, 8, 'Completed', 'https://example.org/synthetic-images/exam-40', 'No focal opacity.', 'No acute cardiopulmonary finding.', 'No acute chest finding.'),
(41, 39, 'X-ray', '2026-10-26 13:00', 'Chest', 3, 9, 'Completed', 'https://example.org/synthetic-images/exam-41', 'Lungs are clear.', 'No acute pulmonary finding.', 'No acute chest finding.'),
(42, 40, 'CT', '2026-10-27 06:45', 'Abdomen', 5, 8, 'Completed', 'https://example.org/synthetic-images/exam-42', 'No acute obstruction.', 'No acute process identified.', 'Clinical follow-up advised.'),
(43, 41, 'X-ray', '2026-10-28 19:15', 'Chest', 2, 9, 'In Progress', NULL, 'Preliminary images acquired.', 'Interpretation pending.', 'Report pending.'),
(44, 42, 'X-ray', '2026-10-30 08:00', 'Chest', 3, 8, 'Completed', 'https://example.org/synthetic-images/exam-44', 'Right lower opacity.', 'Possible pneumonia.', 'Correlate clinically.'),
(45, 43, 'X-ray', '2026-11-01 10:35', 'Chest', 5, 9, 'Completed', 'https://example.org/synthetic-images/exam-45', 'No acute opacity.', 'No acute cardiopulmonary finding.', 'No acute chest finding.'),
(46, 44, 'Ultrasound', '2026-11-02 12:25', 'Kidneys', 2, 8, 'Completed', 'https://example.org/synthetic-images/exam-46', 'No hydronephrosis.', 'No obstruction identified.', 'No sonographic obstruction.'),
(47, 45, 'CT', '2026-11-03 09:25', 'Head', 1, 9, 'Completed', 'https://example.org/synthetic-images/exam-47', 'No acute hemorrhage.', 'No acute intracranial finding.', 'Clinical correlation advised.'),
(48, 46, 'X-ray', '2026-11-04 16:00', 'Chest', 3, 8, 'Completed', 'https://example.org/synthetic-images/exam-48', 'Bilateral diffuse opacities.', 'Possible pulmonary edema or infection.', 'Urgent clinical correlation advised.'),
(49, 47, 'X-ray', '2026-11-05 05:00', 'Chest', 2, 9, 'Completed', 'https://example.org/synthetic-images/exam-49', 'Diffuse bilateral opacity.', 'Severe infection possible.', 'Correlate with resuscitation.'),
(50, 48, 'X-ray', '2026-11-07 08:50', 'Chest', 3, 8, 'In Progress', NULL, 'Images acquired; report pending.', 'Interpretation pending.', 'Report pending.'),
(51, 49, 'Ultrasound', '2026-11-10 13:40', 'Abdomen', 5, 9, 'Completed', 'https://example.org/synthetic-images/exam-51', 'Gallbladder wall thickening noted.', 'Findings may indicate inflammation.', 'Surgical review advised.'),
(52, 30, 'X-ray', '2026-10-16 08:55', 'Chest', 1, 9, 'Completed', 'https://example.org/synthetic-images/exam-52', 'Additional chest view acquired.', 'Additional view reviewed with first image.', 'Combined report recorded.'),
(53, 40, 'X-ray', '2026-10-27 06:50', 'Chest', 3, 8, 'Completed', 'https://example.org/synthetic-images/exam-53', 'Additional chest view acquired.', 'Additional view reviewed with first image.', 'Combined report recorded.');

INSERT INTO Diagnosis_Record (
    diagnosis_id, admission_id, icd_9_code, diagnosis_date_time, diagnosis_type, diagnosing_physician
) VALUES
(47, 33, '414.01', '2026-10-16 09:00', 'Primary', 1),
(48, 34, '493.90', '2026-10-18 10:00', 'Primary', 2),
(49, 35, '486', '2026-10-17 12:30', 'Primary', 3),
(50, 36, '540.9', '2026-10-18 09:15', 'Primary', 3),
(51, 37, '820.8', '2026-10-19 16:00', 'Primary', 4),
(52, 38, '518.81', '2026-10-20 08:00', 'Primary', 2),
(53, 39, '599.0', '2026-10-21 14:00', 'Primary', 1),
(54, 40, '493.90', '2026-10-22 11:30', 'Primary', 3),
(55, 41, '434.91', '2026-10-23 09:15', 'Primary', 2),
(56, 42, '820.8', '2026-10-24 18:00', 'Primary', 4),
(57, 43, '410.91', '2026-10-25 11:00', 'Primary', 1),
(58, 44, '493.90', '2026-10-26 13:30', 'Primary', 3),
(59, 45, '789.00', '2026-10-27 07:30', 'Primary', 5),
(60, 46, '038.9', '2026-10-28 20:00', 'Primary', 2),
(61, 47, '789.00', '2026-10-29 11:30', 'Primary', 4),
(62, 48, '486', '2026-10-30 09:00', 'Primary', 3),
(63, 49, '789.00', '2026-10-31 15:00', 'Primary', 1),
(64, 50, '410.91', '2026-11-01 11:00', 'Primary', 5),
(65, 51, '599.0', '2026-11-02 13:00', 'Primary', 2),
(66, 52, '789.00', '2026-11-03 10:00', 'Primary', 1),
(67, 53, '518.81', '2026-11-04 17:00', 'Primary', 3),
(68, 54, '038.9', '2026-11-05 05:15', 'Primary', 2),
(69, 55, '820.8', '2026-11-06 15:00', 'Primary', 4),
(70, 56, '486', '2026-11-07 09:15', 'Primary', 3),
(71, 57, '599.0', '2026-11-08 12:00', 'Primary', 2),
(72, 58, '428.0', '2026-11-09 09:00', 'Primary', 1),
(73, 59, '789.00', '2026-11-10 14:00', 'Primary', 5),
(74, 60, '486', '2026-11-11 10:30', 'Primary', 4),
(75, 61, '820.8', '2026-11-12 08:00', 'Primary', 3),
(76, 62, '410.91', '2026-11-13 03:00', 'Primary', 1),
(77, 33, '401.9', '2026-10-16 09:15', 'Secondary', 1),
(78, 36, '401.9', '2026-10-18 09:30', 'Secondary', 3),
(79, 38, '491.21', '2026-10-20 08:15', 'Secondary', 2),
(80, 42, '401.9', '2026-10-24 18:15', 'Secondary', 4),
(81, 46, '518.81', '2026-10-28 20:15', 'Secondary', 2),
(82, 48, '518.81', '2026-10-30 09:15', 'Secondary', 3),
(83, 50, '414.01', '2026-11-01 11:15', 'Secondary', 5),
(84, 54, '518.81', '2026-11-05 05:30', 'Secondary', 2),
(85, 59, '401.9', '2026-11-10 14:15', 'Secondary', 5),
(86, 62, '428.0', '2026-11-13 03:15', 'Secondary', 1);

INSERT INTO Surgical_Procedure (
    surgical_procedure_id, admission_id, procedure_type, procedure_date_time,
    performing_surgeon, procedure_status, procedure_notes
) VALUES
(10, 36, 'Laparoscopic appendectomy', '2026-10-18 12:00', 5, 'Completed', 'Fictional uncomplicated appendectomy.'),
(11, 42, 'Hip fracture repair', '2026-10-25 09:00', 4, 'Completed', 'Fictional repair with stable postoperative course.'),
(12, 45, 'Diagnostic laparoscopy', '2026-10-27 10:00', 5, 'Completed', 'Fictional procedure for abdominal symptoms.'),
(13, 50, 'Percutaneous coronary intervention', '2026-11-01 13:00', 4, 'Completed', 'Fictional cardiac intervention.'),
(14, 59, 'Laparoscopic cholecystectomy', '2026-11-11 08:00', 5, 'Completed', 'Fictional gallbladder surgery.'),
(15, 61, 'Wound repair', '2026-11-12 10:00', 4, 'Completed', 'Fictional injury repair.');

INSERT INTO Unit_Stay (
    unit_stay_id, admission_id, unit_id, ward_and_room, bed_number, entry_date_time,
    exit_date_time, responsible_physician, reason_for_transfer
) VALUES
(78, 33, 1, 'ER-A / Room 7', '7', '2026-10-16 08:00', '2026-10-16 09:30', 1, 'Initial cardiac assessment'),
(79, 34, 1, 'ER-B / Room 8', '8', '2026-10-18 09:10', '2026-10-18 11:00', 2, 'Headache assessment'),
(80, 35, 1, 'ER-C / Room 1', '1', '2026-10-17 11:00', '2026-10-17 12:30', 3, 'Respiratory evaluation'),
(81, 36, 1, 'ER-D / Room 2', '2', '2026-10-18 07:45', '2026-10-18 10:00', 3, 'Surgical evaluation'),
(82, 37, 1, 'ER-A / Room 4', '4', '2026-10-19 14:20', '2026-10-19 16:00', 4, 'Fall injury evaluation'),
(83, 38, 5, 'ICU / Room 8', '8', '2026-10-20 06:30', '2026-10-22 08:00', 2, 'Respiratory support'),
(84, 39, 1, 'ER-B / Room 2', '2', '2026-10-21 13:00', '2026-10-21 15:00', 1, 'Urinary infection assessment'),
(85, 40, 4, 'Ward 3F / Room 5', '5F', '2026-10-22 10:05', NULL, 3, 'Ongoing respiratory care'),
(86, 41, 1, 'ER-C / Room 4', '4', '2026-10-23 08:15', '2026-10-23 10:00', 2, 'Stroke protocol'),
(87, 42, 1, 'ER-D / Room 6', '6', '2026-10-24 16:40', '2026-10-24 19:00', 4, 'Fracture evaluation'),
(88, 43, 2, 'CCU / Room 5', '5', '2026-10-25 09:25', '2026-10-27 09:00', 1, 'Cardiac monitoring'),
(89, 44, 1, 'ER-A / Room 5', '5', '2026-10-26 12:10', '2026-10-26 14:00', 3, 'Asthma treatment'),
(90, 45, 1, 'ER-B / Room 6', '6', '2026-10-27 05:55', '2026-10-27 08:00', 5, 'Abdominal assessment'),
(91, 46, 5, 'ICU / Room 9', '9', '2026-10-28 18:30', NULL, 2, 'Ongoing critical care'),
(92, 47, 1, 'ER-C / Room 6', '6', '2026-10-29 10:20', '2026-10-29 12:00', 4, 'Back pain evaluation'),
(93, 48, 3, 'MICU / Room 4', '4', '2026-10-30 07:15', '2026-11-02 09:00', 3, 'Respiratory monitoring'),
(94, 49, 1, 'ER-D / Room 7', '7', '2026-10-31 14:05', '2026-10-31 16:00', 1, 'Abdominal observation'),
(95, 50, 2, 'CCU / Room 6', '6', '2026-11-01 09:50', '2026-11-04 09:00', 5, 'Post-intervention monitoring'),
(96, 51, 1, 'ER-A / Room 8', '8', '2026-11-02 11:30', '2026-11-02 13:30', 2, 'Urinary assessment'),
(97, 52, 1, 'ER-B / Room 8', '8', '2026-11-03 08:40', '2026-11-03 10:30', 1, 'Neurologic assessment'),
(98, 53, 5, 'ICU / Room 10', '10', '2026-11-04 15:15', '2026-11-07 09:00', 3, 'Respiratory support'),
(99, 54, 1, 'ER-C / Room 8', '8', '2026-11-05 04:20', '2026-11-05 05:30', 2, 'Resuscitation'),
(100, 55, 1, 'ER-D / Room 1', '1', '2026-11-06 13:45', '2026-11-06 15:30', 4, 'Knee injury assessment'),
(101, 56, 4, 'Ward 4A / Room 3', '3A', '2026-11-07 08:05', NULL, 3, 'Ongoing respiratory observation'),
(102, 57, 1, 'ER-A / Room 9', '9', '2026-11-08 10:30', '2026-11-08 12:30', 2, 'Flank pain evaluation'),
(103, 58, 1, 'ER-B / Room 9', '9', '2026-11-09 07:25', '2026-11-09 09:15', 1, 'Dizziness evaluation'),
(104, 59, 6, 'OR 7', '7', '2026-11-10 12:55', '2026-11-11 10:00', 5, 'Gallbladder surgery'),
(105, 60, 1, 'ER-C / Room 9', '9', '2026-11-11 09:35', '2026-11-11 11:00', 4, 'Skin infection assessment'),
(106, 61, 1, 'ER-D / Room 2', '2', '2026-11-12 06:50', '2026-11-12 09:00', 3, 'Fracture assessment'),
(107, 62, 5, 'ICU / Room 11', '11', '2026-11-13 02:15', '2026-11-13 07:00', 1, 'Resuscitation and critical care'),
(108, 36, 4, 'Ward 1A / Room 8', '8A', '2026-10-18 10:15', '2026-10-20 09:00', 3, 'Postoperative recovery'),
(109, 38, 4, 'Ward 2A / Room 9', '9A', '2026-10-20 08:15', '2026-10-23 09:00', 2, 'Step-down respiratory care'),
(110, 42, 4, 'Ward 3A / Room 7', '7A', '2026-10-24 19:15', '2026-10-29 09:00', 4, 'Postoperative rehabilitation'),
(111, 45, 4, 'Ward 4A / Room 6', '6A', '2026-10-27 08:15', '2026-10-30 09:00', 5, 'Recovery after procedure'),
(112, 50, 4, 'Ward 5A / Room 5', '5A', '2026-11-01 11:15', '2026-11-05 09:00', 5, 'Stable after cardiac treatment'),
(113, 54, 4, 'Ward 5B / Room 1', '1B', '2026-11-05 05:40', '2026-11-05 07:00', 2, 'Critical care following resuscitation'),
(114, 59, 4, 'Ward 2B / Room 4', '4B', '2026-11-11 10:15', '2026-11-14 09:00', 5, 'Postoperative recovery'),
(115, 61, 4, 'Ward 3B / Room 6', '6B', '2026-11-12 09:15', '2026-11-15 09:00', 3, 'Recovery and mobility support'),
(116, 33, 4, 'Ward 1B / Room 3', '3B', '2026-10-16 09:45', '2026-10-18 09:00', 1, 'Observation after assessment'),
(117, 35, 4, 'Ward 2C / Room 5', '5C', '2026-10-17 12:45', '2026-10-19 09:00', 3, 'Antibiotic treatment');

INSERT INTO General_Ward (
    progress_note_id, unit_stay_id, nursing_monitoring_notes, physician_follow_up_examination,
    medications_and_treatments_administered, progress_notes, additional_tests_requested,
    recovery_evaluation
) VALUES
(23, 108, 'Vitals stable', 'Abdominal tenderness reduced', 'Analgesia and fluids', 'Tolerating meals', 'None', 'Recovering after surgery'),
(24, 109, 'Oxygen monitored', 'Breath sounds improving', 'Respiratory treatments continued', 'Work of breathing reduced', 'Repeat oxygen check', 'Improving'),
(25, 110, 'Mobility supported', 'Orthopedic review completed', 'Analgesia administered', 'Walking with assistance', 'Physiotherapy assessment', 'Progressing'),
(26, 111, 'Pain and wound checks', 'Incision clean', 'Medication administered as ordered', 'Mobilizing safely', 'None', 'Recovering'),
(27, 112, 'Cardiac observations continued', 'No recurrent chest pain', 'Cardiac medications continued', 'Stable during observation', 'Follow-up ECG', 'Improving'),
(28, 113, 'Close monitoring', 'Critical status reviewed', 'Supportive treatment', 'Care ongoing', 'Repeat vital signs', 'Critical'),
(29, 114, 'Wound care completed', 'Abdominal discomfort reduced', 'Analgesia provided', 'Diet advanced', 'None', 'Recovering after surgery'),
(30, 115, 'Mobility assistance provided', 'Extremity circulation intact', 'Pain relief administered', 'Walking with support', 'Physiotherapy review', 'Progressing'),
(31, 116, 'Vitals checked regularly', 'No acute cardiac findings', 'Medication review completed', 'Symptoms resolved', 'None', 'Stable for discharge'),
(32, 117, 'Temperature monitored', 'Lung exam improving', 'Antibiotics continued', 'Cough reduced', 'Follow-up chest assessment', 'Improving');

INSERT INTO Discharge_Record (
    discharge_record_id, admission_id, discharge_date_time, discharge_destination,
    patients_condition_at_discharge, prescribed_medications, follow_up_instructions,
    scheduled_follow_up_appointments, responsible_physician
) VALUES
(30, 33, '2026-10-18 10:00', 'Home', 'Chest discomfort resolved', 'Continue current medications', 'Return for recurrent chest pain', '2026-10-25 10:00 Cardiology clinic', 1),
(31, 34, '2026-10-19 11:00', 'Home', 'Headache improved', 'Use medication as directed', 'Rest and maintain hydration', '2026-10-26 10:00 Family physician', 2),
(32, 35, '2026-10-19 10:00', 'Home', 'Fever reduced', 'Complete antibiotic course', 'Return if breathing worsens', '2026-10-26 09:00 Family physician', 3),
(33, 36, '2026-10-20 10:00', 'Home', 'Recovering after appendectomy', 'Analgesia as needed', 'Follow postoperative instructions', '2026-10-27 10:00 Surgery clinic', 3),
(34, 37, '2026-10-21 10:00', 'Home', 'Shoulder pain improved', 'Acetaminophen as needed', 'Return if mobility worsens', '2026-10-28 10:00 Orthopedic clinic', 4),
(35, 38, '2026-10-23 10:00', 'Home', 'Breathing improved', 'Continue respiratory medications', 'Follow up for oxygen reassessment', '2026-10-30 10:00 Respiratory clinic', 2),
(36, 39, '2026-10-23 10:00', 'Home', 'Urinary symptoms improved', 'Complete antibiotics', 'Maintain hydration', '2026-10-30 09:00 Family physician', 1),
(37, 41, '2026-10-26 10:00', 'Rehabilitation Center', 'Weakness improving', 'Continue prescribed therapy', 'Continue rehabilitation', '2026-11-02 13:00 Neurology clinic', 2),
(38, 42, '2026-10-29 10:00', 'Rehabilitation Center', 'Stable after hip repair', 'Analgesia as needed', 'Continue physiotherapy', '2026-11-05 14:00 Orthopedic clinic', 4),
(39, 43, '2026-10-28 10:00', 'Home', 'Chest pain resolved', 'Continue cardiac medications', 'Cardiology follow-up', '2026-11-04 10:00 Cardiology clinic', 1),
(40, 44, '2026-10-28 10:00', 'Home', 'Wheezing improved', 'Use rescue inhaler as needed', 'Avoid known triggers', '2026-11-04 10:00 Family physician', 3),
(41, 45, '2026-10-30 10:00', 'Home', 'Abdominal symptoms improved', 'Analgesia as needed', 'Return if pain worsens', '2026-11-06 10:00 Surgery clinic', 5),
(42, 47, '2026-10-31 10:00', 'Home', 'Back pain reduced', 'Use analgesia as directed', 'Follow mobility advice', '2026-11-07 10:00 Family physician', 4),
(43, 48, '2026-11-02 10:00', 'Home', 'Breathing improved', 'Complete antibiotics', 'Return if shortness of breath recurs', '2026-11-09 09:00 Family physician', 3),
(44, 49, '2026-11-03 10:00', 'Home', 'Abdominal discomfort resolved', NULL, 'Follow up if symptoms return', '2026-11-10 10:00 Family physician', 1),
(45, 50, '2026-11-05 10:00', 'Home', 'Stable after cardiac intervention', 'Continue cardiac medications', 'Cardiac rehabilitation', '2026-11-12 10:00 Cardiology clinic', 5),
(46, 51, '2026-11-05 10:00', 'Home', 'Urinary symptoms improved', 'Complete antibiotic course', 'Maintain hydration', '2026-11-12 09:00 Family physician', 2),
(47, 52, '2026-11-04 10:00', 'Home', 'Headache improved', NULL, 'Return for new neurologic symptoms', '2026-11-11 10:00 Family physician', 1),
(48, 53, '2026-11-07 10:00', 'Home', 'Breathing stable', 'Continue respiratory therapy', 'Follow respiratory plan', '2026-11-14 10:00 Respiratory clinic', 3),
(49, 54, '2026-11-05 07:15', 'Deceased', 'Deceased during the hospital stay', NULL, NULL, NULL, 2),
(50, 55, '2026-11-07 10:00', 'Home', 'Knee pain improved', 'Ice and analgesia as needed', 'Return if swelling worsens', '2026-11-14 10:00 Orthopedic clinic', 4),
(51, 57, '2026-11-10 10:00', 'Home', 'Flank pain improved', 'Complete antibiotic course', 'Follow up if fever returns', '2026-11-17 09:00 Family physician', 2),
(52, 58, '2026-11-10 10:00', 'Home', 'Dizziness resolved', NULL, 'Return if symptoms recur', '2026-11-17 10:00 Family physician', 1),
(53, 59, '2026-11-14 10:00', 'Home', 'Stable after gallbladder surgery', 'Analgesia as needed', 'Follow postoperative plan', '2026-11-21 10:00 Surgery clinic', 5),
(54, 60, '2026-11-13 10:00', 'Home', 'Skin redness reduced', 'Complete antibiotics', 'Return if redness spreads', '2026-11-18 10:00 Family physician', 4),
(55, 61, '2026-11-15 10:00', 'Rehabilitation Center', 'Stable after fracture treatment', 'Analgesia as needed', 'Continue mobility training', '2026-11-22 14:00 Orthopedic clinic', 3),
(56, 62, '2026-11-13 07:15', 'Deceased', 'Deceased during resuscitation', NULL, NULL, NULL, 1);
