-- Data sources and generation notes
-- Source for Patient, Admission, Triage_and_Assessment, Clinical_Note,
-- Diagnostic_Order, Radiology_Examination, Diagnostic_Record,
-- Surgical_Procedure, Unit_Stay, General_Ward, and Discharge_Record:
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
-- psql -d <database> -f soen363_sql_data.sql -f soen363_sample_data.sql.

INSERT INTO Patient (
    patient_id, health_insurance_number, full_name, date_of_birth,
    gender, address, telephone_number, emergency_contact_information, life_status
) VALUES
(1, 710000001, 'Ava Laurent',       '1968-04-12', 'Female', '101 Fictional Rue, Montreal, QC', '5145551001', 'Noah Laurent (spouse), 5145551101', 'Alive'),
(2, 710000002, 'Noah Chen',         '1954-09-30', 'Male',   '202 Sample Avenue, Laval, QC',    '4505551002', 'Mei Chen (daughter), 4505551102', 'Alive'),
(3, 710000003, 'Mia Haddad',        '1992-02-18', 'Female', '303 Example Street, Montreal, QC','5145551003', 'Samir Haddad (brother), 5145551103', 'Alive'),
(4, 710000004, 'Liam Roy',          '1941-11-05', 'Male',   '404 Imaginary Road, Longueuil, QC','4505551004','Claire Roy (daughter), 4505551104', 'Alive'),
(5, 710000005, 'Emma Park',         '2001-07-22', 'Female', '505 Placeholder Lane, Brossard, QC','4505551005','Jin Park (parent), 4505551105', 'Alive'),
(6, 710000006, 'Oliver Nguyen',     '1960-01-09', 'Male',   '606 Mock Boulevard, Montreal, QC','5145551006', 'Linh Nguyen (spouse), 5145551106', 'Alive'),
(7, 710000007, 'Zoe Martin',        '1947-06-14', 'Female', '707 Fictional Crescent, Laval, QC','4505551007','Paul Martin (son), 4505551107', 'Deceased'),
(8, 710000008, 'Ethan Tremblay',    '1958-12-01', 'Male',   '808 Sample Court, Montreal, QC',  '5145551008', 'Rose Tremblay (spouse), 5145551108', 'Alive'),
(9, 710000009, 'Sofia Diallo',      '1983-03-27', 'Female', '909 Example Place, Westmount, QC','5145551009', 'Aminata Diallo (sister), 5145551109', 'Alive'),
(10,710000010, 'Lucas Bouchard',    '1976-10-10', 'Male',   '110 Imaginary Drive, Montreal, QC','5145551010','Julie Bouchard (spouse), 5145551110', 'Alive'),
(11,710000011, 'Maya Wilson',       '1939-05-16', 'Female', '111 Placeholder Terrace, Laval, QC','4505551011','Eli Wilson (son), 4505551111', 'Alive'),
(12,710000012, 'Jules Beaulieu',    '1998-08-03', 'Nonbinary','112 Fictional Walk, Montreal, QC','5145551012','Camille Beaulieu (friend), 5145551112', 'Alive');

INSERT INTO ICD9_Dictionary (
    icd_9_code, official_diagnosis_title, description, disease_category
) VALUES
('410.91', 'Acute myocardial infarction, unspecified', 'Acute heart attack, site unspecified', 'Circulatory'),
('428.0',  'Congestive heart failure, unspecified', 'Heart failure without further specification', 'Circulatory'),
('486',    'Pneumonia, organism unspecified', 'Pneumonia with no organism specified', 'Respiratory'),
('038.9',  'Unspecified septicemia', 'Systemic infection, organism unspecified', 'Infectious'),
('540.9',  'Acute appendicitis without mention of peritonitis', 'Acute inflammation of the appendix', 'Digestive'),
('820.8',  'Closed fracture of unspecified part of neck of femur', 'Closed fracture of the hip region', 'Injury'),
('493.90', 'Asthma, unspecified', 'Asthma without further specification', 'Respiratory'),
('434.91', 'Cerebral artery occlusion with infarction', 'Ischemic stroke', 'Circulatory'),
('491.21', 'Obstructive chronic bronchitis with exacerbation', 'COPD with acute exacerbation', 'Respiratory'),
('599.0',  'Urinary tract infection, site not specified', 'Urinary tract infection', 'Genitourinary'),
('414.01', 'Coronary atherosclerosis of native coronary artery', 'Coronary artery disease', 'Circulatory'),
('789.00', 'Abdominal pain, unspecified site', 'Abdominal pain without further specification', 'Symptoms'),
('518.81', 'Acute respiratory failure', 'Acute failure of respiratory function', 'Respiratory'),
('250.00', 'Diabetes mellitus without complication, type II or unspecified type', 'Type 2 diabetes without documented complication', 'Endocrine'),
('401.9',  'Essential hypertension, unspecified', 'High blood pressure without further specification', 'Circulatory');

INSERT INTO Admission (
    admission_id, patient_id, admission_date_time,
    reason_for_visit, admission_type, admission_source, insurance_info,
    patient_current_condition, admitting_healthcare_professional_name,
    final_admission_status
) VALUES
(1,  1, '2026-01-05 08:15', 'Severe chest pain', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Chest pain and diaphoresis', 'Dr. Mira Patel', 'Discharged'),
(2,  1, '2026-03-17 14:00', 'Worsening shortness of breath', 'Urgent', 'Family Doctor Referral', 'Fictional Plan A', 'Peripheral edema and dyspnea', 'Dr. Jonah Reed', 'Discharged'),
(3,  1, '2026-05-02 09:00', 'Intermittent chest discomfort', 'Elective', 'Walk-in', 'Fictional Plan A', 'Stable, mild chest discomfort', 'Dr. Mira Patel', 'Discharged'),
(4,  1, '2026-08-01 10:00', 'Fever and productive cough', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Febrile with productive cough', 'Dr. Elena Roy', 'Discharged'),
(5,  2, '2026-02-01 09:30', 'Fever with low blood pressure', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Febrile and hypotensive', 'Dr. Jonah Reed', 'Discharged'),
(6,  3, '2026-02-12 18:00', 'Right lower abdominal pain', 'Emergency', 'Emergency Department', 'Fictional Plan C', 'Abdominal pain and nausea', 'Dr. Elena Roy', 'Discharged'),
(7,  4, '2026-03-20 07:45', 'Fall with right hip pain', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Unable to bear weight', 'Dr. Mira Patel', 'Discharged'),
(8,  5, '2026-04-11 19:00', 'Wheezing and cough', 'Emergency', 'Walk-in', 'Fictional Plan C', 'Wheezing without hypoxemia', 'Dr. Elena Roy', 'Discharged'),
(9,  6, '2026-04-22 06:45', 'Sudden weakness and slurred speech', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Right-sided weakness and aphasia', 'Dr. Jonah Reed', 'Discharged'),
(10, 7, '2026-05-04 03:20', 'Severe dyspnea and edema', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Acute pulmonary edema', 'Dr. Mira Patel', 'Deceased'),
(11, 8, '2026-05-22 10:00', 'Acute respiratory distress', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Low oxygen saturation; treatment ongoing', 'Dr. Elena Roy', 'Admitted'),
(12, 9, '2026-06-03 11:15', 'Painful urination and fever', 'Urgent', 'Family Doctor Referral', 'Fictional Plan C', 'Fever and flank tenderness', 'Dr. Jonah Reed', 'Discharged'),
(13, 10,'2026-06-16 08:30', 'Acute coronary syndrome', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Chest pain with ischemic ECG changes', 'Dr. Mira Patel', 'Discharged'),
(14, 11,'2026-07-07 15:10', 'Fall with hip pain', 'Emergency', 'Ambulance', 'Fictional Plan B', 'Pain and reduced mobility', 'Dr. Elena Roy', 'Discharged'),
(15, 1, '2026-08-22 12:00', 'Fever and flank pain', 'Emergency', 'Emergency Department', 'Fictional Plan A', 'Flank pain and urinary symptoms', 'Dr. Jonah Reed', 'Discharged'),
(16, 6, '2026-09-02 16:20', 'Right upper abdominal pain', 'Emergency', 'Walk-in', 'Fictional Plan A', 'Abdominal tenderness and nausea', 'Dr. Mira Patel', 'Discharged'),
(17, 2, '2026-09-18 08:00', 'Sepsis with respiratory distress', 'Emergency', 'Emergency Department', 'Fictional Plan B', 'Febrile with oxygen requirement', 'Dr. Jonah Reed', 'Discharged');

-- Anais Note: based on the implementation of Query 1, priority_level should go from low to high. 

INSERT INTO Triage_and_Assessment (
    assessment_id, admission_id, assessment_date_time,
    assessment_type, assessment_results, healthcare_professional_in_charge,
    blood_pressure, heart_rate, respiratory_rate, body_temperature,
    oxygen_saturation, pain_level, reported_symptoms, known_allergies,
    current_medications, triage_priority_level
) VALUES
(1, 1, '2026-01-05 08:25', 'Triage', 'Possible cardiac event', 'Nurse Ren Lee', '160/95', 102, 22, 36.8, 95.0, 8, 'Chest pain, sweating', 'None reported', 'Atorvastatin', 'Level 1'),
(2, 2, '2026-03-17 14:10', 'Triage', 'Possible fluid overload', 'Nurse Ren Lee', '142/88', 96, 22, 37.1, 92.0, 3, 'Dyspnea, ankle swelling', 'None reported', 'Amlodipine', 'Level 2'),
(3, 3, '2026-05-02 09:10', 'Triage', 'Stable cardiac symptoms', 'Nurse Kai Morgan', '130/82', 78, 16, 36.7, 98.0, 2, 'Intermittent chest discomfort', 'None reported', 'Atorvastatin', 'Level 3'),
(4, 4, '2026-08-01 10:10', 'Triage', 'Respiratory infection suspected', 'Nurse Kai Morgan', '128/78', 98, 21, 38.4, 93.0, 2, 'Fever, cough, fatigue', 'None reported', 'None', 'Level 2'),
(5, 5, '2026-02-01 09:40', 'Triage', 'Sepsis alert', 'Nurse Ren Lee', '88/54', 124, 29, 39.2, 90.0, 5, 'Fever, chills, confusion', 'Sulfa drugs', 'Metformin', 'Level 1'),
(6, 6, '2026-02-12 18:10', 'Triage', 'Surgical abdomen suspected', 'Nurse Kai Morgan', '118/74', 96, 18, 37.8, 98.0, 8, 'Right lower quadrant pain, nausea', 'None reported', 'None', 'Level 2'),
(7, 7, '2026-03-20 07:55', 'Triage', 'Probable hip fracture', 'Nurse Ren Lee', '148/86', 92, 20, 36.6, 96.0, 9, 'Hip pain after fall', 'Latex', 'Lisinopril', 'Level 1'),
(8, 8, '2026-04-11 19:10', 'Triage', 'Asthma exacerbation', 'Nurse Kai Morgan', '112/70', 108, 26, 37.0, 94.0, 3, 'Wheezing and cough', 'Peanuts', 'Rescue inhaler', 'Level 3'),
(9, 9, '2026-04-22 06:50', 'Triage', 'Stroke alert', 'Nurse Ren Lee', '176/98', 88, 18, 36.9, 96.0, 1, 'Facial droop, weakness, slurred speech', 'None reported', 'Aspirin', 'Level 1'),
(10,10, '2026-05-04 03:30', 'Triage', 'Acute heart failure', 'Nurse Kai Morgan', '150/92', 120, 30, 36.4, 82.0, 4, 'Severe dyspnea, leg edema', 'Aspirin', 'Furosemide', 'Level 1'),
(11,11, '2026-05-22 10:10', 'Triage', 'Respiratory failure suspected', 'Nurse Ren Lee', '136/84', 112, 30, 37.2, 86.0, 2, 'Shortness of breath, fatigue', 'None reported', 'Tiotropium', 'Level 1'),
(12,12, '2026-06-03 11:25', 'Triage', 'Urinary infection suspected', 'Nurse Kai Morgan', '122/78', 94, 18, 38.1, 98.0, 5, 'Dysuria, fever, flank pain', 'Penicillin', 'None', 'Level 3'),
(13,13, '2026-06-16 08:40', 'Triage', 'Acute coronary syndrome', 'Nurse Ren Lee', '158/92', 106, 23, 36.8, 94.0, 7, 'Chest pressure, nausea', 'None reported', 'None', 'Level 1'),
(14,14, '2026-07-07 15:20', 'Triage', 'Possible fracture', 'Nurse Kai Morgan', '144/82', 86, 18, 36.5, 97.0, 8, 'Hip pain after fall', 'None reported', 'Amlodipine', 'Level 2'),
(15,15, '2026-08-22 12:10', 'Triage', 'Possible kidney infection', 'Nurse Ren Lee', '124/76', 102, 20, 38.6, 97.0, 6, 'Flank pain, urinary frequency', 'None reported', 'Atorvastatin', 'Level 2'),
(16,16, '2026-09-02 16:30', 'Triage', 'Biliary disease suspected', 'Nurse Kai Morgan', '132/80', 90, 18, 37.4, 98.0, 7, 'Right upper quadrant pain, nausea', 'None reported', 'Aspirin', 'Level 2'),
(17,17, '2026-09-18 08:10', 'Triage', 'Sepsis and respiratory distress', 'Nurse Ren Lee', '92/58', 118, 28, 39.0, 89.0, 3, 'Fever, chills, shortness of breath', 'Sulfa drugs', 'Metformin', 'Level 1');

INSERT INTO Clinical_Note (
    clinical_note_id, admission_id, note_type, note_date_time,
    patients_symptoms, physical_examination, initial_clinical_findings,
    suspected_medical_condition, planned_diagnostic_examinations,
    initial_treatment_plan, note_content
) VALUES
(1,  1, 'Emergency Assessment', '2026-01-05 08:40', 'Chest pain for one hour', 'Diaphoretic, tachycardic', 'Ischemic ECG changes', 'Acute myocardial infarction', 'ECG, troponin, chest X-ray', 'Aspirin, anticoagulation, cardiology review', 'Fictional patient admitted for acute cardiac assessment.'),
(2,  2, 'Emergency Assessment', '2026-03-17 14:25', 'Dyspnea and ankle swelling', 'Bibasilar crackles, peripheral edema', 'Elevated cardiac markers suspected', 'Congestive heart failure', 'Chest X-ray, echocardiogram', 'Oxygen, diuretic, monitored admission', 'Symptoms improved after initial diuresis.'),
(3,  3, 'Emergency Assessment', '2026-05-02 09:25', 'Intermittent chest discomfort', 'Comfortable at rest', 'No acute ECG change', 'Coronary artery disease', 'ECG, serial cardiac enzymes', 'Observation and medication review', 'Stable for observation and subsequent discharge.'),
(4,  4, 'Emergency Assessment', '2026-08-01 10:25', 'Fever and productive cough', 'Crackles at right lung base', 'Fever and mild hypoxemia', 'Pneumonia', 'Chest X-ray, blood tests', 'Oxygen as needed, antibiotics', 'Respiratory symptoms monitored during admission.'),
(5,  5, 'Emergency Assessment', '2026-02-01 09:55', 'Fever, chills, confusion', 'Hypotension and tachycardia', 'Sepsis with poor perfusion', 'Sepsis', 'Blood cultures, chest X-ray, lactate', 'IV fluids, antibiotics, critical care', 'Transferred to medical intensive care for close monitoring.'),
(6,  6, 'Emergency Assessment', '2026-02-12 18:25', 'Right lower abdominal pain', 'Rebound tenderness', 'Elevated white cell count', 'Acute appendicitis', 'Abdominal CT, blood tests', 'NPO, IV fluids, surgical consultation', 'Surgical team reviewed the fictional case.'),
(7,  7, 'Emergency Assessment', '2026-03-20 08:10', 'Hip pain after fall', 'Shortened, externally rotated leg', 'Imaging consistent with fracture', 'Femoral neck fracture', 'Hip X-ray, preoperative assessment', 'Analgesia and orthopedic consultation', 'Operative repair planned after stabilization.'),
(8,  8, 'Emergency Assessment', '2026-04-11 19:25', 'Wheezing and cough', 'Diffuse expiratory wheezes', 'Reduced peak flow', 'Asthma exacerbation', 'Peak flow and chest X-ray', 'Nebulized bronchodilator and steroids', 'Breathing improved after treatment.'),
(9,  9, 'Emergency Assessment', '2026-04-22 07:00', 'Weakness and slurred speech', 'Right-sided weakness, aphasia', 'Acute stroke symptoms', 'Cerebral artery occlusion with infarction', 'Head CT, brain MRI', 'Stroke protocol and specialist review', 'Admitted for stroke treatment and monitoring.'),
(10,10, 'Emergency Assessment', '2026-05-04 03:45', 'Severe dyspnea', 'Bilateral crackles, leg edema', 'Pulmonary edema and hypoxemia', 'Congestive heart failure', 'Chest X-ray, ECG, cardiac markers', 'Oxygen, IV diuretic, critical care', 'Condition deteriorated despite resuscitative treatment.'),
(11,11, 'Emergency Assessment', '2026-05-22 10:25', 'Shortness of breath', 'Increased work of breathing', 'Hypoxemia', 'Acute respiratory failure', 'Chest X-ray, blood gas', 'Oxygen and respiratory support', 'Treatment remains in progress.'),
(12,12, 'Emergency Assessment', '2026-06-03 11:40', 'Dysuria, fever, flank pain', 'Flank tenderness', 'Urinalysis suggests infection', 'Urinary tract infection', 'Urine culture, renal ultrasound', 'Fluids and antibiotics', 'Admitted for treatment of urinary infection.'),
(13,13, 'Emergency Assessment', '2026-06-16 08:55', 'Chest pressure and nausea', 'Pale, mildly diaphoretic', 'Ischemic ECG changes', 'Acute myocardial infarction', 'ECG, troponin, chest X-ray', 'Urgent cardiac intervention', 'Cardiology team accepted the patient for treatment.'),
(14,14, 'Emergency Assessment', '2026-07-07 15:35', 'Hip pain after fall', 'Pain with movement', 'Closed fracture on X-ray', 'Femoral neck fracture', 'Hip X-ray, blood tests', 'Analgesia and orthopedic consultation', 'Admitted for fracture repair and recovery.'),
(15,15, 'Emergency Assessment', '2026-08-22 12:25', 'Fever and flank pain', 'Costovertebral angle tenderness', 'Urinalysis positive for infection', 'Urinary tract infection', 'Urine culture, blood tests', 'Antibiotics and hydration', 'Observed until symptoms improved.'),
(16,16, 'Emergency Assessment', '2026-09-02 16:45', 'Right upper abdominal pain', 'Right upper quadrant tenderness', 'Ultrasound suggests gallbladder inflammation', 'Abdominal pain', 'Abdominal ultrasound, blood tests', 'IV fluids and surgical review', 'Further evaluation supported operative treatment.'),
(17,17, 'Emergency Assessment', '2026-09-18 08:25', 'Fever and shortness of breath', 'Hypotension, increased work of breathing', 'Sepsis with respiratory compromise', 'Sepsis', 'Blood cultures, chest X-ray, lactate', 'IV fluids, antibiotics, critical care', 'Transferred for critical care and ongoing treatment.'),
(18, 1, 'Discharge Summary', '2026-01-09 10:45', 'Chest pain resolved', 'Comfortable and ambulatory', 'Cardiac status stable', 'Acute myocardial infarction', 'Outpatient cardiac follow-up', 'Continue prescribed cardiac medications', 'Recovery was uncomplicated; discharged home with cardiac follow-up.'),
(19, 5, 'Discharge Summary', '2026-02-12 14:15', 'Fever resolved', 'Stable vital signs', 'Infection responding to treatment', 'Sepsis', 'Follow-up blood tests', 'Complete prescribed antibiotic course', 'Recovery progressing; discharged home with follow-up instructions.'),
(20, 6, 'Discharge Summary', '2026-02-15 08:45', 'Abdominal pain resolved', 'Incision clean and dry', 'Postoperative status stable', 'Acute appendicitis', 'Surgical clinic follow-up', 'Activity restrictions reviewed', 'Recovery satisfactory following appendectomy.'),
(21, 7, 'Discharge Summary', '2026-03-28 08:45', 'Hip pain controlled', 'Mobilizing with assistance', 'Postoperative status stable', 'Femoral neck fracture', 'Orthopedic follow-up', 'Continue rehabilitation and medications', 'Recovery continues at the rehabilitation facility.'),
(22,10, 'Discharge Summary', '2026-05-07 05:45', 'Severe respiratory distress', 'No response to resuscitation', 'Death during admission', 'Congestive heart failure', 'No further examination', 'Resuscitation unsuccessful', 'Patient died during the hospital stay.'),
(23,13, 'Discharge Summary', '2026-06-19 10:45', 'Chest discomfort resolved', 'Stable after procedure', 'Cardiac status improved', 'Acute myocardial infarction', 'Cardiology clinic follow-up', 'Continue prescribed medications', 'Recovery stable after cardiac intervention.'),
(24,14, 'Discharge Summary', '2026-07-12 09:45', 'Hip pain improved', 'Mobilizing with walker', 'Fracture repair stable', 'Femoral neck fracture', 'Orthopedic clinic follow-up', 'Continue physiotherapy', 'Recovery progressing at home.'),
(25,17, 'Discharge Summary', '2026-09-28 09:45', 'Breathing improved', 'Stable on room air', 'Infection resolving', 'Sepsis', 'Family physician follow-up', 'Complete medications and return if symptoms recur', 'Recovery was stable at discharge.');

INSERT INTO Diagnostic_Order (
    diagnostic_order_id, patient_id, admission_id,
    requesting_physician, requested_examination, request_date_time,
    clinical_reason_for_examination, priority, order_status
) VALUES
(1,  1, 1,  'Dr. Mira Patel',  'Chest X-ray',       '2026-01-05 08:45', 'Assess chest pain', 'Urgent', 'Completed'),
(2,  1, 2,  'Dr. Jonah Reed', 'Echocardiogram',    '2026-03-17 14:30', 'Assess cardiac function', 'High', 'Completed'),
(3,  1, 3,  'Dr. Mira Patel',  'Chest X-ray',       '2026-05-02 09:30', 'Evaluate chest discomfort', 'Routine', 'Completed'),
(4,  1, 4,  'Dr. Elena Roy',   'Chest X-ray',       '2026-08-01 10:30', 'Assess suspected pneumonia', 'High', 'Completed'),
(5,  2, 5,  'Dr. Jonah Reed', 'Chest X-ray',       '2026-02-01 10:00', 'Assess infection source', 'Urgent', 'Completed'),
(6,  3, 6,  'Dr. Elena Roy',   'Abdominal CT',      '2026-02-12 18:30', 'Assess suspected appendicitis', 'Urgent', 'Completed'),
(7,  4, 7,  'Dr. Mira Patel',  'Right hip X-ray',   '2026-03-20 08:15', 'Assess fall injury', 'Urgent', 'Completed'),
(8,  5, 8,  'Dr. Elena Roy',   'Chest X-ray',       '2026-04-11 19:30', 'Assess respiratory symptoms', 'Routine', 'Completed'),
(9,  6, 9,  'Dr. Jonah Reed', 'Head CT',           '2026-04-22 07:05', 'Stroke evaluation', 'Urgent', 'Completed'),
(10, 7,10,  'Dr. Mira Patel',  'Chest X-ray',       '2026-05-04 03:50', 'Assess pulmonary edema', 'Urgent', 'Completed'),
(11, 8,11,  'Dr. Elena Roy',   'Chest X-ray',       '2026-05-22 10:30', 'Assess respiratory failure', 'Urgent', 'In Progress'),
(12, 9,12,  'Dr. Jonah Reed', 'Renal ultrasound',  '2026-06-03 11:45', 'Rule out urinary obstruction', 'High', 'Completed'),
(13,10,13,  'Dr. Mira Patel',  'Chest X-ray',       '2026-06-16 09:00', 'Assess chest pain', 'Urgent', 'Completed'),
(14,11,14,  'Dr. Elena Roy',   'Left hip X-ray',    '2026-07-07 15:40', 'Assess fall injury', 'High', 'Completed'),
(15, 1,15,  'Dr. Jonah Reed', 'Renal ultrasound',  '2026-08-22 12:30', 'Assess flank pain', 'High', 'Completed'),
(16, 6,16,  'Dr. Mira Patel',  'Abdominal ultrasound','2026-09-02 16:50', 'Assess right upper quadrant pain', 'High', 'Completed'),
(17, 2,17,  'Dr. Jonah Reed', 'Chest X-ray',       '2026-09-18 08:30', 'Assess respiratory compromise', 'Urgent', 'Completed');


-- Anais Note: referencing the admission_id gives the patient id 
INSERT INTO Radiology_Examination (
    examination_id, diagnostic_order_id,
    admission_id, examination_type, examination_date_time,
    body_area_examined, referring_physician, radiology_technician,
    examination_status, medical_images_link
) VALUES
(1,  1,  1, 1,  'X-ray',      '2026-01-05 09:05', 'Chest', 'Dr. Mira Patel',  'Tech Rowan Kim', 'Completed', 'https://example.org/synthetic-images/exam-1'),
(2,  2,  1, 2,  'Ultrasound', '2026-03-17 15:00', 'Heart', 'Dr. Jonah Reed', 'Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-2'),
(3,  3,  1, 3,  'X-ray',      '2026-05-02 10:00', 'Chest', 'Dr. Mira Patel',  'Tech Rowan Kim', 'Completed', 'https://example.org/synthetic-images/exam-3'),
(4,  4,  1, 4,  'X-ray',      '2026-08-01 11:00', 'Chest', 'Dr. Elena Roy',   'Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-4'),
(5,  5,  2, 5,  'X-ray',      '2026-02-01 10:20', 'Chest', 'Dr. Jonah Reed', 'Tech Rowan Kim', 'Completed', 'https://example.org/synthetic-images/exam-5'),
(6,  6,  3, 6,  'CT',         '2026-02-12 19:10', 'Abdomen', 'Dr. Elena Roy','Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-6'),
(7,  7,  4, 7,  'X-ray',      '2026-03-20 08:40', 'Right hip', 'Dr. Mira Patel','Tech Rowan Kim','Completed','https://example.org/synthetic-images/exam-7'),
(8,  8,  5, 8,  'X-ray',      '2026-04-11 20:00', 'Chest', 'Dr. Elena Roy',   'Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-8'),
(9,  9,  6, 9,  'CT',         '2026-04-22 07:20', 'Head', 'Dr. Jonah Reed', 'Tech Rowan Kim', 'Completed', 'https://example.org/synthetic-images/exam-9'),
(10,10,  7,10,  'X-ray',      '2026-05-04 04:05', 'Chest', 'Dr. Mira Patel',  'Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-10'),
(11,11,  8,11,  'X-ray',      '2026-05-22 10:55', 'Chest', 'Dr. Elena Roy',   'Tech Rowan Kim', 'In Progress', NULL),
(12,12,  9,12,  'Ultrasound', '2026-06-03 12:20', 'Kidneys', 'Dr. Jonah Reed','Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-12'),
(13,13, 10,13,  'X-ray',      '2026-06-16 09:20', 'Chest', 'Dr. Mira Patel',  'Tech Rowan Kim', 'Completed', 'https://example.org/synthetic-images/exam-13'),
(14,14, 11,14,  'X-ray',      '2026-07-07 16:00', 'Left hip', 'Dr. Elena Roy','Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-14'),
(15,15,  1,15,  'Ultrasound', '2026-08-22 13:00', 'Kidneys', 'Dr. Jonah Reed','Tech Rowan Kim', 'Completed', 'https://example.org/synthetic-images/exam-15'),
(16,16,  6,16,  'Ultrasound', '2026-09-02 17:20', 'Abdomen', 'Dr. Mira Patel', 'Tech Alex Noor', 'Completed', 'https://example.org/synthetic-images/exam-16'),
(17,17,  2,17,  'X-ray',      '2026-09-18 09:00', 'Chest', 'Dr. Jonah Reed', 'Tech Rowan Kim', 'Completed', 'https://example.org/synthetic-images/exam-17');

INSERT INTO Diagnosis_Record (
    diagnosis_id, patient_id, admission_id, icd_9_code,
    diagnosis_date_time, diagnosis_type, diagnosing_physician
) VALUES
(1,  1, 1,  '410.91', '2026-01-05 09:30', 'Primary',   'Dr. Mira Patel'),
(2,  1, 1,  '401.9',  '2026-01-05 10:00', 'Secondary', 'Dr. Mira Patel'),
(3,  1, 2,  '428.0',  '2026-03-17 16:00', 'Primary',   'Dr. Jonah Reed'),
(4,  1, 2,  '401.9',  '2026-03-17 16:15', 'Secondary', 'Dr. Jonah Reed'),
(5,  1, 3,  '414.01', '2026-05-02 11:00', 'Primary',   'Dr. Mira Patel'),
(6,  1, 4,  '486',    '2026-08-01 12:00', 'Primary',   'Dr. Elena Roy'),
(7,  2, 5,  '038.9',  '2026-02-01 11:00', 'Primary',   'Dr. Jonah Reed'),
(8,  2, 5,  '250.00', '2026-02-01 11:15', 'Secondary', 'Dr. Jonah Reed'),
(9,  3, 6,  '540.9',  '2026-02-12 20:00', 'Primary',   'Dr. Elena Roy'),
(10, 4, 7,  '820.8',  '2026-03-20 09:00', 'Primary',   'Dr. Mira Patel'),
(11, 4, 7,  '401.9',  '2026-03-20 09:15', 'Secondary', 'Dr. Mira Patel'),
(12, 5, 8,  '493.90', '2026-04-11 20:30', 'Primary',   'Dr. Elena Roy'),
(13, 6, 9,  '434.91', '2026-04-22 08:00', 'Primary',   'Dr. Jonah Reed'),
(14, 7,10,  '428.0',  '2026-05-04 04:30', 'Primary',   'Dr. Mira Patel'),
(15, 7,10,  '401.9',  '2026-05-04 04:45', 'Secondary', 'Dr. Mira Patel'),
(16, 8,11,  '518.81', '2026-05-22 11:30', 'Primary',   'Dr. Elena Roy'),
(17, 9,12,  '599.0',  '2026-06-03 13:00', 'Primary',   'Dr. Jonah Reed'),
(18,10,13,  '410.91', '2026-06-16 10:00', 'Primary',   'Dr. Mira Patel'),
(19,10,13,  '414.01', '2026-06-16 10:15', 'Secondary', 'Dr. Mira Patel'),
(20,11,14,  '820.8',  '2026-07-07 16:30', 'Primary',   'Dr. Elena Roy'),
(21, 1,15,  '599.0',  '2026-08-22 13:30', 'Primary',   'Dr. Jonah Reed'),
(22, 6,16,  '789.00', '2026-09-02 18:00', 'Primary',   'Dr. Mira Patel'),
(23, 6,16,  '401.9',  '2026-09-02 18:15', 'Secondary', 'Dr. Mira Patel'),
(24, 2,17,  '038.9',  '2026-09-18 10:00', 'Primary',   'Dr. Jonah Reed'),
(25, 2,17,  '518.81', '2026-09-18 10:15', 'Secondary', 'Dr. Jonah Reed');


-- Anais Note: referencing the admission_id gives the patient id 
INSERT INTO Surgical_Procedure (
    surgical_procedure_id, admission_id,
    procedure_type, procedure_date_time, performing_surgeon,
    procedure_status, procedure_notes
) VALUES
(1,  1, 1,  'Percutaneous coronary intervention', '2026-01-05 13:00', 'Dr. Rowan Ellis', 'Completed', 'Fictional coronary stent placement; stable afterward.'),
(2,  3, 6,  'Laparoscopic appendectomy',          '2026-02-12 22:00', 'Dr. Alex Chen',   'Completed', 'Uncomplicated fictional appendectomy.'),
(3,  4, 7,  'Hip hemiarthroplasty',               '2026-03-20 10:00', 'Dr. Rowan Ellis', 'Completed', 'Right hip repair under spinal anesthesia.'),
(4, 10,13,  'Percutaneous coronary intervention', '2026-06-16 11:00', 'Dr. Alex Chen',   'Completed', 'Fictional coronary intervention with stable result.'),
(5, 11,14,  'Hip hemiarthroplasty',               '2026-07-08 09:00', 'Dr. Rowan Ellis', 'Completed', 'Left hip repair; transferred to general ward.'),
(6,  6,16,  'Laparoscopic cholecystectomy',       '2026-09-03 10:00', 'Dr. Alex Chen',   'Completed', 'Uncomplicated fictional gallbladder removal.');

INSERT INTO Unit_Stay (
    unit_stay_id, admission_id, unit_type, ward_and_room,
    bed_number, entry_date_time, exit_date_time, responsible_physician,
    reason_for_transfer
) VALUES
(1,  1, 'Emergency',     'ER-A / Room 3',   '3',  '2026-01-05 08:15', '2026-01-05 10:00', 'Dr. Mira Patel',  'Initial emergency assessment'),
(2,  1, 'CCU',           'CCU / Room 2',    '2',  '2026-01-05 10:30', '2026-01-07 10:30', 'Dr. Rowan Ellis', 'Post-intervention cardiac monitoring'),
(3,  1, 'General Ward',  'Ward 4A / Room 8','8A', '2026-01-07 11:00', '2026-01-09 10:30', 'Dr. Mira Patel',  'Stable for step-down care'),
(4,  2, 'Emergency',     'ER-B / Room 1',   '1',  '2026-03-17 14:00', '2026-03-17 16:00', 'Dr. Jonah Reed', 'Initial assessment'),
(5,  2, 'MICU',          'MICU / Room 1',   '1',  '2026-03-17 16:30', '2026-03-19 12:00', 'Dr. Jonah Reed', 'Cardiac monitoring and diuresis'),
(6,  2, 'General Ward',  'Ward 3B / Room 4','4B', '2026-03-19 12:30', '2026-03-22 09:00', 'Dr. Jonah Reed', 'Improving after treatment'),
(7,  3, 'Emergency',     'ER-A / Room 4',   '4',  '2026-05-02 09:00', '2026-05-02 11:00', 'Dr. Mira Patel',  'Initial assessment'),
(8,  3, 'General Ward',  'Ward 2A / Room 6','6A', '2026-05-02 11:30', '2026-05-04 08:30', 'Dr. Mira Patel',  'Observation and medication review'),
(9,  4, 'Emergency',     'ER-B / Room 2',   '2',  '2026-08-01 10:00', '2026-08-01 12:00', 'Dr. Elena Roy',   'Initial assessment'),
(10, 4, 'General Ward',  'Ward 3A / Room 9','9A', '2026-08-01 12:30', '2026-08-04 11:00', 'Dr. Elena Roy',   'Antibiotic treatment'),
(11, 5, 'Emergency',     'ER-A / Room 1',   '1',  '2026-02-01 09:30', '2026-02-01 10:30', 'Dr. Jonah Reed', 'Sepsis protocol initiated'),
(12, 5, 'ICU',           'ICU / Room 2',    '2',  '2026-02-01 11:00', '2026-02-10 11:00', 'Dr. Jonah Reed', 'Critical care for sepsis'),
(13, 5, 'General Ward',  'Ward 4B / Room 5','5B', '2026-02-10 12:00', '2026-02-12 14:00', 'Dr. Jonah Reed', 'Stable for step-down care'),
(14, 6, 'Emergency',     'ER-A / Room 5',   '5',  '2026-02-12 18:00', '2026-02-12 20:00', 'Dr. Elena Roy',   'Initial surgical assessment'),
(15, 6, 'Surgery',       'OR 2',            '2',  '2026-02-12 21:30', '2026-02-13 00:30', 'Dr. Alex Chen',   'Appendectomy'),
(16, 6, 'General Ward',  'Ward 2C / Room 3','3C', '2026-02-13 01:00', '2026-02-15 08:30', 'Dr. Alex Chen',   'Postoperative recovery'),
(17, 7, 'Emergency',     'ER-B / Room 3',   '3',  '2026-03-20 07:45', '2026-03-20 09:00', 'Dr. Mira Patel',  'Fracture stabilization'),
(18, 7, 'Surgery',       'OR 1',            '1',  '2026-03-20 09:30', '2026-03-20 12:00', 'Dr. Rowan Ellis', 'Hip repair'),
(19, 7, 'SICU',          'SICU / Room 1',   '1',  '2026-03-20 12:30', '2026-03-21 10:00', 'Dr. Rowan Ellis', 'Immediate postoperative monitoring'),
(20, 7, 'ICU',           'ICU / Room 2',    '2',  '2026-03-21 10:30', '2026-03-24 10:00', 'Dr. Rowan Ellis', 'Ongoing critical care'),
(21, 7, 'General Ward',  'Ward 5A / Room 6','6A', '2026-03-24 10:30', '2026-03-28 08:30', 'Dr. Rowan Ellis', 'Rehabilitation and mobility support'),
(22, 8, 'Emergency',     'ER-A / Room 2',   '2',  '2026-04-11 19:00', '2026-04-11 21:00', 'Dr. Elena Roy',   'Initial respiratory assessment'),
(23, 8, 'General Ward',  'Ward 3C / Room 7','7C', '2026-04-11 21:30', '2026-04-11 22:30', 'Dr. Elena Roy',   'Observation after bronchodilator'),
(24, 9, 'Emergency',     'ER-A / Room 1',   '1',  '2026-04-22 06:45', '2026-04-22 08:30', 'Dr. Jonah Reed', 'Stroke protocol'),
(25, 9, 'ICU',           'ICU / Room 3',    '3',  '2026-04-22 09:00', '2026-04-25 09:00', 'Dr. Jonah Reed', 'Post-stroke monitoring'),
(26, 9, 'General Ward',  'Ward 4A / Room 2','2A', '2026-04-25 09:30', '2026-04-30 09:00', 'Dr. Jonah Reed', 'Neurologic rehabilitation'),
(27,10, 'Emergency',     'ER-B / Room 4',   '4',  '2026-05-04 03:20', '2026-05-04 04:00', 'Dr. Mira Patel',  'Resuscitation and stabilization'),
(28,10, 'CCU',           'CCU / Room 1',    '1',  '2026-05-04 04:30', '2026-05-07 05:30', 'Dr. Mira Patel',  'Critical cardiac care'),
(29,11, 'Emergency',     'ER-B / Room 5',   '5',  '2026-05-22 10:00', '2026-05-22 11:00', 'Dr. Elena Roy',   'Respiratory stabilization'),
(30,11, 'ICU',           'ICU / Room 4',    '4',  '2026-05-22 11:30', '2026-05-23 10:00', 'Dr. Elena Roy',   'Respiratory support'),
(31,11, 'General Ward',  'Ward 3A / Room 1','1A', '2026-05-23 10:30', NULL,                'Dr. Elena Roy',   'Ongoing treatment'),
(32,12, 'Emergency',     'ER-A / Room 6',   '6',  '2026-06-03 11:15', '2026-06-03 13:00', 'Dr. Jonah Reed', 'Initial assessment'),
(33,12, 'General Ward',  'Ward 2B / Room 8','8B', '2026-06-03 13:30', '2026-06-06 10:00', 'Dr. Jonah Reed', 'Antibiotic treatment'),
(34,13, 'Emergency',     'ER-B / Room 1',   '1',  '2026-06-16 08:30', '2026-06-16 10:30', 'Dr. Mira Patel',  'Cardiac assessment'),
(35,13, 'CCU',           'CCU / Room 3',    '3',  '2026-06-16 12:00', '2026-06-18 10:00', 'Dr. Rowan Ellis', 'Post-intervention monitoring'),
(36,14, 'Emergency',     'ER-A / Room 3',   '3',  '2026-07-07 15:10', '2026-07-07 17:00', 'Dr. Elena Roy',   'Fracture assessment'),
(37,14, 'General Ward',  'Ward 5B / Room 4','4B', '2026-07-07 17:30', '2026-07-12 09:00', 'Dr. Rowan Ellis', 'Postoperative recovery'),
(38,15, 'Emergency',     'ER-B / Room 2',   '2',  '2026-08-22 12:00', '2026-08-22 14:00', 'Dr. Jonah Reed', 'Initial assessment'),
(39,15, 'General Ward',  'Ward 3B / Room 9','9B', '2026-08-22 14:30', '2026-08-25 09:00', 'Dr. Jonah Reed', 'Hydration and antibiotic treatment'),
(40,16, 'Emergency',     'ER-A / Room 4',   '4',  '2026-09-02 16:20', '2026-09-02 18:30', 'Dr. Mira Patel',  'Initial abdominal assessment'),
(41,16, 'Surgery',       'OR 3',            '3',  '2026-09-03 09:00', '2026-09-03 11:30', 'Dr. Alex Chen',   'Cholecystectomy'),
(42,16, 'General Ward',  'Ward 2A / Room 7','7A', '2026-09-03 12:00', '2026-09-06 09:00', 'Dr. Alex Chen',   'Postoperative recovery'),
(43,17, 'Emergency',     'ER-B / Room 6',   '6',  '2026-09-18 08:00', '2026-09-18 09:30', 'Dr. Jonah Reed', 'Sepsis protocol'),
(44,17, 'MICU',          'MICU / Room 3',   '3',  '2026-09-18 10:00', '2026-09-25 10:00', 'Dr. Jonah Reed', 'Critical care for sepsis'),
(45,17, 'General Ward',  'Ward 4C / Room 2','2C', '2026-09-25 10:30', '2026-09-28 09:00', 'Dr. Jonah Reed', 'Stable for step-down care');

INSERT INTO General_Ward (
    progress_note_id, unit_stay_id, nursing_monitoring_notes,
    physician_follow_up_examination, medications_and_treatments_administered,
    progress_notes, additional_tests_requested, recovery_evaluation
) VALUES
(1,  3, 'Vitals stable every four hours', 'Cardiology review completed', 'Cardiac medications continued', 'Ambulating without chest pain', 'None', 'Good recovery'),
(2,  6, 'Daily weight and oxygen checks', 'Edema reduced on examination', 'Diuretic therapy continued', 'Breathing improved', 'Repeat echocardiogram arranged', 'Recovering well'),
(3,  8, 'Routine observations', 'No acute cardiac findings', 'Home medications reviewed', 'No recurrent symptoms', 'None', 'Stable for discharge'),
(4, 10, 'Temperature monitored', 'Lung exam improving', 'Antibiotics and fluids', 'Cough reduced', 'None', 'Recovering from infection'),
(5, 13, 'Vitals stable', 'Infection resolving', 'Antibiotics continued', 'Eating and mobilizing', 'Follow-up blood tests', 'Recovered sufficiently for discharge'),
(6, 16, 'Pain and wound checks', 'Incision clean and dry', 'Analgesics as needed', 'Tolerating meals', 'None', 'Good postoperative recovery'),
(7, 21, 'Mobility assistance provided', 'Orthopedic review completed', 'Analgesia and thrombosis prevention', 'Walking with support', 'Physiotherapy assessment', 'Progressing with rehabilitation'),
(8, 23, 'Respiratory observations', 'Wheezing improved', 'Inhaled bronchodilator', 'No oxygen required', 'None', 'Stable for discharge'),
(9, 26, 'Neurologic checks continued', 'Weakness improving', 'Stroke medications continued', 'Participating in therapy', 'Rehabilitation review', 'Recovering with mild residual weakness'),
(10,31, 'Continuous monitoring', 'Respiratory plan reviewed', 'Oxygen and inhaled therapy', 'Treatment remains in progress', 'Repeat chest imaging pending', 'Ongoing care'),
(11,33, 'Temperature and intake monitored', 'Flank tenderness reduced', 'Antibiotics and fluids', 'Urinary symptoms resolved', 'Culture review completed', 'Recovered'),
(12,37, 'Pain controlled', 'Postoperative hip review', 'Analgesia and physiotherapy', 'Mobilizing with walker', 'Follow-up imaging arranged', 'Progressing with recovery'),
(13,39, 'Urine output monitored', 'Symptoms improved', 'Antibiotics and hydration', 'Afebrile before discharge', 'None', 'Recovered'),
(14,42, 'Wound checks continued', 'Abdominal tenderness resolved', 'Analgesia and fluids', 'Tolerating regular diet', 'None', 'Good recovery'),
(15,45, 'Vitals stable', 'Infection responding to treatment', 'Antibiotics completed', 'Breathing comfortably', 'None', 'Recovered sufficiently for discharge');

INSERT INTO Discharge_Record (
    discharge_record_id, admission_id, discharge_date_time,
    discharge_destination, patients_condition_at_discharge, primary_icd_9_diagnosis,
    secondary_icd_9_diagnoses, prescribed_medications, follow_up_instructions,
    scheduled_follow_up_appointments, responsible_physician
) VALUES
(1,  1, '2026-01-09 11:00', 'Home', 'Stable, chest pain resolved', '410.91', '401.9', 'Aspirin, atorvastatin, beta blocker', 'Cardiac rehabilitation and low-sodium diet', '2026-01-23 10:00 Cardiology clinic', 'Dr. Mira Patel'),
(2,  2, '2026-03-22 10:00', 'Home', 'Breathing improved, edema reduced', '428.0', '401.9', 'Diuretic and cardiac medications', 'Daily weights and medication review', '2026-04-05 09:00 Cardiology clinic', 'Dr. Jonah Reed'),
(3,  3, '2026-05-04 09:00', 'Home', 'Stable without recurrent symptoms', '414.01', NULL, 'Continue home cardiac medications', 'Return if chest pain recurs', '2026-05-18 11:00 Family physician', 'Dr. Mira Patel'),
(4,  4, '2026-08-04 12:00', 'Home', 'Afebrile, breathing comfortably', '486', NULL, 'Oral antibiotics', 'Complete medication course and rest', '2026-08-11 10:00 Family physician', 'Dr. Elena Roy'),
(5,  5, '2026-02-12 15:00', 'Home', 'Infection improved, stable vital signs', '038.9', '250.00', 'Complete antibiotic course', 'Hydration and return if fever recurs', '2026-02-19 10:30 Family physician', 'Dr. Jonah Reed'),
(6,  6, '2026-02-15 09:00', 'Home', 'Pain controlled after surgery', '540.9', NULL, 'Acetaminophen as needed', 'Avoid strenuous activity for two weeks', '2026-03-01 09:00 Surgery clinic', 'Dr. Alex Chen'),
(7,  7, '2026-03-28 09:00', 'Rehabilitation Center', 'Stable, mobilizing with assistance', '820.8', '401.9', 'Analgesia and thrombosis prevention', 'Continue daily physiotherapy', '2026-04-04 13:00 Orthopedic clinic', 'Dr. Rowan Ellis'),
(8,  8, '2026-04-11 23:00', 'Home', 'Wheezing resolved', '493.90', NULL, 'Rescue inhaler and short steroid course', 'Avoid known triggers', '2026-04-25 14:00 Family physician', 'Dr. Elena Roy'),
(9,  9, '2026-04-30 10:00', 'Rehabilitation Center', 'Improved with mild weakness', '434.91', NULL, 'Antiplatelet and cholesterol medication', 'Continue speech and physical therapy', '2026-05-07 13:00 Neurology clinic', 'Dr. Jonah Reed'),
(10,10, '2026-05-07 06:00', 'Deceased', 'Deceased during the hospital stay', '428.0', '401.9', NULL, NULL, NULL, 'Dr. Mira Patel'),
(11,12, '2026-06-06 11:00', 'Home', 'Afebrile, urinary symptoms resolved', '599.0', NULL, 'Oral antibiotics', 'Increase fluid intake', '2026-06-20 10:00 Family physician', 'Dr. Jonah Reed'),
(12,13, '2026-06-19 11:00', 'Home', 'Stable following cardiac intervention', '410.91', '414.01', 'Aspirin and cardiac medications', 'Cardiac rehabilitation and medication review', '2026-07-03 09:00 Cardiology clinic', 'Dr. Mira Patel'),
(13,14, '2026-07-12 10:00', 'Home', 'Stable, mobilizing with walker', '820.8', NULL, 'Analgesia as needed', 'Continue physiotherapy', '2026-07-26 10:00 Orthopedic clinic', 'Dr. Rowan Ellis'),
(14,15, '2026-08-25 10:00', 'Home', 'Afebrile, flank pain resolved', '599.0', NULL, 'Oral antibiotics', 'Complete treatment and maintain hydration', '2026-09-08 10:00 Family physician', 'Dr. Jonah Reed'),
(15,16, '2026-09-06 10:00', 'Home', 'Pain resolved after surgery', '789.00', '401.9', 'Acetaminophen as needed', 'Follow postoperative instructions', '2026-09-20 10:00 Surgery clinic', 'Dr. Alex Chen'),
(16,17, '2026-09-28 10:00', 'Home', 'Stable, breathing comfortably', '038.9', '518.81', 'Complete prescribed antibiotic course', 'Return if fever or breathing difficulty recurs', '2026-10-05 09:30 Family physician', 'Dr. Jonah Reed');
