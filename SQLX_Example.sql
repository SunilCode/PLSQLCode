SELECT SYS_XMLAGG (
         SYS_XMLGEN(
           dept_row(
             d.deptno, d.dname, d.loc,
             CAST(MULTISET(SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm
                           FROM   emp e
                           WHERE  e.deptno = d.deptno) AS emp_tab)
           ),
           SYS.XMLGENFORMATtYPE.createFormat('DEPT')
         )
       ) AS "XML_QUERY"
FROM   dept d
WHERE  d.deptno = 10;