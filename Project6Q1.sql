SPOOL C:\BD2\Project6Q1.txt
SELECT to_char(sysdate, 'DD Month YYYY HH:MI:SS') FROM dual;

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE p6question1 AS

    CURSOR fac IS
        SELECT f_id, f_last, f_first, f_rank FROM faculty;
        v_f_id faculty.f_id%TYPE;
        v_f_last faculty.f_last%TYPE;
        v_f_first faculty.f_first%TYPE;
        v_f_rank faculty.f_rank%TYPE;
        
        CURSOR std (pc_f_id faculty.f_id%TYPE) IS 
            SELECT s_id, s_last, s_first, s_dob, s_class FROM student
            WHERE f_id = pc_f_id;
            v_s_id student.s_id%TYPE;
            v_s_last student.s_last%TYPE;
            v_s_first student.s_first%TYPE;
            v_s_dob student.s_dob%TYPE;
            v_s_class student.s_class%TYPE;            
BEGIN
        OPEN fac;
        FETCH fac INTO v_f_id, v_f_last, v_f_first, v_f_rank;
        WHILE fac%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE('Faculty Member: ' || v_f_id || ' is ' || v_f_first || ' ' || v_f_last || ', ' || v_f_rank);
            
            OPEN std (v_f_id);
            FETCH std INTO v_s_id, v_s_last, v_s_first, v_s_dob, v_s_class;
            WHILE std%FOUND LOOP
                DBMS_OUTPUT.PUT_LINE('    Student Advised: ' || v_s_first || ' ' || v_s_last || ' (ID ' || v_s_id || ', ' || v_s_dob || ', ' || v_s_class || ')');
            FETCH std INTO v_s_id, v_s_last, v_s_first, v_s_dob, v_s_class;
            END LOOP;
            CLOSE std;
        FETCH fac INTO v_f_id, v_f_last, v_f_first, v_f_rank;
        END LOOP;
        CLOSE fac;
END;
/

EXEC p6question1;

Spool off;