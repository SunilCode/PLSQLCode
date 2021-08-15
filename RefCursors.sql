CREATE OR REPLACE
PROCEDURE get_emp_rs (p_HIRE_DATE    IN  employees.HIRE_DATE%TYPE,
                      p_recordset OUT SYS_REFCURSOR) AS 
BEGIN 
  OPEN p_recordset FOR
    SELECT FIRST_NAME,
           EMPLOYEE_ID,
           JOB_TITLE
    FROM   employees
    WHERE  HIRE_DATE = p_HIRE_DATE
    ORDER BY FIRST_NAME;
END get_emp_rs;
/
---- REF CURSOR
SET SERVEROUTPUT ON
DECLARE
  l_cursor  SYS_REFCURSOR;
  l_FIRST_NAME   employees.FIRST_NAME%TYPE;
  l_EMPLOYEE_ID   employees.EMPLOYEE_ID%TYPE;
  l_JOB_TITLE  employees.JOB_TITLE%TYPE;
BEGIN
  get_emp_rs (p_HIRE_DATE    => '07-06-16',
              p_recordset => l_cursor);
            
  LOOP 
    FETCH l_cursor
    INTO  l_FIRST_NAME, l_EMPLOYEE_ID, l_JOB_TITLE;
    EXIT WHEN l_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(l_FIRST_NAME || ' | ' || l_EMPLOYEE_ID || ' | ' || l_JOB_TITLE);
  END LOOP;
  CLOSE l_cursor;
END;
/