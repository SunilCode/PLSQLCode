--- Object specification 
CREATE OR REPLACE TYPE t_person AS OBJECT (
  first_name     VARCHAR2(30),
  last_name      VARCHAR2(30),
  date_of_birth  DATE,
  MEMBER FUNCTION get_age RETURN NUMBER
);
/
--- Object body 
CREATE OR REPLACE TYPE BODY t_person AS
  MEMBER FUNCTION get_age RETURN NUMBER AS
  BEGIN
    RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12);
  END get_age;
END;
/
---- Use of Object 
CREATE TABLE people (
  id      NUMBER(10) NOT NULL,
  person  t_person
);

---To insert data into the PEOPLE table we must use the t_person() constructor. This can be done as part of a regular DML statement, or using PL/SQL.
INSERT INTO people (id, person)
VALUES (1, t_person('John', 'Doe', TO_DATE('01/01/2000','DD/MM/YYYY')));

DECLARE
  l_person  t_person;
BEGIN
  l_person := t_person('Jane','Doe', TO_DATE('01/01/2001','DD/MM/YYYY'));
  INSERT INTO people (id, person)
  VALUES (2, l_person);
  COMMIT;
END;
/
--- Access Objects parameters
SELECT p.id,
       p.person.first_name,
       p.person.get_age() AS age
FROM   people p;