create table irctc_freight(b_id int not null primary key,
user_id int not null foreign key(user_id) references tbl_user(user_id), 
freight_name varchar(50) not null,
freight_type int not null foreign key(freight_type) references freight_type(freight_type_id),
from_place  int not null foreign key(from_place) references place(place_id),
to_place  int not null foreign key(to_place) references place(place_id),
departure  int not null foreign key(departure) references tbl_time(date_id),
arrival  int not null foreign key(arrival) references tbl_time(date_id),
createdBy varchar(50) not null default 'Sandhya',
createdDate datetime not null default getDate(),
modifiedBy varchar(50) not null default 'Sandhya',
modifiedDate datetime not null default getDate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid());

create table freight_type(freight_type_id int primary key,freight_type varchar(20) not null unique);

alter table freight_type add createdBy varchar(50) not null default 'Sandhya',
createdDate datetime not null default getDate(),
modifiedBy varchar(50) not null default 'Sandhya',
modifiedDate datetime  not null default getDate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid();

truncate table place
create table place(place_id int primary key,place_name varchar(20) not null unique,createdBy varchar(50) not null default 'Sandhya',
createdDate datetime not null default getDate(),
modifiedBy varchar(50) not null default 'Sandhya',
modifiedDate datetime not null default getDate(),
RecordStatus bit default 1,
RowGUID varchar(max) default newid())
select * from place
insert into place(place_id,place_name) values(1,'chennai')
insert into place(place_id,place_name) values(2,'bangalore')
insert into place(place_id,place_name) values(3,'mumbai')
insert into place(place_id,place_name) values(4,'Delhi')