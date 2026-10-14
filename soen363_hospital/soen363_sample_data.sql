-- Synthetic data for the SOEN 363 Hospital database.
-- All patients, staff, addresses and phone numbers are completely fictional
-- and were generated for educational purposes only. No real person is represented.
-- Run after soen363_sql_data.sql.

INSERT INTO Patient VALUES
(1, 100200301, 'Marie Tremblay',   '1961-04-12', 'Female', '123 Rue Exemple, Montreal, QC', '5145550101', 'Luc Tremblay (spouse) 5145550102', 'Alive'),
(2, 100200302, 'James Carter',     '1948-09-30', 'Male',   '45 Sample Ave, Laval, QC',      '4505550103', 'Anne Carter (daughter) 4505550104', 'Alive'),
(3, 100200303, 'Sofia Rossi',      '1995-02-18', 'Female', '78 Test Blvd, Montreal, QC',    '5145550105', 'Marco Rossi (father) 5145550106', 'Alive'),
(4, 100200304, 'Henri Gagnon',     '1938-11-05', 'Male',   '9 Chemin Fictif, Longueuil, QC', '4505550107', 'Paul Gagnon (son) 4505550108', 'Alive'),
(5, 100200305, 'Aisha Khan',       '2008-07-22', 'Female', '210 Demo St, Brossard, QC',     '4505550109', 'Imran Khan (father) 4505550110', 'Alive'),
(6, 100200306, 'Olivia Martin',    '1982-01-09', 'Female', '66 Faux Lane, Montreal, QC',    '5145550111', 'Daniel Martin (spouse) 5145550112', 'Alive'),
(7, 100200307, 'Robert Nguyen',    '1957-06-14', 'Male',   '301 Placeholder Rd, Laval, QC', '4505550113', 'Linh Nguyen (spouse) 4505550114', 'Alive'),
(8, 100200308, 'George Dubois',    '1940-12-01', 'Male',   '12 Rue Imaginaire, Montreal, QC','5145550115', 'Claire Dubois (daughter) 5145550116', 'Deceased'),
(9, 100200309, 'Elena Petrov',     '1953-03-27', 'Female', '88 Mock Street, Westmount, QC', '5145550117', 'Ivan Petrov (son) 5145550118', 'Alive'),
(10,100200310, 'Liam O''Connor',   '1990-10-10', 'Male',   '5 Example Cres, Montreal, QC',  '5145550119', 'Fiona O''Connor (mother) 5145550120', 'Alive');

INSERT INTO ICD9_Dictionary VALUES
('410.91','Acute myocardial infarction, unspecified','Acute MI of unspecified site, initial episode','Circulatory'),
('401.9', 'Essential hypertension, unspecified','High blood pressure without specified cause','Circulatory'),
('428.0', 'Congestive heart failure, unspecified','Heart failure not otherwise specified','Circulatory'),
('434.91','Cerebral artery occlusion with infarction','Ischemic stroke, unspecified artery','Circulatory'),
('486',   'Pneumonia, organism unspecified','Lung infection of unspecified cause','Respiratory'),
('493.90','Asthma, unspecified','Asthma without status asthmaticus','Respiratory'),
('491.21','Obstructive chronic bronchitis with exacerbation','COPD with acute exacerbation','Respiratory'),
('250.00','Diabetes mellitus type II without complication','Type 2 diabetes, not stated as uncontrolled','Endocrine'),
('540.9', 'Acute appendicitis without peritonitis','Inflammation of the appendix','Digestive'),
('789.00','Abdominal pain, unspecified site','Abdominal pain not otherwise specified','Symptoms'),
('820.8', 'Fracture of neck of femur, closed','Closed hip fracture, unspecified part','Injury'),
('599.0', 'Urinary tract infection, site not specified','Infection of the urinary tract','Genitourinary');

INSERT INTO Admission VALUES
(1, 1, '2026-01-05 08:15', 'Severe chest pain',          'Emergency', 'Emergency Department', 'RAMQ', 'Chest pain radiating to left arm', 'Dr. Alice Moreau', 'Discharged'),
(2, 2, '2026-01-12 14:00', 'Shortness of breath, fever', 'Emergency', 'Emergency Department', 'RAMQ', 'Febrile, low oxygen saturation', 'Dr. Ben Walker',   'Discharged'),
(3, 3, '2026-02-03 22:00', 'Right lower abdominal pain', 'Emergency', 'Emergency Department', 'Private', 'Acute abdominal pain, nausea', 'Dr. Chloe Singh',  'Discharged'),
(4, 4, '2026-02-10 09:30', 'Fall with hip pain',         'Emergency', 'Ambulance',            'RAMQ', 'Unable to bear weight on right leg', 'Dr. Alice Moreau', 'Discharged'),
(5, 5, '2026-02-20 19:00', 'Wheezing and cough',         'Emergency', 'Walk-in',              'RAMQ', 'Wheezing, mild respiratory distress', 'Dr. Ben Walker',   'Discharged'),
(6, 6, '2026-03-01 10:00', 'Painful urination, fever',   'Urgent',    'Family Doctor Referral','Private','Febrile, flank tenderness', 'Dr. Chloe Singh',  'Discharged'),
(7, 7, '2026-03-05 06:45', 'Sudden weakness and slurred speech','Emergency','Ambulance',      'RAMQ', 'Right-sided weakness, aphasia', 'Dr. Alice Moreau', 'Discharged'),
(8, 8, '2026-03-12 03:20', 'Worsening dyspnea and edema','Emergency', 'Ambulance',            'RAMQ', 'Severe dyspnea, leg edema', 'Dr. Ben Walker',   'Deceased'),
(9, 9, '2026-04-02 16:40', 'Breathing difficulty',       'Emergency', 'Walk-in',              'RAMQ', 'Productive cough, wheezing', 'Dr. Chloe Singh',  'Admitted'),
(10,10,'2026-04-08 11:15', 'Abdominal discomfort',       'Elective',  'Walk-in',              'Private','Stable, mild abdominal tenderness', 'Dr. Ben Walker',   'Discharged'),
(11,1, '2026-05-02 09:00', 'Leg swelling and fatigue',   'Urgent',    'Family Doctor Referral','RAMQ', 'Peripheral edema, fatigue', 'Dr. Alice Moreau', 'Discharged'),
(12,3, '2026-06-15 13:20', 'Asthma attack',              'Emergency', 'Walk-in',              'Private','Wheezing, tachypnea', 'Dr. Chloe Singh',  'Admitted');

INSERT INTO Triage_and_Assessment VALUES
(1, 1, '2026-01-05 08:25', 'Triage', 'Possible cardiac event', 'Nurse Emma Lavoie', '160/95', 102, 22, 36.8, 95.0, 8, 'Chest pain, sweating', 'Penicillin', 'Atorvastatin', 'Level 1'),
(2, 2, '2026-01-12 14:10', 'Triage', 'Respiratory infection suspected', 'Nurse Noah Pelletier', '130/80', 98, 24, 38.9, 89.0, 4, 'Cough, fever, dyspnea', 'None', 'Metformin', 'Level 2'),
(3, 3, '2026-02-03 22:10', 'Triage', 'Surgical abdomen suspected', 'Nurse Emma Lavoie', '118/74', 96, 18, 37.9, 98.0, 7, 'RLQ pain, nausea', 'None', 'None', 'Level 2'),
(4, 4, '2026-02-10 09:40', 'Triage', 'Probable fracture', 'Nurse Noah Pelletier', '145/85', 88, 18, 36.6, 96.0, 9, 'Hip pain after fall', 'Latex', 'Amlodipine', 'Level 2'),
(5, 5, '2026-02-20 19:10', 'Triage', 'Asthma exacerbation', 'Nurse Emma Lavoie', '110/70', 112, 28, 37.0, 92.0, 3, 'Wheezing, cough', 'Peanuts', 'Salbutamol inhaler', 'Level 3'),
(6, 6, '2026-03-01 10:10', 'Triage', 'Urinary infection suspected', 'Nurse Noah Pelletier', '122/78', 92, 16, 38.5, 98.0, 5, 'Dysuria, flank pain', 'Sulfa drugs', 'None', 'Level 3'),
(7, 7, '2026-03-05 06:50', 'Triage', 'Stroke alert', 'Nurse Emma Lavoie', '178/100', 84, 18, 36.9, 97.0, 2, 'Facial droop, weakness', 'None', 'Warfarin', 'Level 1'),
(8, 8, '2026-03-12 03:30', 'Triage', 'Acute heart failure', 'Nurse Noah Pelletier', '150/90', 118, 30, 36.5, 84.0, 6, 'Dyspnea, edema', 'Aspirin', 'Furosemide, Carvedilol', 'Level 1'),
(9, 9, '2026-04-02 16:50', 'Triage', 'COPD exacerbation', 'Nurse Emma Lavoie', '138/82', 104, 26, 37.4, 88.0, 3, 'Cough, wheeze', 'None', 'Tiotropium', 'Level 2'),
(10,10,'2026-04-08 11:25', 'Triage', 'Non-urgent', 'Nurse Noah Pelletier', '120/76', 72, 14, 36.7, 99.0, 2, 'Mild abdominal pain', 'None', 'None', 'Level 4'),
(11,11,'2026-05-02 09:10', 'Triage', 'Possible heart failure', 'Nurse Emma Lavoie', '142/88', 90, 20, 36.8, 93.0, 2, 'Leg swelling, fatigue', 'Penicillin', 'Atorvastatin, Ramipril', 'Level 3'),
(12,12,'2026-06-15 13:30', 'Triage', 'Asthma exacerbation', 'Nurse Noah Pelletier', '115/72', 110, 27, 36.9, 91.0, 3, 'Wheezing, chest tightness', 'None', 'Salbutamol inhaler', 'Level 2');

INSERT INTO Clinical_Note VALUES
(1, 1, 'Emergency Assessment', '2026-01-05 08:40', 'Chest pain for 1 hour', 'Diaphoretic, tachycardic', 'ST elevation on ECG', 'Acute myocardial infarction', 'Troponin, chest X-ray, echocardiogram', 'Aspirin, heparin, urgent angioplasty', 'Patient presents with typical ischemic chest pain.'),
(2, 2, 'Emergency Assessment', '2026-01-12 14:25', 'Cough, fever, dyspnea', 'Crackles in right lung base', 'Hypoxemia', 'Pneumonia', 'Chest X-ray, blood cultures', 'Oxygen, IV antibiotics', 'Elderly diabetic patient with community-acquired pneumonia.'),
(3, 3, 'Emergency Assessment', '2026-02-03 22:30', 'RLQ pain for 12 hours', 'Rebound tenderness RLQ', 'Elevated white cell count', 'Acute appendicitis', 'Abdominal CT', 'NPO, IV fluids, surgical consult', 'Surgical consult requested.'),
(4, 4, 'Emergency Assessment', '2026-02-10 09:55', 'Hip pain after fall', 'Shortened, externally rotated leg', 'Pain on movement', 'Femoral neck fracture', 'Hip X-ray', 'Analgesia, orthopedic consult', 'Fall at home on ice.'),
(5, 5, 'Emergency Assessment', '2026-02-20 19:25', 'Wheezing, cough', 'Diffuse wheezes', 'Peak flow reduced', 'Asthma exacerbation', 'Chest X-ray', 'Nebulized salbutamol, steroids', 'Responded well to bronchodilators.'),
(6, 6, 'Emergency Assessment', '2026-03-01 10:25', 'Dysuria, fever', 'Costovertebral tenderness', 'Positive urinalysis', 'Urinary tract infection', 'Renal ultrasound, urine culture', 'IV antibiotics, hydration', 'Rule out obstruction.'),
(7, 7, 'Emergency Assessment', '2026-03-05 07:00', 'Weakness, slurred speech', 'Right hemiparesis, aphasia', 'NIHSS 14', 'Ischemic stroke', 'Head CT, brain MRI', 'Thrombectomy evaluation, antiplatelet', 'Within stroke window.'),
(8, 8, 'Emergency Assessment', '2026-03-12 03:45', 'Severe dyspnea', 'Bilateral crackles, leg edema', 'Pulmonary edema', 'Acute decompensated heart failure', 'Chest X-ray, BNP', 'IV diuretics, oxygen', 'Transfer to ICU.'),
(9, 9, 'Emergency Assessment', '2026-04-02 17:00', 'Cough, wheeze', 'Prolonged expiration', 'Hypoxemia', 'COPD exacerbation', 'Chest CT', 'Bronchodilators, steroids', 'Known COPD patient.'),
(10,10,'Emergency Assessment', '2026-04-08 11:40', 'Mild abdominal pain', 'Soft abdomen, mild tenderness', 'Normal vitals', 'Nonspecific abdominal pain', 'Blood tests', 'Observation, analgesia', 'Symptoms resolved.'),
(11,11,'Emergency Assessment', '2026-05-02 09:30', 'Leg swelling, fatigue', 'Pitting edema', 'Elevated BNP', 'Congestive heart failure', 'Chest X-ray', 'Diuretics, admit to ward', 'Readmission of earlier cardiac patient.'),
(12,12,'Emergency Assessment', '2026-06-15 13:45', 'Wheezing, chest tightness', 'Diffuse wheezes', 'Reduced peak flow', 'Asthma exacerbation', 'None', 'Nebulizers, steroids', 'Admitted for observation.');

INSERT INTO Diagnostic_Order VALUES
(1, 1, 1, 'Dr. Alice Moreau', 'Chest X-ray',    '2026-01-05 08:45', 'Chest pain, rule out complications', 'High',   'Completed'),
(2, 1, 1, 'Dr. Alice Moreau', 'Echocardiogram', '2026-01-05 09:00', 'Assess cardiac function', 'High',   'Completed'),
(3, 2, 2, 'Dr. Ben Walker',   'Chest X-ray',    '2026-01-12 14:30', 'Suspected pneumonia', 'High',   'Completed'),
(4, 3, 3, 'Dr. Chloe Singh',  'Abdominal CT',   '2026-02-03 22:35', 'Suspected appendicitis', 'High',   'Completed'),
(5, 4, 4, 'Dr. Alice Moreau', 'Hip X-ray',      '2026-02-10 09:50', 'Suspected fracture', 'High',   'Completed'),
(6, 5, 5, 'Dr. Ben Walker',   'Chest X-ray',    '2026-02-20 19:30', 'Asthma exacerbation', 'Medium', 'Completed'),
(7, 7, 7, 'Dr. Alice Moreau', 'Head CT',        '2026-03-05 06:55', 'Stroke alert', 'Urgent', 'Completed'),
(8, 7, 7, 'Dr. Alice Moreau', 'Brain MRI',      '2026-03-05 09:45', 'Define infarct extent', 'High',   'Completed'),
(9, 8, 8, 'Dr. Ben Walker',   'Chest X-ray',    '2026-03-12 03:50', 'Pulmonary edema', 'Urgent', 'Completed'),
(10,9, 9, 'Dr. Chloe Singh',  'Chest CT',       '2026-04-02 17:10', 'COPD exacerbation', 'Medium', 'In Progress'),
(11,6, 6, 'Dr. Chloe Singh',  'Renal ultrasound','2026-03-01 10:30', 'Rule out obstruction', 'Medium', 'Cancelled'),
(12,1,11, 'Dr. Alice Moreau', 'Chest X-ray',    '2026-05-02 09:40', 'Assess pulmonary congestion', 'Medium', 'Pending');

INSERT INTO Radiology_Examination VALUES
(1, 1, 1, 1, 'X-ray',       '2026-01-05 09:15', 'Chest',     'Dr. Alice Moreau', 'Tech Paul Girard',   'Completed',   'https://images.example.org/exam/1'),
(2, 2, 1, 1, 'Ultrasound',  '2026-01-05 09:45', 'Heart',     'Dr. Alice Moreau', 'Tech Sara Bouchard', 'Completed',   'https://images.example.org/exam/2'),
(3, 3, 2, 2, 'X-ray',       '2026-01-12 14:50', 'Chest',     'Dr. Ben Walker',   'Tech Paul Girard',   'Completed',   'https://images.example.org/exam/3'),
(4, 4, 3, 3, 'CT',          '2026-02-03 23:00', 'Abdomen',   'Dr. Chloe Singh',  'Tech Sara Bouchard', 'Completed',   'https://images.example.org/exam/4'),
(5, 5, 4, 4, 'X-ray',       '2026-02-10 10:15', 'Right hip', 'Dr. Alice Moreau', 'Tech Paul Girard',   'Completed',   'https://images.example.org/exam/5'),
(6, 6, 5, 5, 'X-ray',       '2026-02-20 19:50', 'Chest',     'Dr. Ben Walker',   'Tech Sara Bouchard', 'Completed',   'https://images.example.org/exam/6'),
(7, 7, 7, 7, 'CT',          '2026-03-05 07:10', 'Head',      'Dr. Alice Moreau', 'Tech Paul Girard',   'Completed',   'https://images.example.org/exam/7'),
(8, 8, 7, 7, 'MRI',         '2026-03-05 10:15', 'Brain',     'Dr. Alice Moreau', 'Tech Sara Bouchard', 'Completed',   'https://images.example.org/exam/8'),
(9, 9, 8, 8, 'X-ray',       '2026-03-12 04:10', 'Chest',     'Dr. Ben Walker',   'Tech Paul Girard',   'Completed',   'https://images.example.org/exam/9'),
(10,10,9, 9, 'CT',          '2026-04-02 18:00', 'Chest',     'Dr. Chloe Singh',  'Tech Sara Bouchard', 'In Progress', NULL);

INSERT INTO Diagnostic_Record VALUES
(1, 1, 1, '410.91', '2026-01-05 09:30', 'Primary',   'Dr. Alice Moreau'),
(2, 1, 1, '401.9',  '2026-01-06 09:00', 'Secondary', 'Dr. Alice Moreau'),
(3, 2, 2, '486',    '2026-01-12 15:00', 'Primary',   'Dr. Ben Walker'),
(4, 2, 2, '250.00', '2026-01-12 15:30', 'Secondary', 'Dr. Ben Walker'),
(5, 3, 3, '540.9',  '2026-02-03 23:30', 'Primary',   'Dr. Chloe Singh'),
(6, 4, 4, '820.8',  '2026-02-10 10:30', 'Primary',   'Dr. Alice Moreau'),
(7, 4, 4, '401.9',  '2026-02-10 10:45', 'Secondary', 'Dr. Alice Moreau'),
(8, 5, 5, '493.90', '2026-02-20 20:00', 'Primary',   'Dr. Ben Walker'),
(9, 6, 6, '599.0',  '2026-03-01 11:00', 'Primary',   'Dr. Chloe Singh'),
(10,7, 7, '434.91', '2026-03-05 07:30', 'Primary',   'Dr. Alice Moreau'),
(11,7, 7, '401.9',  '2026-03-05 11:00', 'Secondary', 'Dr. Alice Moreau'),
(12,8, 8, '428.0',  '2026-03-12 04:30', 'Primary',   'Dr. Ben Walker'),
(13,9, 9, '491.21', '2026-04-02 17:30', 'Primary',   'Dr. Chloe Singh'),
(14,10,10,'789.00', '2026-04-08 12:00', 'Primary',   'Dr. Ben Walker'),
(15,1, 11,'428.0',  '2026-05-02 10:00', 'Primary',   'Dr. Alice Moreau'),
(16,1, 11,'401.9',  '2026-05-02 10:30', 'Secondary', 'Dr. Alice Moreau'),
(17,3, 12,'493.90', '2026-06-15 14:00', 'Primary',   'Dr. Chloe Singh'),
(18,9, 9, '250.00', '2026-04-03 09:00', 'Secondary', 'Dr. Chloe Singh');

INSERT INTO Surgical_Procedure VALUES
(1, 1, 1, 'Percutaneous coronary intervention', '2026-01-05 13:00', 'Dr. Victor Lambert', 'Completed', 'Stent placed in LAD without complication'),
(2, 3, 3, 'Laparoscopic appendectomy',          '2026-02-04 01:30', 'Dr. Priya Desai',    'Completed', 'Uncomplicated appendectomy'),
(3, 4, 4, 'Hip hemiarthroplasty',               '2026-02-10 13:00', 'Dr. Marc Fortin',    'Completed', 'Right hip, spinal anesthesia'),
(4, 7, 7, 'Mechanical thrombectomy',            '2026-03-05 07:45', 'Dr. Victor Lambert', 'Completed', 'Successful recanalization');

INSERT INTO Unit_Stay VALUES
(1,  1, 'Emergency',     'ER-A / Room 3',  '3',  '2026-01-05 08:20', '2026-01-05 12:00', 'Dr. Alice Moreau', 'Initial assessment'),
(2,  1, 'ICU',           'ICU / Room 2',   '2',  '2026-01-05 12:30', '2026-01-07 10:00', 'Dr. Victor Lambert', 'Post-PCI monitoring'),
(3,  1, 'General Ward',  'Ward 4B / Room 12','12B','2026-01-07 10:30','2026-01-09 11:00', 'Dr. Alice Moreau', 'Stable, step-down care'),
(4,  2, 'Emergency',     'ER-B / Room 1',  '1',  '2026-01-12 14:00', '2026-01-12 16:30', 'Dr. Ben Walker',   'Initial assessment'),
(5,  2, 'General Ward',  'Ward 3A / Room 8','8A','2026-01-12 17:00', '2026-01-18 10:00', 'Dr. Ben Walker',   'IV antibiotics'),
(6,  3, 'Emergency',     'ER-A / Room 5',  '5',  '2026-02-03 22:00', '2026-02-04 01:00', 'Dr. Chloe Singh',  'Initial assessment'),
(7,  3, 'Surgery',       'OR 2',           '1',  '2026-02-04 01:30', '2026-02-04 04:00', 'Dr. Priya Desai',  'Appendectomy'),
(8,  3, 'General Ward',  'Ward 2C / Room 4','4B','2026-02-04 05:00', '2026-02-07 09:00', 'Dr. Priya Desai',  'Post-operative recovery'),
(9,  4, 'Emergency',     'ER-B / Room 2',  '2',  '2026-02-10 09:35', '2026-02-10 12:00', 'Dr. Alice Moreau', 'Initial assessment'),
(10, 4, 'Surgery',       'OR 1',           '1',  '2026-02-10 13:00', '2026-02-10 16:00', 'Dr. Marc Fortin',  'Hip surgery'),
(11, 4, 'General Ward',  'Ward 5A / Room 3','3A','2026-02-10 17:00', '2026-02-16 11:00', 'Dr. Marc Fortin',  'Post-operative rehab'),
(12, 5, 'Emergency',     'ER-A / Room 2',  '2',  '2026-02-20 19:05', '2026-02-20 23:30', 'Dr. Ben Walker',   'Treated and observed'),
(13, 6, 'General Ward',  'Ward 3B / Room 6','6A','2026-03-01 12:00', '2026-03-04 13:00', 'Dr. Chloe Singh',  'IV antibiotics'),
(14, 7, 'Emergency',     'ER-A / Room 1',  '1',  '2026-03-05 06:50', '2026-03-05 09:00', 'Dr. Alice Moreau', 'Stroke protocol'),
(15, 7, 'ICU',           'ICU / Room 4',   '4',  '2026-03-05 09:30', '2026-03-08 12:00', 'Dr. Victor Lambert', 'Post-thrombectomy care'),
(16, 8, 'ICU',           'ICU / Room 1',   '1',  '2026-03-12 04:00', '2026-03-14 05:10', 'Dr. Ben Walker',   'Acute heart failure'),
(17, 9, 'General Ward',  'Ward 3A / Room 10','10B','2026-04-02 19:00', NULL,                'Dr. Chloe Singh',  'COPD exacerbation treatment'),
(18, 11,'General Ward',  'Ward 4B / Room 14','14A','2026-05-02 11:00','2026-05-08 09:30', 'Dr. Alice Moreau', 'Heart failure management');

INSERT INTO General_Ward VALUES
(1, 3,  'Vitals stable every 4 hours', 'Cardiology review, ECG normal', 'Aspirin, metoprolol', 'Day 2: ambulating, no chest pain', 'None', 'Good recovery'),
(2, 5,  'Temperature trending down', 'Lung exam improving', 'IV antibiotics, insulin', 'Day 4: afebrile, oxygen weaned', 'Repeat chest X-ray', 'Recovering well'),
(3, 8,  'Wound clean and dry', 'Surgeon review, afebrile', 'Analgesics, antibiotics', 'Post-op day 2: tolerating diet', 'None', 'Excellent recovery'),
(4, 11, 'Pain controlled, mobilizing with walker', 'Orthopedic follow-up', 'Enoxaparin, analgesics', 'Post-op day 3: physiotherapy started', 'Hip X-ray', 'Progressing with rehab'),
(5, 13, 'Fever resolved day 2', 'Renal exam normal', 'IV ceftriaxone', 'Day 2: urine culture sensitive', 'Urine culture', 'Recovered'),
(6, 17, 'Oxygen saturation monitored hourly', 'Respiratory review', 'Bronchodilators, prednisone', 'Day 1: dyspnea improving slowly', 'Chest CT', 'Ongoing treatment'),
(7, 18, 'Daily weights recorded', 'Cardiology follow-up', 'Furosemide, ramipril', 'Day 3: edema reduced', 'Echocardiogram', 'Responding to diuresis');

INSERT INTO Discharge_Record VALUES
(1,  1,  '2026-01-09 11:30', 'Home', 'Stable, pain-free', '410.91', '401.9', 'Aspirin, atorvastatin, metoprolol', 'Cardiac rehab, low-salt diet', '2026-01-23 10:00 Cardiology clinic', 'Dr. Alice Moreau'),
(2,  2,  '2026-01-18 10:30', 'Home', 'Afebrile, oxygen saturation normal', '486', '250.00', 'Amoxicillin-clavulanate, metformin', 'Complete antibiotics, rest', '2026-01-30 14:00 Family doctor', 'Dr. Ben Walker'),
(3,  3,  '2026-02-07 09:30', 'Home', 'Recovered from surgery', '540.9', NULL, 'Acetaminophen', 'No heavy lifting for 2 weeks', '2026-02-21 09:00 Surgery clinic', 'Dr. Priya Desai'),
(4,  4,  '2026-02-16 12:00', 'Rehabilitation Center', 'Stable, mobilizing with walker', '820.8', '401.9', 'Enoxaparin, acetaminophen, amlodipine', 'Physiotherapy daily', '2026-03-02 11:00 Orthopedic clinic', 'Dr. Marc Fortin'),
(5,  5,  '2026-02-20 23:45', 'Home', 'Breathing normal', '493.90', NULL, 'Prednisone, salbutamol inhaler', 'Avoid triggers, use inhaler as needed', '2026-03-06 15:00 Family doctor', 'Dr. Ben Walker'),
(6,  6,  '2026-03-04 14:00', 'Home', 'Afebrile, symptoms resolved', '599.0', NULL, 'Oral antibiotics', 'Increase fluid intake', '2026-03-18 10:30 Family doctor', 'Dr. Chloe Singh'),
(7,  7,  '2026-03-19 15:00', 'Rehabilitation Center', 'Improved, mild residual weakness', '434.91', '401.9', 'Clopidogrel, atorvastatin, ramipril', 'Speech and physical therapy', '2026-04-02 13:00 Neurology clinic', 'Dr. Alice Moreau'),
(8,  8,  '2026-03-14 05:10', 'Deceased', 'Deceased', '428.0', NULL, NULL, NULL, NULL, 'Dr. Ben Walker'),
(9,  10, '2026-04-08 18:00', 'Home', 'Pain resolved', '789.00', NULL, 'None', 'Return if pain worsens', NULL, 'Dr. Ben Walker'),
(10, 11, '2026-05-08 10:00', 'Home', 'Edema resolved, stable', '428.0', '401.9', 'Furosemide, ramipril, carvedilol', 'Daily weights, low-sodium diet', '2026-05-22 09:30 Cardiology clinic', 'Dr. Alice Moreau');
