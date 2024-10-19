CREATE DATABASE BANK_LOAN_ANALYSES_PROJECT;
USE BANK_LOAN_ANALYSES_PROJECT;
SELECT count(*) FROM FINANCE_1_;
SELECT count(*) FROM FINANCE_2_;
SELECT * FROM FINANCE_1_;
SELECT * FROM FINANCE_2_;
/*
Year wise loan amount 
*/
# KPI 1
SELECT 
    YEAR(issue_d) AS Year_of_Issue_date,
    CONCAT(FORMAT(ROUND(SUM(loan_amnt) / 1000000, 0),
                0),
            'M') AS Total_Loan_Amount
FROM
    FINANCE_1_
GROUP BY Year_of_Issue_date
ORDER BY Year_of_Issue_date;

/*
Grade and subgrade wise revol_Bal
*/
# KPI 2
SELECT 
    grade,
    sub_grade,
    CONCAT(FORMAT(SUM(revol_bal) / 1000000, 0), 'M') AS Total_Revol_bal
FROM
    FINANCE_1_
        INNER JOIN
    FINANCE_2_ ON FINANCE_1_.id = FINANCE_2_.id
GROUP BY grade , sub_grade
ORDER BY grade , sub_grade;

/*
Total Payment for verified and Non verified status
*/
# KPI 3
SELECT 
    verification_status,
    CONCAT(FORMAT(SUM(total_pymnt) / 1000000, 0),
            'M') AS Total_Payment
FROM
    FINANCE_1_
        INNER JOIN
    FINANCE_2_ ON FINANCE_1_.id = FINANCE_2_.id
WHERE
    verification_status IN ('Verified' , 'Not Verified')
GROUP BY verification_status
ORDER BY Total_Payment;

/*
State wise and month wise loan status
*/
# KPI 4
/* count of loan status add and order*/
SELECT 
    addr_state,
    MONTHNAME(issue_d) AS Month_name,
    loan_status,
    COUNT(loan_status) AS Loan_Count
FROM
    FINANCE_1_
GROUP BY addr_state , Month_name , loan_status
ORDER BY addr_state; 

/*
Home ownership vs Last Payment Date
*/
# KPI 5
SELECT 
    home_ownership, COUNT(last_pymnt_d) AS Loan_Stats
FROM
    finance_1_
        JOIN
    finance_2_ ON (finance_1_.id = finance_2_.id)
GROUP BY home_ownership;
