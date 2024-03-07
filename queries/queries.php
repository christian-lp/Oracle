define('SELECT_PATIENTS', 'SELECT * FROM patients');
define('SELECT_SCHEDULE', "SELECT * FROM schedule WHERE scheduledate = :today");
define('SELECT_APPOINTMENTS', "SELECT * FROM appointment WHERE appodate >= :today");
define('SELECT_MEDICS', 'SELECT * FROM medics');
define('SELECT_MEDICS_ORDER', 'SELECT * FROM medics ORDER BY id_medic DESC');
define('SELECT_ADMINS', 'SELECT * FROM admins WHERE email = :useremail');
define('UPDATE_MEDIC_STATUS', 'UPDATE medics SET is_active = 0 WHERE id_medic = :id');
define('UPDATE_MEDIC_DATE', "UPDATE medics SET email_medic = :email, name_medic = :name, password_medic = :password, matricul_medic = :matri, phone_medic = :tele, specialty_id = :spec, availability = :avail WHERE id_medic = :id");
define('INSERT_SPECIALTY', 'INSERT INTO specialties (specialty_name) VALUES (:newSpe)');
define('SELECT_SEARCH_MEDIC', "SELECT * FROM medics WHERE email_medic = :keyword OR name_medic = :keyword OR email_medic LIKE :keyword OR email_medic LIKE :keyword OR email_medic LIKE :keyword");
define('INSERT_MEDIC', 'INSERT INTO medics(matricul_medic, name_medic, surname_medic, gender_medic, day_of_birth_medic, email_medic, phone_medic, specialty_id, password_medic, availability) VALUES (:matri, :name, :surname, :gen, :birth, :email, :tele, :spec, :hashedPassword, :avail)');
define('INSERT_SCHEDULE', 'INSERT INTO schedule (title, id_medic, scheduledate, scheduletime, nop) VALUES (:title, :docid, TO_DATE(:fecha, \'YYYY-MM-DD\'), TO_TIMESTAMP(:hora, \'HH24:MI\'), :nop)');
define('UPDATE_SCHEDULE', 'UPDATE schedule SET nop = nop + 1 WHERE scheduleid = :id2');
define('DELETE_APPOINTMENT', 'DELETE FROM appointment WHERE appointment_id = :id');

define('SELECT_APPOINTMENT_MEDIC',
    'SELECT
        appointment.appointment_id,
        schedule.scheduleid,
        schedule.title,
        medics.name_medic,
        patients.name,
        schedule.scheduledate,
        schedule.scheduletime,
        appointment.apponum,
        appointment.appodate
    FROM schedule
    INNER JOIN appointment ON schedule.scheduleid = appointment.schedule_id
    INNER JOIN patients ON patients.id_patient = appointment.patient_id
    INNER JOIN medics ON schedule.id_medic = medics.id_medic
    WHERE medics.id_medic = :userid');

define('SELECT_APPOINTMENT_ORDER',
    'SELECT
        appointment.appointment_id,
        schedule.scheduleid,
        schedule.title,
        medics.name_medic,
        patients.name,
        schedule.scheduledate,
        schedule.scheduletime,
        appointment.apponum,
        appointment.appodate
    FROM
        schedule
    INNER JOIN
        appointment ON schedule.scheduleid = appointment.schedule_id
    INNER JOIN
        patients ON patients.id_patient = appointment.patient_id
    INNER JOIN
        medics ON schedule.id_medic = medics.id_medic
    ORDER BY
        scheduledate DESC');
