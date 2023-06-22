select * from emp;
select * from DEPT;
select * from student;
select * from PROFESSOR;
select * from employees;
select * from department;
select * from department;


/*날짜 함수 LAST_DAY, NEXT_DAY*/
select SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '일')
FROM dual;

select SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, 1)
FROM dual;

/*날짜 함수 ROUND,TRUNC 예*/
select TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') NORMAL,
       TO_CHAR(TRUNC(SYSDATE), 'YY/MM/DD HH24:MI:SS') TRUNC,
       TO_CHAR(ROUND(SYSDATE), 'YY/MM/DD HH24:MI:SS') ROUND
FROM dual;
/*101번 학과 교수들의 입사일을 일, 월, 년을 기준으로 반올림하여 출력하여라*/
select TO_CHAR(hiredate, 'YY/MM/DD HH24:MI:SS') hiredate,
       TO_CHAR(ROUND(hiredate, 'dd'), 'YY/MM/DD') round_dd,
       TO_CHAR(ROUND(hiredate, 'mm'), 'YY/MM/DD') round_mm,
       TO_CHAR(ROUND(hiredate, 'yy'), 'YY/MM/DD') round_yy
FROM professor
WHERE deptno = 101;

/*데이터 타입의 변환*/
/*TO_CHAR함수를 이용하여 학생테이블에서 전인하 학생의 학번과 생년월일 중 년월만 출력*/
SELECT studno, TO_CHAR(birthdate, 'YY-MM') birthdate
FROM student
WHERE name = '전인하';

/*TO_CHAR함수를 이용하여 학생테이블에서 102번 학과 학생의 이름, 학년, 생년월일을 출력*/
SELECT name, grade, TO_CHAR(birthdate, 'Day Month DD, YYYY') birthdate
FROM student
WHERE deptno = 102;

/*TO_CHAR함수를 이용하여 교수테이블에서 101번 학과 교수의 이름과 입사일을 출력 */
SELECT name, TO_CHAR(hiredate, 'MONTH DD, YYYY HH24:MI:SS PM') HIREDATE
FROM PROFESSOR
WHERE deptno = 101;

/*TO_CHAR함수를 이용하여 교수테이블에서 101번 학과 교수들의 이름, 직급, 입사일을 출력*/
SELECT name, position, TO_CHAR(hiredate, 'Mon "the" DDTH "of" YYYY') HIREDATE
FROM professor
WHERE deptno = 101;

/*TO_CHAR함수를 이용하여 보직수당을 받는 교수들의 이름, 급여, 보직수당, 그리고 급여와 보직수당을 더한 값에 12를 곱한 결과를 연봉으로 출력*/
SELECT name, sal, comm, TO_CHAR((sal+comm)*12, '9,999') anual_sal
FROM PROFESSOR
WHERE comm IS NOT NULL;

/*TO_NUMBER 함수 : 숫자로 구성된 문자열을 숫자 데이터로 변환하기 위한 함수*/
SELECT

/*TO_DATE 함수 : 숫자와 문자로 구성된 문자열을 날짜 데이터로 변환하는 함수*/
SELECT name, hiredate
FROM PROFESSOR
WHERE hiredate = TO_DATE('6월 01, 01', 'MONTH DD, YY');

/*출생한지 며칠째인지 출력*/
SELECT TRUNC(SYSDATE - TO_DATE('19920907','YY/MM/DD')) "살아온 일수"
FROM dual;

/*출생한지 며칠째인지 출력*/
SELECT TRUNC(SYSDATE - TO_DATE('19920907','YY/MM/DD')) "살아온 일수", 
       ROUND(MONTHS_BETWEEN(SYSDATE, TO_DATE('19920907','YYYY/MM/DD'))) "살아온 개월"
FROM dual;

/*중첩 함수 예*/
SELECT TO_CHAR(TO_DATE(SUBSTR(idnum,1,6), 'YYMMDD'), 'YY/MM/DD') BIRTHDATE
FROM student;

/*NVL함수 : NULL을 0 또는 다른 값으로 변환하기 위한 함수*/
/*201번 학과 교수의 이름, 직급, 급여, 보직수당, 급여와 보직수당의 합계를 출력 단, 보직수당이 NULL인 경우 보직수당을 0으로 계산*/
SELECT name, position, sal, comm, sal+comm,
        sal+NVL(comm,0) S1, NVL(sal+comm, sal) s2
FROM professor
WHERE deptno = 201;

/*NVL2 함수 : 첫번째 인수값이 NULL이 아니면 두번째 인수값을 출력하고, 첫번쨰 인수값이 NULL이면 세번째 인수값을 출력*/
/*102번 학과 교수중에서 보직수당을 받는 사람은 급여와 보직수당을 더한 값을 급여 총액으로 출력 단, 보직수당을 받지않는 교수는 급여만 급여총액으로 출력*/
SELECT name, position, sal, comm,
        NVL2(comm, sal+comm, sal)total
FROM professor
WHERE deptno = 102;

/*NVL,NVL2 함수 사용 예*/
SELECT ENAME, SAL, COMM,
        SAL+COMM, NVL2(COMM, SAL+COMM, SAL),
        SAL+NVL(COMM,0)
FROM EMP;

/*보너스를 받지 않는 사원의 보너스 금액을 NO로 출력*/
SELECT ENAME, 
        NVL(TO_CHAR(comm), 'NO') COMM,
        NVL2(comm, TO_CHAR(comm), 'NO') COMM2
FROM EMP;

/*NULLIF 함수 : 두개의 표현식을 비교하여 값이 동일하면 NULL을 반환하고, 일치하지 않으면 첫번째 표현식의 값을 반환*/
/*교수테이블에서 이름의 바이트 수와 사용자 아이디의 바이트수를 비교해서 같으면 NULL을 반환하고 같지 않으면 이름의 바이트수를 반환*/
SELECT name, userid, LENGTHB(name), LENGTHB(userid),
        NULLIF(LENGTHB(SUBSTR(name,1,2)), LENGTHB(userid)) nullif_result
FROM professor;

/*COALESCE 함수 : 인수중에서 NULL이 아닌 첫번쨰 인수를 반환하는 함수*/
/*교수테이블에서 보직수당이 NULL이 아니면 보직수당을 출력하고, 
보직수당이 NULL이고 급여가 NULL이 아니면 급여를출력, 보직수당과 급여가 NULL이면 0을 출력*/
SELECT name, comm, sal, COALESCE(comm,sal, 0) CO_RESULT
FROM professor;

/*DECODE 함수*/
/*교수테이블에서 교수의 소속학과 번호를 학과 이름으로 변환하여 출력
학과번호가 101 = 컴공, 102 =멀티미디어, 201=전자공학, 나머지는 기계공학*/
SELECT name, deptno,
        DECODE(deptno, 101, '컴퓨터공학과', 102, '멀티미디어학과',
                       201, '전자공학과', '기계공학과') DNAME
FROM professor;

/*학생테이블에서 101학과의 학과명을 CS로 변경하고 그외 학과는 ETC로 출력 단, 학과번호가 없는학생은 제외 후 출력*/
SELECT deptno, name,
        DECODE(deptno, 101,'Computer Science', 'ETC') "학과명"
FROM student
WHERE name NOT in ('황보_정호');

/*CASE함수*/
/*교수테이블에서 소속학과에 따라 보너스를 다르게 계산하여 출력
101학과 보너스 급여의 10% 102학과 보너스 20% 201학과 보너스 30% 그외 0%*/
SELECT name, deptno, sal,
        CASE WHEN DEPTNO = 101 THEN sal*0.1
             WHEN DEPTNO = 102 THEN sal*0.2
             WHEN DEPTNO = 201 THEN sal*0.3
             ELSE 0
        END bonus
FROM professor;

/*학생테이블에서 생년월일에서 월을 추출하여 태어난 분기를 출력*/
SELECT name, 
        TO_CHAR(birthdate, 'MM') "MONTH",
        TO_CHAR(birthdate, 'Q') "분기"
FROM student;

SELECT name, 
        TO_CHAR(birthdate, 'MM') "MONTH",
        CASE WHEN TO_CHAR(birthdate, 'Q') = 1 THEN '1/4'
             WHEN TO_CHAR(birthdate, 'Q') = 2 THEN '2/4'
             WHEN TO_CHAR(birthdate, 'Q') = 3 THEN '3/4'
        ELSE '4/4'
        END "분기"
FROM student;

/*Group함수*/
/*COUNT함수 : */
/*101번 학과 교수중에서 보직수당을 받는 교수의 수를 출력*/
SELECT COUNT(comm)
FROM professor
WHERE deptno = 101;

SELECT COUNT(comm)
FROM professor
WHERE deptno = 101 AND comm IS NOT NULL;

/*사원테이블에서 JOB의 수를 COUND함수를 사용해 출력*/
SELECT COUNT(JOB)
FROM emp;
/*사원테이블에서 중복된 JOB을 제외 후 COUND함수를 사용해 출력 */
SELECT COUNT(DISTINCT(JOB))
FROM emp;

/*AVG,SUM 함수*/
/*101번 학과 학생들의 몸무게 평균과 합계 출력*/
SELECT AVG(weight), SUM(weight)
FROM student
WHERE deptno = 101;

/*MIN,MAX 함수*/
/*모든 사원의 최대급여, 최저급여 합계 그리고 평균*/
SELECT ROUND(MAX(sal),0) "Maximum",
       ROUND(MIN(sal),0) "Minimum",
       ROUND(SUM(sal),0) "Sum",
       ROUND(AVG(sal),0) "Average"
FROM emp;

/*STDDEV, VARIANCE 표준편차, 분산*/
SELECT  ROUND(STDDEV(sal), 6), ROUND(VARIANCE(sal), 4)
FROM    professor;

/*GROUP BY : 특정칼럼값을 기준으로 테이블의 전체 행을 그룹별로 나누기 위한 절*/
SELECT deptno, COUNT(*), COUNT(comm)
FROM professor
GROUP BY deptno;
/*학과별로 소속교수들의 평균,최소,최대 급여를 출력*/
SELECT deptno, AVG(sal), MIN(sal), MAX(sal)
FROM PROFESSOR
GROUP BY deptno;
/*전체학생을 소속학과별로 나누고, 같은 학과 학생은 다시 학년별로 그룹핑하여,
학과와 학년별 인원수, 평균몸무게를 출력 단, 몸무게는 소수점 이하 첫번째자리에서 반올림*/
SELECT deptno, grade, COUNT(*), ROUND(AVG(weight))
FROM student
GROUP BY deptno, grade;

/*ROLLUP : GROUP BY절의 그룹조건에 따라 전체행을 그룹화하고 각 그룹에 대해 부분합을 구함
   CUBE : ROLLUP에 의한 그룹결과와 GROUP BY절에 기술된 조건에 따라 그룹조합을 만드는 연산자*/
/*소속학과별로 교수급여 합계와 모든 학과 교수들의 급여합계를 출력*/
SELECT deptno, SUM(sal)
FROM professor
GROUP BY ROLLUP(deptno);
/*ROLLUP연산자를 이용하여 학과 및 직급별 교수 수, 학가별 교수 수, 전체교수 수를 출력하라*/
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY ROLLUP(deptno, position);
/*CUBE 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체교수 수를 출력하라*/
SELECT deptno, position, COUNT(*)
FROM professor
GROUP BY CUBE(deptno, position);

/*GROUPING : 인수로 지정된 칼럼이 ROLLUP이나 CUBE 연산자로 생성된 그룹
            조합에서 사용되었는지 여부를 1 또는 0으로 반환 */
/*전체 학생을 학과와 학년별로 그룹화한 후, 학과와 학년별 그룹인원수, 학과별인원수,
  각 그룹 조합에서 학과와 학년 칼럼이 사용되었는지 여부를 출력*/
SELECT deptno, grade, COUNT(*),
        GROUPING(deptno) grp_dno,
        GROUPING(grade) grp_grade
FROM student
GROUP BY ROLLUP(deptno, grade);
/*GROUpING SETS 함수 : GROUP BY 절에서 그룹조건을 여러개 지정할 수 있는 함수*/
SELECT DEPTNO, GRADE, NULL, CoUNT(*)
FROM student
group by deptno, grade
union all
select deptno, null, TO_CHAR(birthdate, 'YYYY'), count(*)
from student
group by deptno, TO_CHAR(birthdate, 'YYYY');

/*HAVING : GROUP BY 절에 의해 생성된 그룹을 대상으로 조건을 적용*/
/*학생 수가 4명이상인 학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
  단, 평균키와 평균몸무게는 소수점 첫번째 자리에서 반올림하고, 출력순서는 평균키가 높은 순 부터*/
SELECT grade, COUNT(*), ROUND(AVG(height)) "평균 키",
       ROUND(AVG(weight)) "평균 몸무게"
FROM student
GROUP BY grade
HAVING COUNT(*) > 4
ORDER BY "평균 키" DESC;

/*WHERE절과 HAVING절의 성능차이 비교*/
SELECT deptno, AVG(sal)
FROM professor
GROUP BY deptno
HAVING deptno > 102;

SELECT deptno, AVG(sal)
FROM professor
WHERE deptno > 102
GROUP BY deptno;

/*함수의 중첩*/
SELECT deptno, AVG(weight)
FROM student
GROUP BY deptno;

/*사원테이블에서 급여를 1500이상 받는 사원들 중에서 평균급여가 2000이상인 부서번호를 출력*/
SELECT deptno, ROUND(AVG(sal))
FROM emp
WHERE sal >= 1500
GROUP BY deptno
HAVING AVG(sal) >= 2000
ORDER BY deptno;

/*학과별 학생 수가 최대 또는 최소인 학과의 학생 수를 출력*/
SELECT MAX(COUNT(studno)) max_cnt, MIN(COUNT(studno)) min_cnt
FROM student
GROUP BY deptno;


/*JOIN*/
SELECT student.studno, student.name, student.deptno, department.dname, department.loc
FROM student, department
WHERE student.deptno = department.deptno

/*테이블 별명*/
SELECT s.studno, s.name, s.deptno, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno and s.name = '전인하';

/*문제*/
/*1. 사원 테이블에서 DALLAS에서 근무하는 사원의 사번 이름 부서번호 부서이름 부서위치를 출력*/
SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, DEPT d
WHERE e.deptno = d.deptno
and d.loc = 'DALLAS';
/*2. 급여가 400이상인 교수 이름 급여 학과번호 학과이름을 출력하세요*/
SELECT p.name "교수 이름", p.sal 급여, p.deptno "학과 번호", d.dname "학과 이름"
FROM professor p, department d
WHERE p.deptno = d.deptno
and p.sal >= 400;
/*3. 학번 이름 학과번호 학과이름 학과위치 지도교수 이름 급여를 출력하세요 단, 컴공과 학생들만*/
SELECT s.studno, s.name, s.deptno, d.dname, d.loc, p.name, p.sal
FROM student s, department d, professor p
WHERE s.deptno = d.deptno
and   s.profno = p.profno
and   d.dname = '컴퓨터공학과';
/*몸무게가 80kg 이상인 학생의 학번 이름 체중 학과 이름 학과위치 출력*/
SELECT s.studno, s.name, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno
AND s.weight >= 80;

/*조인의 카티션 곱*/
SELECT studno, name, s.deptno, d.deptno, dname
FROM student s, DEPARTMENT d

/*CROSS JOIN 사용법*/
SELECT name, student.deptno, dname, loc
FROM student, department;

SELECT name, student.deptno, dname, loc
FROM student CROSS JOIN department;

/*EQUI JOIN*/
SELECT s.studno, s.name, s.deptno, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno;



/*문제풀이*/
/* 1.  보너스를 받으면 이름과 보너스를 출력하고, 받지 않으면 이름과 200 출력해 보세요.(emp)*/
SELECT ENAME, 
        NVL(TO_CHAR(comm), '200') "보너스"
FROM emp;

/* 2. 총 급여가 $5,000이 넘는 각 JOB에 대해 JOB와 월급 총액을 출력하세요. (단, PRESIDENT를 제외시키고, 월급 총액별으로 정렬)
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

/* 3.CHICAGO에 근무하는 모든 종업원에 대해서 이름, 업무, 부서 번호 그리고 부서 이름을 출력하는 질의를 작성하세요.(emp, dept)*/
SELECT e.ename 이름, e.job 업무, d.deptno "부서 번호", d.dname "부서 이름"
FROM emp e, DEPT d
WHERE e.deptno = d.deptno
and d.loc = 'CHICAGO';

/* 4. 사원명, 입사일 그리고 입사한 요일을 출력하세요. 열 레이블은 DAY 입니다.(***결과는 월요일부터 시작하는 요일 순으로 정렬하세요.)
ENAME                HIREDATE DAY
-------------------- -------- ------------------------
SMITH                80/12/17 수요일
ALLEN                81/02/20 금요일
WARD                81/02/22 일요일 */
SELECT ENAME, HIREDATE, TO_CHAR(hiredate, 'DAY') DAY
FROM emp
ORDER BY TO_CHAR(hiredate-1, 'D');

/* 5. 1980, 1981, 1982, 1987년에 입사한 종업원에 대해서 전체 사원 수와 연도별 사원 수를 출력하세요.
적당한 열레이블을 부여하세요. (emp)
      TOTAL   1980       1981       1982    1987
---------- ---------- ---------- ----------   ----------
        14         1             10          1         2 */
SELECT COUNT(substr(HIREDATE, 1,2)) total,
       COUNT(decode(substr(HIREDATE, 1,2), 80, sal)) "1980",
       COUNT(decode(substr(HIREDATE, 1,2), 81, sal)) "1981",
       COUNT(decode(substr(HIREDATE, 1,2), 82, sal)) "1982",
       COUNT(decode(substr(HIREDATE, 1,2), 87, sal)) "1987"      
FROM emp;

