-- Create table for Healthcare Professional
CREATE TABLE IF NOT EXISTS Healthcare_Professional (
    professional_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- Create table for Hospital Unit
CREATE TABLE IF NOT EXISTS Hospital_Unit (
    unit_id INT PRIMARY KEY,
    unit_type VARCHAR(50) UNIQUE NOT NULL
);

-- Create table for Patient
CREATE TABLE IF NOT EXISTS Patient (
    patient_id INT PRIMARY KEY,
    full_name VARCHAR(50),
    health_insurance_number INT,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    address VARCHAR(255),
    telephone_number VARCHAR(10),
    emergency_contact_info VARCHAR(255),
    life_status VARCHAR(20)
);

-- Create table for ICD-9 Dictionary
CREATE TABLE IF NOT EXISTS ICD9_Dictionary (
    icd_9_code VARCHAR(10) PRIMARY KEY,
    official_diagnosis_title VARCHAR(255),
    description VARCHAR(255),
    disease_category VARCHAR(100)
);

-- Create table for Admission
CREATE TABLE IF NOT EXISTS Admission (
    admission_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    admission_date_time TIMESTAMP,
    reason_for_visit VARCHAR(255),
    admission_type VARCHAR(50),
    admission_source VARCHAR(50),
    insurance_info VARCHAR(50),
    patient_current_condition VARCHAR(255),
    -- We can store professional_id as a foreign key referencing Healthcare_Professional, then retrieve the professional's name using a JOIN. It is better practice since 
    -- multiple Healthcare_Professional could have the same name
    admitting_healthcare_professional_id INT NOT NULL,
    final_admission_status VARCHAR(50) NOT NULL
        CHECK (final_admission_status IN ('Admitted', 'Completed', 'Discharged', 'Deceased')),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (admitting_healthcare_professional_id) REFERENCES Healthcare_Professional(professional_id),
    UNIQUE (admission_id, patient_id)
);

-- Create table for Assessment
CREATE TABLE IF NOT EXISTS Triage_Assessment (
    assessment_id INT PRIMARY KEY,
    admission_id INT NOT NULL,
    assessment_date_time TIMESTAMP,
    assessment_results VARCHAR(255),
    healthcare_professional_in_charge INT NOT NULL,
    blood_pressure VARCHAR(10),
    heart_rate INT,
    respiratory_rate INT,
    body_temperature DECIMAL(4,1),
    -- 0% to 100% oxygen saturation
    oxygen_saturation DECIMAL(4,1) CHECK (oxygen_saturation BETWEEN 0 AND 100),
    pain_level INT CHECK (pain_level BETWEEN 0 AND 10),
    reported_symptoms VARCHAR(255),
    known_allergies VARCHAR(255),
    current_medications VARCHAR(255),
    triage_priority_level VARCHAR(10)
        CHECK (triage_priority_level IN ('Low', 'Medium', 'High')),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (healthcare_professional_in_charge) REFERENCES Healthcare_Professional(professional_id)
);

-- Create table for Clinical_Note (Emergency Department Assessment)
CREATE TABLE IF NOT EXISTS Clinical_Note (
    clinical_note_id INT PRIMARY KEY,
    admission_id INT,
    note_type VARCHAR(50),
    note_date_time TIMESTAMP,
    patients_symptoms VARCHAR(255),
    physical_examination VARCHAR(255),
    initial_clinical_findings VARCHAR(255),
    suspected_medical_condition VARCHAR(255),
    planned_diagnostic_examinations VARCHAR(255),
    initial_treatment_plan VARCHAR(255),
    note_content TEXT,
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id)
);

-- Create table for Diagnostic Order
CREATE TABLE IF NOT EXISTS Diagnostic_Order (
    diagnostic_order_id INT PRIMARY KEY,
    admission_id INT NOT NULL,
    requesting_physician INT NOT NULL,
    requested_examination VARCHAR(255),
    request_date_time TIMESTAMP,
    clinical_reason_for_examination VARCHAR(255),
    priority VARCHAR(50),
    order_status VARCHAR(50),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (requesting_physician) REFERENCES Healthcare_Professional(professional_id)
);

-- Create table for Radiology Report
CREATE TABLE IF NOT EXISTS Radiology_Report (
    examination_id INT PRIMARY KEY,
    diagnostic_order_id INT NOT NULL,
    examination_type VARCHAR(50),
    examination_date_time TIMESTAMP,
    body_area_examined VARCHAR(50),
    referring_physician INT NOT NULL,
    radiology_technician INT NOT NULL,
    examination_status VARCHAR(50),
    medical_images_link VARCHAR(255),
    findings TEXT,
    interpretation TEXT,
    conclusion TEXT,
    FOREIGN KEY (diagnostic_order_id) REFERENCES Diagnostic_Order(diagnostic_order_id),
    FOREIGN KEY (referring_physician) REFERENCES Healthcare_Professional(professional_id),
    FOREIGN KEY (radiology_technician) REFERENCES Healthcare_Professional(professional_id)
);

-- Create table for Diagnosis Record
CREATE TABLE IF NOT EXISTS Diagnosis_Record (
    diagnosis_id INT PRIMARY KEY,
    admission_id INT NOT NULL,
    icd_9_code VARCHAR(10),
    diagnosis_date_time TIMESTAMP,
    diagnosis_type VARCHAR(50) NOT NULL CHECK (diagnosis_type IN ('Primary', 'Secondary')),
    diagnosing_physician INT NOT NULL,
    CHECK (diagnosis_type <> 'Primary' OR icd_9_code IS NOT NULL),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (icd_9_code) REFERENCES ICD9_Dictionary(icd_9_code),
    FOREIGN KEY (diagnosing_physician) REFERENCES Healthcare_Professional(professional_id)
);

-- Create table for Surgical Procedure
CREATE TABLE IF NOT EXISTS Surgical_Procedure (
    surgical_procedure_id INT PRIMARY KEY,
    admission_id INT NOT NULL,
    procedure_type VARCHAR(100),
    procedure_date_time TIMESTAMP,
    performing_surgeon INT NOT NULL,
    procedure_status VARCHAR(50),
    procedure_notes VARCHAR(255),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (performing_surgeon) REFERENCES Healthcare_Professional(professional_id)
);

-- Create table for Unit Stay
CREATE TABLE IF NOT EXISTS Unit_Stay (
    unit_stay_id INT PRIMARY KEY,
    admission_id INT NOT NULL,
    unit_id INT NOT NULL,
    ward_and_room VARCHAR(50),
    bed_number VARCHAR(10),
    entry_date_time TIMESTAMP NOT NULL,
    exit_date_time TIMESTAMP CHECK (exit_date_time IS NULL OR exit_date_time >= entry_date_time),
    responsible_physician INT NOT NULL,
    reason_for_transfer VARCHAR(255),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (unit_id) REFERENCES Hospital_Unit(unit_id),
    FOREIGN KEY (responsible_physician) REFERENCES Healthcare_Professional(professional_id)
);

-- Create table for General Ward
CREATE TABLE IF NOT EXISTS General_Ward (
    progress_note_id INT PRIMARY KEY,
    unit_stay_id INT NOT NULL,
    nursing_monitoring_notes VARCHAR(255),
    physician_follow_up_examination VARCHAR(255),
    medications_and_treatments_administered VARCHAR(255),
    progress_notes VARCHAR(255),
    additional_tests_requested VARCHAR(255),
    recovery_evaluation VARCHAR(255),
    FOREIGN KEY (unit_stay_id) REFERENCES Unit_Stay(unit_stay_id)
);

-- Create table for Discharge Record
CREATE TABLE IF NOT EXISTS Discharge_Record (
    discharge_record_id INT PRIMARY KEY,
    admission_id INT NOT NULL UNIQUE,
    discharge_date_time TIMESTAMP,
    discharge_destination VARCHAR(50),
    patients_condition_at_discharge VARCHAR(255),
    prescribed_medications VARCHAR(255),
    follow_up_instructions VARCHAR(255),
    scheduled_follow_up_appointments VARCHAR(255),
    responsible_physician INT NOT NULL,
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id),
    FOREIGN KEY (responsible_physician) REFERENCES Healthcare_Professional(professional_id)
);
