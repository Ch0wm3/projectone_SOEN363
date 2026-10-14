-- Create table for Patient
CREATE TABLE IF NOT EXISTS Patient (
    patient_identifier INT PRIMARY KEY,
    health_insurance_number INT,
    full_name VARCHAR(50),
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    address VARCHAR(255),
    telephone_number VARCHAR(10),
    emergency_contact_information VARCHAR(255),
    life_status VARCHAR(20)
);

-- Create table for Admission
CREATE TABLE IF NOT EXISTS Admission (
    admission_identifier INT PRIMARY KEY,
    patient_identifier INT,
    admission_date_and_time TIMESTAMP,
    reason_for_the_visit VARCHAR(255),
    admission_type VARCHAR(50),
    admission_source VARCHAR(50),
    insurance_information VARCHAR(50),
    patient_current_condition VARCHAR(255),
    name_of_the_admitting_healthcare_professional VARCHAR(50),
    final_admission_status VARCHAR(50),
    FOREIGN KEY (patient_identifier) REFERENCES Patient(patient_identifier)
);

-- Create table for Assessment
CREATE TABLE IF NOT EXISTS Triage_and_Assessment (
    assessment_identifier INT PRIMARY KEY,
    admission_identifier INT,
    assessment_date_and_time TIMESTAMP,
    assessment_type VARCHAR(50),
    assessment_results VARCHAR(255),
    healthcare_professional_in_charge VARCHAR(50),
    blood_pressure VARCHAR(10),
    heart_rate INT,
    respiratory_rate INT,
    body_temperature DECIMAL(4,1),
    oxygen_saturation DECIMAL(4,1),
    pain_level INT,
    reported_symptoms VARCHAR(255),
    known_allergies VARCHAR(255),
    current_medications VARCHAR(255),
    triage_priority_level VARCHAR(50),
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier)
);

-- Create table for Clinical_Note (Emergency Depertment Assessment)
CREATE TABLE IF NOT EXISTS Clinical_Note (
    clinical_note_identifier INT PRIMARY KEY,
    admission_identifier INT,
    note_type VARCHAR(50),
    note_date_and_time TIMESTAMP,
    patients_symptoms VARCHAR(255),
    physical_examination VARCHAR(255),
    initial_clinical_findings VARCHAR(255),
    suspected_medical_condition VARCHAR(255),
    planned_diagnostic_examinations VARCHAR(255),
    initial_treatment_plan VARCHAR(255),
    note_content TEXT,
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier)
);

-- Create table for Diagnostic Order
CREATE TABLE IF NOT EXISTS Diagnostic_Order (
    diagnostic_order_identifier INT PRIMARY KEY,
    patient_identifier INT,
    admission_identifier INT,
    requesting_physician VARCHAR(50),
    requested_examination VARCHAR(255),
    request_date_and_time TIMESTAMP,
    clinical_reason_for_the_examination VARCHAR(255),
    priority VARCHAR(50),
    order_status VARCHAR(50),
    FOREIGN KEY (patient_identifier) REFERENCES Patient(patient_identifier),
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier)
);

-- Create table for ICD-9 Dictionary
CREATE TABLE IF NOT EXISTS ICD9_Dictionary (
    icd_9_code VARCHAR(10) PRIMARY KEY,
    official_diagnosis_title VARCHAR(255),
    description VARCHAR(255),
    disease_category VARCHAR(100)
);

-- Create table for Radiology Examination
CREATE TABLE IF NOT EXISTS Radiology_Examination (
    examination_identifier INT PRIMARY KEY,
    diagnostic_order_identifier INT,
    patient_identifier INT,
    admission_identifier INT,
    examination_type VARCHAR(50),
    examination_date_and_time TIMESTAMP,
    body_area_examined VARCHAR(50),
    referring_physician VARCHAR(50),
    radiology_technician VARCHAR(50),
    examination_status VARCHAR(50),
    link_to_the_resulting_medical_images VARCHAR(255),
    FOREIGN KEY (diagnostic_order_identifier) REFERENCES Diagnostic_Order(diagnostic_order_identifier),
    FOREIGN KEY (patient_identifier) REFERENCES Patient(patient_identifier),
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier)
);

-- Create table for Diagnostic Record
CREATE TABLE IF NOT EXISTS Diagnostic_Record (
    diagnosis_identifier INT PRIMARY KEY,
    patient_identifier INT,
    admission_identifier INT,
    icd_9_code VARCHAR(10),
    diagnosis_date_and_time TIMESTAMP,
    diagnosis_type VARCHAR(50),
    diagnosing_physician VARCHAR(50),
    FOREIGN KEY (patient_identifier) REFERENCES Patient(patient_identifier),
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier),
    FOREIGN KEY (icd_9_code) REFERENCES ICD9_Dictionary(icd_9_code)
);

-- Create table for Surgical Procedure
CREATE TABLE IF NOT EXISTS Surgical_Procedure (
    surgical_procedure_identifier INT PRIMARY KEY,
    patient_identifier INT,
    admission_identifier INT,
    procedure_type VARCHAR(100),
    procedure_date_and_time TIMESTAMP,
    performing_surgeon VARCHAR(50),
    procedure_status VARCHAR(50),
    procedure_notes VARCHAR(255),
    FOREIGN KEY (patient_identifier) REFERENCES Patient(patient_identifier),
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier)
);

-- Create table for Unit Stay
CREATE TABLE IF NOT EXISTS Unit_Stay (
    unit_stay_identifier INT PRIMARY KEY,
    admission_identifier INT,
    unit_type VARCHAR(50),
    ward_and_room VARCHAR(50),
    bed_number VARCHAR(10),
    entry_date_and_time TIMESTAMP,
    exit_date_and_time TIMESTAMP,
    responsible_physician VARCHAR(50),
    reason_for_transfer VARCHAR(255),
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier)
);

-- Create table for General Ward
CREATE TABLE IF NOT EXISTS General_Ward (
    progress_note_identifier INT PRIMARY KEY,
    unit_stay_identifier INT,
    nursing_monitoring_notes VARCHAR(255),
    physician_follow_up_examination VARCHAR(255),
    medications_and_treatments_administered VARCHAR(255),
    progress_notes VARCHAR(255),
    additional_tests_requested VARCHAR(255),
    recovery_evaluation VARCHAR(255),
    FOREIGN KEY (unit_stay_identifier) REFERENCES Unit_Stay(unit_stay_identifier)
);

-- Create table for Discharge Record
CREATE TABLE IF NOT EXISTS Discharge_Record (
    discharge_record_identifier INT PRIMARY KEY,
    admission_identifier INT UNIQUE,
    discharge_date_and_time TIMESTAMP,
    discharge_destination VARCHAR(50),
    patients_condition_at_discharge VARCHAR(255),
    primary_icd_9_diagnosis VARCHAR(10),
    secondary_icd_9_diagnoses VARCHAR(255),
    prescribed_medications VARCHAR(255),
    follow_up_instructions VARCHAR(255),
    scheduled_follow_up_appointments VARCHAR(255),
    responsible_physician VARCHAR(50),
    FOREIGN KEY (admission_identifier) REFERENCES Admission(admission_identifier),
    FOREIGN KEY (primary_icd_9_diagnosis) REFERENCES ICD9_Dictionary(icd_9_code)
);

