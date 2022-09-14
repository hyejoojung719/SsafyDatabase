use ssafydb;
# 단순 뷰
create view v_countries
as
	select country_id,country_name, region_id from countries;
insert into v_countries values("QQ", "KKA", 3); # 뷰를 통해 원본 테이블에 값을 넣을 수 있음


#복합 뷰
create view view1 as
select c.country_id, c.country_name, r.region_id
    from countries c
    join regions r
    on c.region_id = r.region_id;
select * from view1;
