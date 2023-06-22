select * from emp;
select * from DEPT;
select * from student;
select * from PROFESSOR;
select * from employees;
select * from department;
select * from department;


/*��¥ �Լ� LAST_DAY, NEXT_DAY*/
select SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '��')
FROM dual;

select SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, 1)
FROM dual;

/*��¥ �Լ� ROUND,TRUNC ��*/
select TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') NORMAL,
       TO_CHAR(TRUNC(SYSDATE), 'YY/MM/DD HH24:MI:SS') TRUNC,
       TO_CHAR(ROUND(SYSDATE), 'YY/MM/DD HH24:MI:SS') ROUND
FROM dual;
/*101�� �а� �������� �Ի����� ��, ��, ���� �������� �ݿø��Ͽ� ����Ͽ���*/
select TO_CHAR(hiredate, 'YY/MM/DD HH24:MI:SS') hiredate,
       TO_CHAR(ROUND(hiredate, 'dd'), 'YY/MM/DD') round_dd,
       TO_CHAR(ROUND(hiredate, 'mm'), 'YY/MM/DD') round_mm,
       TO_CHAR(ROUND(hiredate, 'yy'), 'YY/MM/DD') round_yy
FROM professor
WHERE deptno = 101;

/*������ Ÿ���� ��ȯ*/
/*TO_CHAR�Լ��� �̿��Ͽ� �л����̺��� ������ �л��� �й��� ������� �� ����� ���*/
SELECT studno, TO_CHAR(birthdate, 'YY-MM') birthdate
FROM student
WHERE name = '������';

/*TO_CHAR�Լ��� �̿��Ͽ� �л����̺��� 102�� �а� �л��� �̸�, �г�, ��������� ���*/
SELECT name, grade, TO_CHAR(birthdate, 'Day Month DD, YYYY') birthdate
FROM student
WHERE deptno = 102;

/*TO_CHAR�Լ��� �̿��Ͽ� �������̺��� 101�� �а� ������ �̸��� �Ի����� ��� */
SELECT name, TO_CHAR(hiredate, 'MONTH DD, YYYY HH24:MI:SS PM') HIREDATE
FROM PROFESSOR
WHERE deptno = 101;

/*TO_CHAR�Լ��� �̿��Ͽ� �������̺��� 101�� �а� �������� �̸�, ����, �Ի����� ���*/
SELECT name, position, TO_CHAR(hiredate, 'Mon "the" DDTH "of" YYYY') HIREDATE
FROM professor
WHERE deptno = 101;

/*TO_CHAR�Լ��� �̿��Ͽ� ���������� �޴� �������� �̸�, �޿�, ��������, �׸��� �޿��� ���������� ���� ���� 12�� ���� ����� �������� ���*/
SELECT name, sal, comm, TO_CHAR((sal+comm)*12, '9,999') anual_sal
FROM PROFESSOR
WHERE comm IS NOT NULL;

/*TO_NUMBER �Լ� : ���ڷ� ������ ���ڿ��� ���� �����ͷ� ��ȯ�ϱ� ���� �Լ�*/
SELECT

/*TO_DATE �Լ� : ���ڿ� ���ڷ� ������ ���ڿ��� ��¥ �����ͷ� ��ȯ�ϴ� �Լ�*/
SELECT name, hiredate
FROM PROFESSOR
WHERE hiredate = TO_DATE('6�� 01, 01', 'MONTH DD, YY');

/*������� ��ĥ°���� ���*/
SELECT TRUNC(SYSDATE - TO_DATE('19920907','YY/MM/DD')) "��ƿ� �ϼ�"
FROM dual;

/*������� ��ĥ°���� ���*/
SELECT TRUNC(SYSDATE - TO_DATE('19920907','YY/MM/DD')) "��ƿ� �ϼ�", 
       ROUND(MONTHS_BETWEEN(SYSDATE, TO_DATE('19920907','YYYY/MM/DD'))) "��ƿ� ����"
FROM dual;

/*��ø �Լ� ��*/
SELECT TO_CHAR(TO_DATE(SUBSTR(idnum,1,6), 'YYMMDD'), 'YY/MM/DD') BIRTHDATE
FROM student;

/*NVL�Լ� : NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϱ� ���� �Լ�*/
/*201�� �а� ������ �̸�, ����, �޿�, ��������, �޿��� ���������� �հ踦 ��� ��, ���������� NULL�� ��� ���������� 0���� ���*/
SELECT name, position, sal, comm, sal+comm,
        sal+NVL(comm,0) S1, NVL(sal+comm, sal) s2
FROM professor
WHERE deptno = 201;

/*NVL2 �Լ� : ù��° �μ����� NULL�� �ƴϸ� �ι�° �μ����� ����ϰ�, ù���� �μ����� NULL�̸� ����° �μ����� ���*/
/*102�� �а� �����߿��� ���������� �޴� ����� �޿��� ���������� ���� ���� �޿� �Ѿ����� ��� ��, ���������� �����ʴ� ������ �޿��� �޿��Ѿ����� ���*/
SELECT name, position, sal, comm,
        NVL2(comm, sal+comm, sal)total
FROM professor
WHERE deptno = 102;

/*NVL,NVL2 �Լ� ��� ��*/
SELECT ENAME, SAL, COMM,
        SAL+COMM, NVL2(COMM, SAL+COMM, SAL),
        SAL+NVL(COMM,0)
FROM EMP;

/*���ʽ��� ���� �ʴ� ����� ���ʽ� �ݾ��� NO�� ���*/
SELECT ENAME, 
        NVL(TO_CHAR(comm), 'NO') COMM,
        NVL2(comm, TO_CHAR(comm), 'NO') COMM2
FROM EMP;

/*NULLIF �Լ� : �ΰ��� ǥ������ ���Ͽ� ���� �����ϸ� NULL�� ��ȯ�ϰ�, ��ġ���� ������ ù��° ǥ������ ���� ��ȯ*/
/*�������̺��� �̸��� ����Ʈ ���� ����� ���̵��� ����Ʈ���� ���ؼ� ������ NULL�� ��ȯ�ϰ� ���� ������ �̸��� ����Ʈ���� ��ȯ*/
SELECT name, userid, LENGTHB(name), LENGTHB(userid),
        NULLIF(LENGTHB(SUBSTR(name,1,2)), LENGTHB(userid)) nullif_result
FROM professor;

/*COALESCE �Լ� : �μ��߿��� NULL�� �ƴ� ù���� �μ��� ��ȯ�ϴ� �Լ�*/
/*�������̺��� ���������� NULL�� �ƴϸ� ���������� ����ϰ�, 
���������� NULL�̰� �޿��� NULL�� �ƴϸ� �޿������, ��������� �޿��� NULL�̸� 0�� ���*/
SELECT name, comm, sal, COALESCE(comm,sal, 0) CO_RESULT
FROM professor;

/*DECODE �Լ�*/
/*�������̺��� ������ �Ҽ��а� ��ȣ�� �а� �̸����� ��ȯ�Ͽ� ���
�а���ȣ�� 101 = �İ�, 102 =��Ƽ�̵��, 201=���ڰ���, �������� ������*/
SELECT name, deptno,
        DECODE(deptno, 101, '��ǻ�Ͱ��а�', 102, '��Ƽ�̵���а�',
                       201, '���ڰ��а�', '�����а�') DNAME
FROM professor;

/*�л����̺��� 101�а��� �а����� CS�� �����ϰ� �׿� �а��� ETC�� ��� ��, �а���ȣ�� �����л��� ���� �� ���*/
SELECT deptno, name,
        DECODE(deptno, 101,'Computer Science', 'ETC') "�а���"
FROM student
WHERE name NOT in ('Ȳ��_��ȣ');

/*CASE�Լ�*/
/*�������̺��� �Ҽ��а��� ���� ���ʽ��� �ٸ��� ����Ͽ� ���
101�а� ���ʽ� �޿��� 10% 102�а� ���ʽ� 20% 201�а� ���ʽ� 30% �׿� 0%*/
SELECT name, deptno, sal,
        CASE WHEN DEPTNO = 101 THEN sal*0.1
             WHEN DEPTNO = 102 THEN sal*0.2
             WHEN DEPTNO = 201 THEN sal*0.3
             ELSE 0
        END bonus
FROM professor;

/*�л����̺��� ������Ͽ��� ���� �����Ͽ� �¾ �б⸦ ���*/
SELECT name, 
        TO_CHAR(birthdate, 'MM') "MONTH",
        TO_CHAR(birthdate, 'Q') "�б�"
FROM student;

SELECT name, 
        TO_CHAR(birthdate, 'MM') "MONTH",
        CASE WHEN TO_CHAR(birthdate, 'Q') = 1 THEN '1/4'
             WHEN TO_CHAR(birthdate, 'Q') = 2 THEN '2/4'
             WHEN TO_CHAR(birthdate, 'Q') = 3 THEN '3/4'
        ELSE '4/4'
        END "�б�"
FROM student;

/*Group�Լ�*/
/*COUNT�Լ� : */
/*101�� �а� �����߿��� ���������� �޴� ������ ���� ���*/
SELECT COUNT(comm)
FROM professor
WHERE deptno = 101;

SELECT COUNT(comm)
FROM professor
WHERE deptno = 101 AND comm IS NOT NULL;

/*������̺��� JOB�� ���� COUND�Լ��� ����� ���*/
SELECT COUNT(JOB)
FROM emp;
/*������̺��� �ߺ��� JOB�� ���� �� COUND�Լ��� ����� ��� */
SELECT COUNT(DISTINCT(JOB))
FROM emp;

/*AVG,SUM �Լ�*/
/*101�� �а� �л����� ������ ��հ� �հ� ���*/
SELECT AVG(weight), SUM(weight)
FROM student
WHERE deptno = 101;

/*MIN,MAX �Լ�*/
/*��� ����� �ִ�޿�, �����޿� �հ� �׸��� ���*/
SELECT ROUND(MAX(sal),0) "Maximum",
       ROUND(MIN(sal),0) "Minimum",
       ROUND(SUM(sal),0) "Sum",
       ROUND(AVG(sal),0) "Average"
FROM emp;

/*STDDEV, VARIANCE ǥ������, �л�*/
SELECT  ROUND(STDDEV(sal), 6), ROUND(VARIANCE(sal), 4)
FROM    professor;

/*GROUP BY : Ư��Į������ �������� ���̺��� ��ü ���� �׷캰�� ������ ���� ��*/
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno;
/*�а����� �Ҽӱ������� ���,�ּ�,�ִ� �޿��� ���*/
SELECT deptno, AVG(sal), MIN(sal), MAX(sal)
FROM PROFESSOR
GROUP BY deptno;
/*��ü�л��� �Ҽ��а����� ������, ���� �а� �л��� �ٽ� �г⺰�� �׷����Ͽ�,
�а��� �г⺰ �ο���, ��ո����Ը� ��� ��, �����Դ� �Ҽ��� ���� ù��°�ڸ����� �ݿø�*/
SELECT deptno, grade, COUNT(*), ROUND(AVG(weight))
FROM student
GROUP BY deptno, grade;

/*ROLLUP : GROUP BY���� �׷����ǿ� ���� ��ü���� �׷�ȭ�ϰ� �� �׷쿡 ���� �κ����� ����
   CUBE : ROLLUP�� ���� �׷����� GROUP BY���� ����� ���ǿ� ���� �׷������� ����� ������*/
/*�Ҽ��а����� �����޿� �հ�� ��� �а� �������� �޿��հ踦 ���*/
SELECT deptno, SUM(sal)
FROM professor
GROUP BY ROLLUP(deptno);
/*ROLLUP�����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü���� ���� ����϶�*/
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY ROLLUP(deptno, position);
/*CUBE �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü���� ���� ����϶�*/
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY CUBE(deptno, position);

/*GROUPING : �μ��� ������ Į���� ROLLUP�̳� CUBE �����ڷ� ������ �׷�
            ���տ��� ���Ǿ����� ���θ� 1 �Ǵ� 0���� ��ȯ */
/*��ü �л��� �а��� �г⺰�� �׷�ȭ�� ��, �а��� �г⺰ �׷��ο���, �а����ο���,
  �� �׷� ���տ��� �а��� �г� Į���� ���Ǿ����� ���θ� ���*/
SELECT deptno, grade, COUNT(*),
        GROUPING(deptno) grp_dno,
        GROUPING(grade) grp_grade
FROM student
GROUP BY ROLLUP(deptno, grade);
/*GROUpING SETS �Լ� : GROUP BY ������ �׷������� ������ ������ �� �ִ� �Լ�*/
SELECT DEPTNO, GRADE, NULL, CoUNT(*)
FROM student
group by deptno, grade
union all
select deptno, null, TO_CHAR(birthdate, 'YYYY'), count(*)
from student
group by deptno, TO_CHAR(birthdate, 'YYYY');

/*HAVING : GROUP BY ���� ���� ������ �׷��� ������� ������ ����*/
/*�л� ���� 4���̻��� �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
  ��, ���Ű�� ��ո����Դ� �Ҽ��� ù��° �ڸ����� �ݿø��ϰ�, ��¼����� ���Ű�� ���� �� ����*/
SELECT grade, COUNT(*), ROUND(AVG(height)) "��� Ű",
       ROUND(AVG(weight)) "��� ������"
FROM student
GROUP BY grade
HAVING COUNT(*) > 4
ORDER BY "��� Ű" DESC;

/*WHERE���� HAVING���� �������� ��*/
SELECT deptno, AVG(sal)
FROM professor
GROUP BY deptno
HAVING deptno > 102;

SELECT deptno, AVG(sal)
FROM professor
WHERE deptno > 102
GROUP BY deptno;

/*�Լ��� ��ø*/
SELECT deptno, AVG(weight)
FROM student
GROUP BY deptno;

/*������̺��� �޿��� 1500�̻� �޴� ����� �߿��� ��ձ޿��� 2000�̻��� �μ���ȣ�� ���*/
SELECT deptno, ROUND(AVG(sal))
FROM emp
WHERE sal >= 1500
GROUP BY deptno
HAVING AVG(sal) >= 2000
ORDER BY deptno;

/*�а��� �л� ���� �ִ� �Ǵ� �ּ��� �а��� �л� ���� ���*/
SELECT MAX(COUNT(studno)) max_cnt, MIN(COUNT(studno)) min_cnt
FROM student
GROUP BY deptno;


/*JOIN*/
SELECT student.studno, student.name, student.deptno, department.dname, department.loc
FROM student, department
WHERE student.deptno = department.deptno

/*���̺� ����*/
SELECT s.studno, s.name, s.deptno, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno and s.name = '������';

/*����*/
/*1. ��� ���̺��� DALLAS���� �ٹ��ϴ� ����� ��� �̸� �μ���ȣ �μ��̸� �μ���ġ�� ���*/
SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, DEPT d
WHERE e.deptno = d.deptno
and d.loc = 'DALLAS';
/*2. �޿��� 400�̻��� ���� �̸� �޿� �а���ȣ �а��̸��� ����ϼ���*/
SELECT p.name "���� �̸�", p.sal �޿�, p.deptno "�а� ��ȣ", d.dname "�а� �̸�"
FROM professor p, department d
WHERE p.deptno = d.deptno
and p.sal >= 400;
/*3. �й� �̸� �а���ȣ �а��̸� �а���ġ �������� �̸� �޿��� ����ϼ��� ��, �İ��� �л��鸸*/
SELECT s.studno, s.name, s.deptno, d.dname, d.loc, p.name, p.sal
FROM student s, department d, professor p
WHERE s.deptno = d.deptno
and   s.profno = p.profno
and   d.dname = '��ǻ�Ͱ��а�';
/*�����԰� 80kg �̻��� �л��� �й� �̸� ü�� �а� �̸� �а���ġ ���*/
SELECT s.studno, s.name, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.weight >= 80;

/*������ īƼ�� ��*/
SELECT studno, name, s.deptno, d.deptno, dname
FROM student s, DEPARTMENT d

/*CROSS JOIN ����*/
SELECT name, student.deptno, dname, loc
FROM student, department;

SELECT name, student.deptno, dname, loc
FROM student CROSS JOIN department;

/*EQUI JOIN*/
SELECT s.studno, s.name, s.deptno, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno;



/*����Ǯ��*/
/* 1.  ���ʽ��� ������ �̸��� ���ʽ��� ����ϰ�, ���� ������ �̸��� 200 ����� ������.(emp)*/
SELECT ENAME, 
        NVL(TO_CHAR(comm), '200') "���ʽ�"
FROM emp;

/* 2. �� �޿��� $5,000�� �Ѵ� �� JOB�� ���� JOB�� ���� �Ѿ��� ����ϼ���. (��, PRESIDENT�� ���ܽ�Ű��, ���� �Ѿ׺����� ����)
JOB                   PAYROLL
------------------ ----------
SALESMAN               5600
ANALYST                  6000
MANAGER                 8275*/
SELECT job, SUM(sal) PAYROLL
FROM emp
WHERE JOB <> 'PRESIDENT'
GROUP BY job
HAVING SUM(SAL) >= 5000
ORDER BY SUM(SAL);

/* 3.CHICAGO�� �ٹ��ϴ� ��� �������� ���ؼ� �̸�, ����, �μ� ��ȣ �׸��� �μ� �̸��� ����ϴ� ���Ǹ� �ۼ��ϼ���.(emp, dept)*/
SELECT e.ename �̸�, e.job ����, d.deptno "�μ� ��ȣ", d.dname "�μ� �̸�"
FROM emp e, DEPT d
WHERE e.deptno = d.deptno
and d.loc = 'CHICAGO';

/* 4. �����, �Ի��� �׸��� �Ի��� ������ ����ϼ���. �� ���̺��� DAY �Դϴ�.(***����� �����Ϻ��� �����ϴ� ���� ������ �����ϼ���.)
ENAME                HIREDATE DAY
-------------------- -------- ------------------------
SMITH                80/12/17 ������
ALLEN                81/02/20 �ݿ���
WARD                81/02/22 �Ͽ��� */
SELECT ENAME, HIREDATE, TO_CHAR(hiredate, 'DAY') DAY
FROM emp
ORDER BY TO_CHAR(hiredate-1, 'D');

/* 5. 1980, 1981, 1982, 1987�⿡ �Ի��� �������� ���ؼ� ��ü ��� ���� ������ ��� ���� ����ϼ���.
������ �����̺��� �ο��ϼ���. (emp)
      TOTAL   1980       1981       1982    1987
---------- ---------- ---------- ----------   ----------
        14         1             10          1         2 */
SELECT COUNT(substr(HIREDATE, 1,2)) total,
       COUNT(decode(substr(HIREDATE, 1,2), 80, sal)) "1980",
       COUNT(decode(substr(HIREDATE, 1,2), 81, sal)) "1981",
       COUNT(decode(substr(HIREDATE, 1,2), 82, sal)) "1982",
       COUNT(decode(substr(HIREDATE, 1,2), 87, sal)) "1987"      
FROM emp;

