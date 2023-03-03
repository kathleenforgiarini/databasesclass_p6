SPOOL C:\BD2\Project6Q2.txt
SELECT to_char(sysdate, 'DD Month YYYY HH:MI:SS') FROM dual;

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE p6question2 AS
-- STEP 1
CURSOR cons_curr IS
SELECT c_id, c_last, c_first
FROM consultant;

v_c_id consultant.c_id%TYPE;
v_c_last consultant.c_last%TYPE;
v_c_first consultant.c_first%TYPE;


CURSOR skill_curr (pc_c_id consultant.c_id%TYPE) IS
SELECT s.skill_id, s.skill_description, cs.certification
FROM skill s, consultant_skill cs
WHERE s.skill_id =cs.skill_id AND c_id = pc_c_id;

v_skill_id skill.skill_id%TYPE;
v_skill_description skill.skill_description%TYPE;
v_certification consultant_skill.certification%TYPE;

BEGIN
OPEN cons_curr;
FETCH cons_curr INTO v_c_id, v_c_last, v_c_first;
WHILE cons_curr%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('Consultant ID '|| v_c_id ||
' is ' || v_c_first||' '||v_c_last);
OPEN skill_curr(v_c_id);
FETCH skill_curr INTO v_skill_id, v_skill_description, v_certification;
WHILE skill_curr%FOUND LOOP 
DBMS_OUTPUT.PUT_LINE('    Skill ' || v_skill_id || ' is ' || v_skill_description || ' Certification: ' || v_certification);
FETCH skill_curr INTO v_skill_id, v_skill_description, v_certification;
END LOOP;
CLOSE skill_curr;
FETCH cons_curr INTO v_c_id, v_c_last, v_c_first;
END LOOP;
CLOSE cons_curr;
END;
/

exec p6question2;

Spool off;