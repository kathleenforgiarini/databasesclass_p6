SPOOL C:\BD2\Project6Q5.txt
SELECT to_char(sysdate, 'DD Month YYYY HH:MI:SS') FROM dual;

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE p6question5(p_c_id IN consultant.c_id%TYPE, p_cert IN consultant_skill.certification%TYPE) AS

CURSOR cons_curr IS
SELECT c_id, c_last, c_first, c_city
FROM consultant
WHERE c_id = p_c_id;
v_c_id consultant.c_id%TYPE;
v_c_last consultant.c_last%TYPE;
v_c_first consultant.c_first%TYPE;
v_c_city consultant.c_city%TYPE;

CURSOR skill_curr (pc_id consultant.c_id%TYPE) IS 
SELECT skill_id, certification
FROM consultant_skill
WHERE c_id = pc_id;
v_skill_id consultant_skill.skill_id%TYPE;
v_cert consultant_skill.certification%TYPE;
v_new_cert consultant_skill.certification%TYPE;
BEGIN
IF upper(p_cert)='Y' OR upper(p_cert)='N' THEN
OPEN cons_curr;
FETCH cons_curr INTO v_c_id, v_c_last, v_c_first, v_c_city;
WHILE cons_curr%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('Consultant id: '||v_c_id ||', Name: ' ||v_c_first||' '||v_c_last||', City: ' ||v_c_city|| '.');
DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------');
OPEN skill_curr(v_c_id);
FETCH skill_curr INTO v_skill_id, v_cert;
WHILE skill_curr%FOUND LOOP
v_new_cert := p_cert;
UPDATE consultant_skill SET certification = v_new_cert;
DBMS_OUTPUT.PUT_LINE('Certification ID: '||v_skill_id||', Before: '||v_cert||', After: '||v_new_cert||'.');
FETCH skill_curr INTO v_skill_id, v_cert;
END LOOP;
CLOSE skill_curr;
FETCH cons_curr INTO v_c_id, v_c_last, v_c_first, v_c_city;
END LOOP;
CLOSE cons_curr;
ELSE
DBMS_OUTPUT.PUT_LINE('Enter with a valid option, Y or N');
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Consultant ID '||v_c_id|| ' does not exist!');
END;
/
exec p6question5(101,'Y');

Spool off;