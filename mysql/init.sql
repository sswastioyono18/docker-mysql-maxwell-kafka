
use mysql;
select host, user from user;

-- mysql 8
CREATE USER 'maxwell'@'%' IDENTIFIED BY 'max';

-- http://maxwells-daemon.io/quickstart/
GRANT ALL on maxwell.* to 'maxwell'@'%';
GRANT SELECT, REPLICATION CLIENT, REPLICATION SLAVE on *.* to 'maxwell'@'%';

flush privileges;
create database `maxwell` default character set utf8 collate utf8_general_ci;
create database `test` default character set utf8 collate utf8_general_ci;
use test;
create table test(id int not null, name varchar(100));
insert into test values(1, 'from master');