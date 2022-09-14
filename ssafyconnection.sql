create user 'test'@'localhost' identified by '1234';

# test 유저에게 world db의 조회 권한 추가
# with grant option을 붙이면 test사용자가 world db의 모든테이블 조회권한을 다른사람한테도 grant가능
grant select on world.* to 'test'@'localhost' with grant option; 

# 권한 뺏기
# 참고로 권한 뺏을때 전체중에 한 개만 뺏지 못함.
# *주면 뺏을 때도 *
revoke select on world.* from 'test'@'localhost';


use world;

# test 테이블 생성
# id - 숫자 타입, PK, auto_increment /  pwd - char(30) nullX
create table test(
	# 컬럼 레벨의 제약 조건 설정
	id int primary key auto_increment,
    pwd char(30) not null,
    # 테이블 레벨의 제약 조건 설정
    primary key(id, pwd) # id와 pwd가 동시에 일치해야 같은 데이터일것 
); 
desc test;

insert into test (pwd) values ('1234');
insert into test (pwd) values ('5678');
select * from test;

# 존재할 때만 지우기
drop table if exists test;

# id, pwd, name, city_id
create table test(
	# 컬럼 레벨 지정
    # id varchar(20) primary key
	id varchar(20) ,
    pwd varchar(30) not null,
    name varchar(5),
    city_id int,
    
    # 테이블레벨 지정
    primary key(id),
    # constraint [제약조건명] 제약조건(컬럼)
    constraint id_name_uk unique(id,name),
    constraint fk foreign key(city_id)
    references city(id)
);

desc test;

# 만들어져 있는 테이블에 컬럼 추가
# alter  table [테이블명] add [컬럼정보]
alter table test add address varchar(30);
# 존재하는 컬럼 정보 변경 
alter table test modify address char(30) default '한국';
# 칼럼 이름 변경
alter table test change address addr char(30) default '한국';
# unsigned -> 부호가 없는것(양수값만 가능)
alter table test add age int unsigned default 0;
insert into test (id, pwd, city_id, age) values ('ssafy', 'ssafy', 1, -10);
# 특정 조건을 만족하는 값만 저장하고 싶은 경우
alter table test add birthyear int check(birthyear>=1900 and birthyear<=2022);
insert into test (id, pwd, city_id, birthyear) values ('ssafy', 'ssafy', 1, 1900);

insert into city (id, name, countrycode) values (20000, 'new', 'PSE');
# 추가X -> 외래키 때문에,, 따라서 부모 테이블에 있는 것만 추가 가능
insert into test (id, pwd, city_id) values("test", '1234', 18000);
# 아래는 추가 가능
insert into test (id, pwd, city_id) values("test", '1234', 20000);
# 자식쪽에서 참조 중인 값은 수정이나 삭제 불가능(default가 restrict)
delete from city where id=20000;
#제약조건 수정하기
#제약조건 삭제
alter table test drop foreign key fk;
#제약조건 추가
alter table test add constraint fk foreign key(city_id)
references city(id)
on delete cascade; # 부모 데이터 삭제시 자식데이터 함께 삭제