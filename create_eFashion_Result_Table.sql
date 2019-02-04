/*
**
** M_Service_Threds :  procedure and table to copy it
**
*/
create schema bk;
set schema bk;

-- select * from "SYS"."M_SERVICE_THREADS"  where service_name = 'indexserver' ;

drop table "BK"."TH";
create table "BK"."TH"(
	ts				timestamp,
	thread_id		bigint,
	calling			varchar(256),
	caller			varchar(256),
	thread_type		varchar(128),
	thread_method	varchar(256),
	thread_detail	nclob,
	thread_state	varchar(32),
	user_name		nvarchar(256)
	);
	
drop table "BK"."SW";
create table "BK"."SW"(sw varchar(1));
insert into "BK"."SW" values('n');	-- y:execute, n:stop
select * from "BK"."SW";

create type sw_type as table(sw varchar(1));

drop procedure switch;
create procedure switch( sw varchar(1)) language sqlscript sql security definer as
	begin
		update "BK"."SW" set sw = :sw;
	end;
call switch('y');


drop procedure show;
create procedure show(out current_sw varchar(3)) language sqlscript sql security definer as
	begin
		declare wk_sw varchar(1);
		select sw into wk_sw from "BK"."SW";
		if :wk_sw = 'y'
		then
			current_sw := 'YES';
		else
			current_sw := 'NO';
		end if;
	end;
call show(?);

select current_timestamp from dummy;

drop procedure ins_th;
create procedure ins_th() language sqlscript sql security definer as
begin 
	declare wk_sw varchar(1);
	select sw into wk_sw from "BK"."SW";

	while :wk_sw = 'y' do
		insert into "BK"."TH" 
			select current_timestamp, 
					thread_id, 
					calling, 
					caller, 
					thread_type, 
					thread_method, 
					thread_detail, 
					thread_state, 
					user_name
			from "SYS"."M_SERVICE_THREADS"
			where service_name = 'indexserver';
		
		select sw into wk_sw from "BK"."SW";

	end while;
			
end;

truncate table "BK"."TH";

call ins_th();
select * from th;
select count(*) from th;


