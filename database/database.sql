-- Oracle SQL

-- Procedimientos

CREATE OR REPLACE PROCEDURE delete_medic (id INT) AS 
BEGIN
    DELETE FROM medics WHERE id_medic = id;
    DBMS_OUTPUT.PUT_LINE('Se eliminó el registro');
END delete_medic;

CREATE OR REPLACE PROCEDURE delete_patient (id INT) AS 
BEGIN
    DELETE FROM patients WHERE id_patient = id;
    DBMS_OUTPUT.PUT_LINE('Se eliminó el registro');
END delete_patient;

CREATE OR REPLACE PROCEDURE new_medic (
    matricul_medic VARCHAR2,
    name_medic VARCHAR2,
    surname_medic VARCHAR2,
    gender_medic NUMBER,
    day_of_birth_medic DATE,
    email_medic VARCHAR2,
    phone_medic VARCHAR2,
    specialty_medic NUMBER,
    is_active NUMBER
) AS 
BEGIN
    BEGIN
        INSERT INTO medics (
            matricul_medic,
            name_medic,
            surname_medic,
            gender_medic,
            day_of_birth_medic,
            email_medic,
            phone_medic,
            specialty_medic,
            is_active
        ) VALUES (
            matricul_medic,
            name_medic,
            surname_medic,
            gender_medic,
            day_of_birth_medic,
            email_medic,
            phone_medic,
            specialty_medic,
            is_active
        );
        DBMS_OUTPUT.PUT_LINE('Se insertó un nuevo registro');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('El MÉDICO está repetido, revise el formulario de carga');
    END;
END new_medic;

CREATE OR REPLACE PROCEDURE new_patient (
    dni VARCHAR2,
    name VARCHAR2,
    surname VARCHAR2,
    gender NUMBER,
    day_of_birth DATE,
    email VARCHAR2,
    phone VARCHAR2,
    is_active NUMBER
) AS 
BEGIN
    BEGIN
        INSERT INTO patients (
            dni,
            name,
            surname,
            gender,
            day_of_birth,
            email,
            phone,
            is_active
        ) VALUES (
            dni,
            name,
            surname,
            gender,
            day_of_birth,
            email,
            phone,
            is_active
        );
        DBMS_OUTPUT.PUT_LINE('Se insertó un nuevo registro');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('El PACIENTE está repetido, revise el formulario de carga');
    END;
END new_patient;

CREATE OR REPLACE PROCEDURE select_gender AS 
BEGIN
    FOR rec IN (SELECT gender_id AS id, gender_name AS name FROM genders) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id || ', Name: ' || rec.name);
    END LOOP;
END select_gender;

CREATE OR REPLACE PROCEDURE select_specialty AS 
BEGIN
    FOR rec IN (SELECT specialty_id AS id, specialty_name AS name FROM specialties) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id || ', Name: ' || rec.name);
    END LOOP;
END select_specialty;

CREATE OR REPLACE PROCEDURE select_status AS 
BEGIN
    FOR rec IN (SELECT state_id AS id, state_name AS name FROM status) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec.id || ', Name: ' || rec.name);
    END LOOP;
END select_status;

CREATE OR REPLACE PROCEDURE update_clinic_history (
    up_clinic_history TEXT,
    up_id_patient INT,
    up_id_medic INT,
    up_id INT
) AS 
BEGIN
    UPDATE clinic_history SET
        clinic_history = up_clinic_history,
        id_patient = up_id_patient,
        id_medic = up_id_medic,
        last_update = CURRENT_TIMESTAMP
    WHERE id_clinic_history = up_id;
    DBMS_OUTPUT.PUT_LINE('Se actualizó el registro');
END update_clinic_history;

CREATE OR REPLACE PROCEDURE update_clinic_history_symptoms (
    up_code VARCHAR2,
    up_id INT
) AS 
BEGIN
    UPDATE clinic_history_symptoms
    SET
        code = up_code
    WHERE id_clinic_history = up_id;
    DBMS_OUTPUT.PUT_LINE('Se actualizó el registro');
END update_clinic_history_symptoms;

CREATE OR REPLACE PROCEDURE update_medic (
    up_matricul VARCHAR2,
    up_name VARCHAR2,
    up_surname VARCHAR2,
    up_gender NUMBER,
    up_day_of_birth DATE,
    up_email VARCHAR2,
    up_phone VARCHAR2,
    up_specialty NUMBER,
    up_state NUMBER,
    up_id INT
) AS 
BEGIN
    UPDATE medics SET
        matricul_medic = up_matricul,
        name_medic = up_name,
        surname_medic = up_surname,
        gender_medic = up_gender,
        day_of_birth_medic = up_day_of_birth,
        email_medic = up_email,
        phone_medic = up_phone,
        specialty_medic = up_specialty,
        is_active = up_state,
        created_at = CURRENT_TIMESTAMP
    WHERE id_medic = up_id;
    DBMS_OUTPUT.PUT_LINE('Se actualizó el registro');
END update_medic;

CREATE OR REPLACE PROCEDURE update_patient (
    up_dni VARCHAR2,
    up_name VARCHAR2,
    up_surname VARCHAR2,
    up_gender NUMBER,
    up_day_of_birth DATE,
    up_email VARCHAR2,
    up_phone VARCHAR2,
    up_state NUMBER,
    up_id INT
) AS 
BEGIN
    UPDATE patients SET
        dni = up_dni,
        name = up_name,
        surname = up_surname,
        gender = up_gender,
        day_of_birth = up_day_of_birth,
        email = up_email,
        phone = up_phone,
        is_active = up_state,
        created_at = CURRENT_TIMESTAMP
    WHERE id_patient = up_id;
    DBMS_OUTPUT.PUT_LINE('Se actualizó el registro');
END update_patient;



-- Creación de tablas

CREATE TABLE admins (
    id_admin NUMBER PRIMARY KEY,
    username VARCHAR2(255) UNIQUE NOT NULL,
    password VARCHAR2(255) NOT NULL
);

CREATE TABLE patients (
    id_patient NUMBER PRIMARY KEY,
    dni VARCHAR2(255) UNIQUE NOT NULL,
    name VARCHAR2(255) NOT NULL,
    surname VARCHAR2(255) NOT NULL,
    gender NUMBER,
    day_of_birth DATE,
    email VARCHAR2(255),
    phone VARCHAR2(255),
    is_active NUMBER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_status_patient FOREIGN KEY (is_active) REFERENCES status(state_id)
);

CREATE TABLE medics (
    id_medic NUMBER PRIMARY KEY,
    matricul_medic VARCHAR2(255) UNIQUE NOT NULL,
    name_medic VARCHAR2(255) NOT NULL,
    surname_medic VARCHAR2(255) NOT NULL,
    gender_medic NUMBER,
    day_of_birth_medic DATE,
    email_medic VARCHAR2(255),
    phone_medic VARCHAR2(255),
    specialty_medic NUMBER,
    is_active NUMBER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_status_medic FOREIGN KEY (is_active) REFERENCES status(state_id),
    CONSTRAINT fk_specialty_medic FOREIGN KEY (specialty_medic) REFERENCES specialties(specialty_id)
);


CREATE TABLE genders (
    gender_id NUMBER PRIMARY KEY,
    gender_name VARCHAR2(255) NOT NULL
);

CREATE TABLE specialties (
    specialty_id NUMBER PRIMARY KEY,
    specialty_name VARCHAR2(255) NOT NULL
);

CREATE TABLE status (
    state_id NUMBER PRIMARY KEY,
    state_name VARCHAR2(255) NOT NULL
);

CREATE TABLE symptoms (
    symptom_id NUMBER PRIMARY KEY,
    symptom_name VARCHAR2(255) NOT NULL
);

CREATE TABLE clinic_history (
    id_clinic_history NUMBER PRIMARY KEY,
    clinic_history TEXT,
    id_patient NUMBER,
    id_medic NUMBER,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_patient_history FOREIGN KEY (id_patient) REFERENCES patients(id_patient),
    CONSTRAINT fk_medic_history FOREIGN KEY (id_medic) REFERENCES medics(id_medic)
);

CREATE TABLE clinic_history_symptoms (
    id_clinic_history_symptoms NUMBER PRIMARY KEY,
    id_clinic_history NUMBER,
    code VARCHAR2(255),
    CONSTRAINT fk_history_symptoms FOREIGN KEY (id_clinic_history) REFERENCES clinic_history(id_clinic_history)
);

CREATE TABLE appointments (
    id_appointment NUMBER PRIMARY KEY,
    appointment_date TIMESTAMP,
    id_patient NUMBER,
    id_medic NUMBER,
    CONSTRAINT fk_patient_appointment FOREIGN KEY (id_patient) REFERENCES patients(id_patient),
    CONSTRAINT fk_medic_appointment FOREIGN KEY (id_medic) REFERENCES medics(id_medic)
);

CREATE TABLE schedule (
    id_schedule NUMBER PRIMARY KEY,
    id_medic NUMBER,
    day_of_week NUMBER,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    CONSTRAINT fk_medic_schedule FOREIGN KEY (id_medic) REFERENCES medics(id_medic)
);

CREATE TABLE audits (
    id_audit NUMBER PRIMARY KEY,
    id_clinic_history NUMBER,
    id_patient NUMBER,
    id_medic NUMBER,
    clinic_history_old TEXT,
    clinic_history_new TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_audit_history FOREIGN KEY (id_clinic_history) REFERENCES clinic_history(id_clinic_history),
    CONSTRAINT fk_audit_patient FOREIGN KEY (id_patient) REFERENCES patients(id_patient),
    CONSTRAINT fk_audit_medic FOREIGN KEY (id_medic) REFERENCES medics(id_medic)
);

CREATE TABLE audits_symptoms (
    id_audit_symptoms NUMBER PRIMARY KEY,
    id_clinic_history NUMBER,
    code_old VARCHAR2(255),
    code_new VARCHAR2(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_audit_symptoms_history FOREIGN KEY (id_clinic_history) REFERENCES clinic_history(id_clinic_history)
);

-- Triggers
CREATE OR REPLACE TRIGGER clinic_history_trigger
BEFORE UPDATE ON clinic_history
FOR EACH ROW
DECLARE
    clinic_history_old TEXT;
    clinic_history_new TEXT;
    id_clinic_history NUMBER := 0;
    id_medic NUMBER := 0;
    id_patient NUMBER := 0;
BEGIN
    clinic_history_old := :OLD.clinic_history;
    clinic_history_new := :NEW.clinic_history;
    id_medic := :OLD.id_medic;
    id_patient := :OLD.id_patient;
    id_clinic_history := :OLD.id_clinic_history;
    
    IF clinic_history_old != clinic_history_new THEN
        INSERT INTO audits (id_clinic_history, id_patient, id_medic, clinic_history_old, clinic_history_new)
        VALUES (id_clinic_history, id_patient, id_medic, clinic_history_old, clinic_history_new);
    END IF;
END clinic_history_trigger;

CREATE OR REPLACE TRIGGER clinic_history_symptoms_trigger
BEFORE UPDATE ON clinic_history_symptoms
FOR EACH ROW
DECLARE
    code_old VARCHAR2(255);
    code_new VARCHAR2(255);
    id_clinic_history NUMBER := 0;
BEGIN
    code_old := :OLD.code;
    code_new := :NEW.code;
    id_clinic_history := :OLD.id_clinic_history;

    IF code_old != code_new THEN
        INSERT INTO audits_symptoms (id_clinic_history, code_old, code_new)
        VALUES (id_clinic_history, code_old, code_new);
    END IF;
END clinic_history_symptoms_trigger;

-- Secuencias
CREATE SEQUENCE clinic_history_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE clinic_history_symptoms_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE medics_sequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE patients_sequence START WITH 1 INCREMENT BY 1;

-- Vistas
CREATE OR REPLACE VIEW clinic_history_view AS
SELECT
    CH.id_clinic_history,
    CH.clinic_history,
    CH.id_patient,
    CH.id_medic,
    CH.last_update,
    P.name AS patient_name,
    P.surname AS patient_surname,
    M.name_medic,
    M.surname_medic
FROM
    clinic_history CH
JOIN patients P ON CH.id_patient = P.id_patient
JOIN medics M ON CH.id_medic = M.id_medic;

CREATE OR REPLACE VIEW clinic_history_symptoms_view AS
SELECT
    CHS.id_clinic_history_symptoms,
    CHS.id_clinic_history,
    CHS.code,
    CH.clinic_history,
    P.name AS patient_name,
    P.surname AS patient_surname,
    M.name_medic,
    M.surname_medic
FROM
    clinic_history_symptoms CHS
JOIN clinic_history CH ON CHS.id_clinic_history = CH.id_clinic_history
JOIN patients P ON CH.id_patient = P.id_patient
JOIN medics M ON CH.id_medic = M.id_medic;

CREATE OR REPLACE VIEW patients_view AS
SELECT
    P.id_patient,
    P.dni,
    P.name,
    P.surname,
    P.gender,
    P.day_of_birth,
    P.email,
    P.phone,
    P.is_active,
    P.created_at,
    S.state_name AS status_name
FROM
    patients P
JOIN status S ON P.is_active = S.state_id;

CREATE OR REPLACE VIEW medics_view AS
SELECT
    M.id_medic,
    M.matricul_medic,
    M.name_medic,
    M.surname_medic,
    M.gender_medic,
    M.day_of_birth_medic,
    M.email_medic,
    M.phone_medic,
    M.specialty_medic,
    M.is_active,
    M.created_at,
    S.state_name AS status_name,
    S2.specialty_name AS specialty_name
FROM
    medics M
JOIN status S ON M.is_active = S.state_id
JOIN specialties S2 ON M.specialty_medic = S2.specialty_id;

