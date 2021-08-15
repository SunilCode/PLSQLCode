SELECT empno, deptno, sal, 
       FIRST_VALUE(sal IGNORE NULLS) OVER (PARTITION BY deptno) AS first_sal_in_dept
FROM   emp;