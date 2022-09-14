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
	id int primary key auto_increment,
    pwd char(30) not null
); 