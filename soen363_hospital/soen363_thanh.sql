-- Q5: Find all ICU or CCU unit stays that lasted more than seven days. Display the
-- patient name, unit type, unit entry time, unit exit time, and calculated length of stay.

SELECT p.full_name,
    u.unit_type,
    u.entry_date_and_time,
    u.exit_date_and_time,
    (u.exit_date_and_time - u.entry_date_and_time) as length_of_stay
FROM Unit_Stay u
Join Admission a
    ON u.admission_identifier = a.admission_identifier
Join Patient p
    ON a.patient_identifier = p.patient_identifier
WHERE u.unit_type IN ('ICU', 'CCU')
  AND (u.exit_date_and_time - u.entry_date_and_time) > interval '7 days';