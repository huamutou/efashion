/*
 *    Masking Data simple test
 *		Toshihisa HANAKi
 *		2017.04.21.
 */

/* connect by system */
create schema test_masking;
set schema test_masking;

drop table employee;
create column table employee(
	Name	varchar(20),
	FirstName	varchar(20),
	SSN	varchar(11),
	CreditCard	varchar(19)	
	);
insert into employee values('Smith','johns','123-33-1233','1234-5678-9012-3456');
insert into employee values('Hanaki','Toshihisa','123-33-1244','4298-5778-9012-2251');
insert into employee values('Hashimoto','Nanami','123-56-9876','9034-2278-9012-8346');
select * from employee;

--drop view v_emp;
create view v_emp(
	Name, 
	FirstName, 
	MaskedSSN, 
	MaskedCreditCard
	)
AS SELECT
		Name, 
		FirstName, 
		SSN, 
		CreditCard
	FROM employee
WITH MASK (
	MaskedSSN USING 'XXX-XX-' || RIGHT(MaskedSSN, 4),
	MaskedCreditCard USING 'XXXX-XXXX-XXXX-XXXX'
	)
;
select * from v_emp;

--drop user UserA;
create  user UserA PASSWORD Hana8787 NO FORCE_FIRST_PASSWORD_CHANGE;
grant select on v_emp to UserA;

/* connect by UserA */
select * from "TEST_MASKING"."V_EMP"

/* connect by system */
--drop user UserB;
create user UserB PASSWORD Hana8787 NO FORCE_FIRST_PASSWORD_CHANGE;
grant select, unmasked on v_emp to UserB;

/* connect by UserB */
select * from "TEST_MASKING"."V_EMP"


