#Create Schema

Create table postcodes(
postcode char(4) Not Null,
suburb varchar(20) Not Null,
state char(3) Not Null,
primary key (postcode));

create table room_phone(
room_number varchar(20) Not Null,
room_phone varchar(20) Not Null,
primary key (room_number));

create table department_room(
department_name varchar (50) Not Null,
faculty varchar (50) Not Null,
room_number varchar(20) Not Null,
primary key (department_name),
foreign key (room_number) references room_phone(room_number));

create table course_description(
course_id varchar(20) Not Null,
course_title char(50) Not Null,
department_name varchar (50) Not Null,
primary key (course_id),
foreign key (department_name) references department_room (department_name));

create table place_student(
place_id varchar(20) Not Null,
student_id varchar (20) Not Null,
primary key (place_id));

create table student_lease_place(
lease_id varchar (20) Not Null,
place_id varchar(20) Not Null,
primary key (lease_id),
foreign key (place_id) references place_student (place_id));

create table staff_info(
staff_id varchar (20) Not Null,
first_name char (20) Not Null,
last_name char (20) Not Null,
postion varchar(50) Not Null,
email varchar(50) Not Null,
mobile varchar(20) Not Null,
phone varchar(20) Not Null,
is_advisor char (3) Not Null,
staff_location varchar (20) Not Null,
address_line1 varchar (50) Not Null,
postcode char(4) Not Null,
department_name varchar (50) Not Null,
primary key (staff_id),
foreign key (department_name) references department_room (department_name),
foreign key (postcode) references postcodes(postcode));

create table student_details (
student_id varchar (20) Not Null,
first_name char (20) Not Null,
last_name char (20) Not Null,
nationality char (20) Not Null,
birthdate date Not Null,
gender char (6) Not Null,
is_mentor char (3) Not Null,
lease_id varchar (20) Null,
lease_status char (30) Not Null,
special_needs char (100),
course_id varchar (20) Not Null,
staff_id varchar (20) Not Null,
mentee_id varchar(20) Null,
primary key (student_id),
foreign key (course_id) references course_description(course_id),
foreign key (staff_id) references staff_info(staff_id));

create table student_contact(
student_id varchar (20) Not Null,
email varchar(20) Not Null,
mobile varchar(20) Not Null,
phone varchar(20) Not Null,
address_line1 varchar (50) Not Null,
postcode char(4) Not Null,
primary key (student_id),
foreign key (postcode) references postcodes(postcode));

create table guardian_info(
guardian_id varchar (20) Not Null,
student_id varchar (20) Not Null,
first_name char (20) Not Null,
last_name char (20) Not Null,
mobile varchar(20) Not Null,
phone varchar(20) Not Null,
email varchar(20) Not Null,
relationship char(20) Not Null,
address_line1 varchar (50) Not Null,
postcode char(4) Not Null,
primary key (guardian_id),
foreign key (postcode) references postcodes(postcode),
foreign key (student_id) references student_details (student_id));

create table staff_course(
staff_id varchar (20) Not Null,
course_id varchar (20) Not Null,
primary key (staff_id),
foreign key (course_id) references course_description(course_id));

create table place_details(
place_id varchar(20) Not Null,
monthly_rent decimal(5,2) Not Null,
accommodation_type char(20) Not Null,
primary key (place_id));

create table leases(
lease_id varchar (20) Not Null,
student_id varchar (20) Not Null,
lease_start_date date Not Null,
lease_end_date date Not Null,
lease_term int Not Null,
place_id varchar(20) Not Null,
primary key (lease_id),
foreign key (place_id) references place_details (place_id));

alter table place_student add constraint fk_student_id
	foreign key (student_id) references student_details(student_id);

alter table student_details add constraint fk_lease_id
	foreign key (lease_id) references leases(lease_id);
    
create table payments(
invoice_id varchar(20),
student_id varchar (20) Not Null,
lease_id varchar (20) Not Null,
term int Not Null,
due_date date Not Null,
payment_method char(20) Not Null,
reminder_date_1 date Null,
reminder_date_2 date Null,
place_id varchar(20) Not Null,
primary key (invoice_id),
foreign key (student_id) references student_details (student_id),
foreign key (lease_id) references leases (lease_id));

create table inspections(
inspection_date date Not Null,
student_id varchar (20) Not Null,
staff_id varchar (20) Not Null,
place_id varchar(20) Not Null,
satisfactory_condition char(3) Not Null,
comments char(200),
primary key(inspection_date, student_id),
foreign key (staff_id) references staff_info(staff_id));

create table unit_details(
unit_id varchar(20) Not Null,
address_line1 varchar (50) Not Null,
accommodation_type char(20) Not Null,
unit_room_count int Not Null,
postcode char(4) Not Null,
primary key (unit_id),
foreign key (postcode) references postcodes(postcode));

create table unit_room(
room_id varchar(20) Not Null,
unit_id varchar(20) Not Null,
place_id varchar(20) Not Null,
primary key (room_id),
foreign key (unit_id) references unit_details (unit_id),
foreign key (place_id) references place_student(place_id));

create table hall_details(
hall_id varchar(20) Not Null,
accommodation_type char(20) Not Null,
hall_name char(20) Not Null,
staff_id varchar (20) Not Null,
address_line1 varchar (50) Not Null,
postcode char(4) Not Null,
hall_phone varchar(20) Not Null,
primary key (hall_id),
foreign key (staff_id) references staff_info(staff_id),
foreign key (postcode) references postcodes(postcode));

create table hall_room(
room_id varchar(20) Not Null,
place_id varchar(20) Not Null,
hall_id varchar(20) Not Null,
primary key (room_id),
foreign key (hall_id) references hall_details (hall_id),
foreign key (place_id) references place_student(place_id));

create table dorm_building (
building_id varchar(20) Not Null,
address_line1 varchar (50) Not Null,
accommodation_type char(20) Not Null,
dorm_count int Not Null,
postcode char(4) Not Null,
primary key (building_id),
foreign key (postcode) references postcodes(postcode));

create table dorms(
dorm_id varchar(20) Not Null,
building_id varchar(20) Not Null,
bed_id varchar(20) Not Null,
primary key (dorm_id),
foreign key (building_id) references dorm_building (building_id));

create table dorm_beds(
bed_id varchar(20) Not Null,
dorm_id varchar(20) Not Null,
place_id varchar(20) Not Null,
primary key  (bed_id),
foreign key (place_id) references place_student(place_id),
foreign key (dorm_id) references dorms(dorm_id));

alter table dorms add constraint fk_bed_id
	foreign key (bed_id) references dorm_beds(bed_id);

SET FOREIGN_KEY_CHECKS=0;


insert into student_details(student_id, first_name, last_name, nationality, birthdate, gender, is_mentor, lease_id, lease_status, special_needs, course_id, staff_id, mentee_id)
values ('SID-001', 'John', 'Smith', 'Australian', '1988-01-01', 'Male', 'No', 'LID-005', 'Leased', ' ', 'MIS716', 'ST-001', '');
insert into student_details(student_id, first_name, last_name, nationality, birthdate, gender, is_mentor, lease_id, lease_status, special_needs, course_id, staff_id, mentee_id)
values ('SID-002', 'Annie', 'Roberts', 'American', '1989-01-01', 'Female', 'Yes', 'LID-001', 'Leased', ' ', 'MIS718', 'ST-001', 'SID-001');
insert into student_details(student_id, first_name, last_name, nationality, birthdate, gender, is_mentor, lease_id, lease_status, special_needs, course_id, staff_id, mentee_id)
values ('SID-003', 'Catherine', 'Roberts', 'Australian', '1982-02-01', 'Female', 'No', 'LID-002', 'Leased', ' ', 'MIS716', 'ST-002','');
insert into student_details(student_id, first_name, last_name, nationality, birthdate, gender, is_mentor, lease_id, lease_status, special_needs, course_id, staff_id, mentee_id)
values ('SID-004', 'Mark', 'Smith', 'Australian', '1982-02-28', 'Male', 'Yes', 'LID-003', 'Leased', ' ', 'MIS717', 'ST-003', 'SID-003');
insert into student_details(student_id, first_name, last_name, nationality, birthdate, gender, is_mentor, lease_id, lease_status, special_needs, course_id, staff_id, mentee_id)
values ('SID-005', 'Clayton', 'Peters', 'Irish', '1979-07-28', 'Male', 'Yes', 'LID-007', 'Leased', 'Disabled Toilet', 'MIS715', 'ST-003', 'SID-006');
insert into student_details(student_id, first_name, last_name, nationality, birthdate, gender, is_mentor, lease_id, lease_status, special_needs, course_id, staff_id, mentee_id)
values ('SID-006', 'Justin', 'Laird', 'Scottish', '1988-07-17', 'Male', 'No', 'LID-004', 'Leased', '', 'MIS716', 'ST-004','');

insert into student_lease_place(lease_id, place_id) values ('LID-005', 'PL-001');
insert into student_lease_place(lease_id, place_id) values ('LID-001', 'PL-006');
insert into student_lease_place(lease_id, place_id) values ('LID-002', 'PL-002');
insert into student_lease_place(lease_id, place_id) values ('LID-003', 'PL-003');
insert into student_lease_place(lease_id, place_id) values ('LID-004', 'PL-005');
insert into student_lease_place(lease_id, place_id) values ('LID-007', 'PL-004');

insert into place_student (place_id, student_id) values ('PL-001', 'SID-001');
insert into place_student (place_id, student_id) values ('PL-006', 'SID-002');
insert into place_student (place_id, student_id) values ('PL-002', 'SID-003');
insert into place_student (place_id, student_id) values ('PL-003', 'SID-004');
insert into place_student (place_id, student_id) values ('PL-004', 'SID-005');
insert into place_student (place_id, student_id) values ('PL-005', 'SID-006');

insert into staff_info (staff_id, first_name, last_name, postion, email, mobile, phone, is_advisor, staff_location, address_line1, postcode, department_name)
values ('ST-001', 'Michael', 'Patterson', 'Unit Chair - SIT772', 'michael.patterson@deakin.edu.au', '0412187722', '0399723344', 'No', 'Burwood Campus', '1 Melview Drive', '3134', 'School of IT');
insert into staff_info (staff_id, first_name, last_name, postion, email, mobile, phone, is_advisor, staff_location, address_line1, postcode, department_name)
values ('ST-002', 'Jason', 'Smith', 'Accommodation Manager', 'jason.smith@deakin.edu.au', '0412187723', '0388723344', 'No', 'Victoria Hall', '20 Bedford Road', '3023', 'Deakin Student Accommodation');
insert into staff_info (staff_id, first_name, last_name, postion, email, mobile, phone, is_advisor, staff_location, address_line1, postcode, department_name)
values ('ST-003', 'Andrew', 'Brooks', 'Accommodation Manager', 'andrew.brooks@deakin.edu.au', '042287723', '0388723355', 'No', 'Victoria Hall', '15 Sample Road', '3023', 'Deakin Student Accommodation');
insert into staff_info (staff_id, first_name, last_name, postion, email, mobile, phone, is_advisor, staff_location, address_line1, postcode, department_name)
values ('ST-004', 'Mark', 'BAnthony', 'Accommodation Manager', 'mark.anthony@deakin.edu.au', '0477885643', '0396547899', 'No', 'Victoria Hall', '23 John Street', '3321', 'Deakin Student Accommodation');
insert into staff_info (staff_id, first_name, last_name, postion, email, mobile, phone, is_advisor, staff_location, address_line1, postcode, department_name)
values ('ST-005', 'Andrew', 'Smith', 'Unit Chair - SIT720', 'andrea.smith@deakin.edu.au', '0411223344', '0391145678', 'No', 'Burwood Campus', '15 Grey Street', '3331', 'School of IT');
insert into staff_info (staff_id, first_name, last_name, postion, email, mobile, phone, is_advisor, staff_location, address_line1, postcode, department_name)
values ('ST-006', 'Katy', 'Shaw', 'Student Advisor', 'katy.shaw@deakin.edu.au', '0455667788', '0398982323', 'Yes', 'Geelong Campus', '20 Grey Street', '3331', 'Deakin Student Accommodation');

insert into place_details (place_id, monthly_rent, accommodation_type) values ('PL-001', '900.00', 'Unit');
insert into place_details (place_id, monthly_rent, accommodation_type) values ('PL-002', '900.00', 'Unit');
insert into place_details (place_id, monthly_rent, accommodation_type) values ('PL-003', '800.00', 'Victoria Hall');
insert into place_details (place_id, monthly_rent, accommodation_type) values ('PL-004', '800.00', 'Victoria Hall');
insert into place_details (place_id, monthly_rent, accommodation_type) values ('PL-005', '900.00', 'Unit');
insert into place_details (place_id, monthly_rent, accommodation_type) values ('PL-006', '500.00', 'Dorm');

insert into leases (lease_id, student_id, lease_start_date, lease_end_date, lease_term, place_id) 
values ('LID-005', 'SID-001', '2020-01-01', '2020-12-31', '12', 'PL-001');
insert into leases (lease_id, student_id, lease_start_date, lease_end_date, lease_term, place_id) 
values ('LID-001', 'SID-002', '2020-03-01', '2020-09-01', '6', 'PL-006');
insert into leases (lease_id, student_id, lease_start_date, lease_end_date, lease_term, place_id) 
values ('LID-002', 'SID-003', '2020-03-01', '2020-12-31', '9', 'PL-002');
insert into leases (lease_id, student_id, lease_start_date, lease_end_date, lease_term, place_id) 
values ('LID-003', 'SID-004', '2020-01-01', '2020-03-01', '3', 'PL-003');
insert into leases (lease_id, student_id, lease_start_date, lease_end_date, lease_term, place_id) 
values ('LID-007', 'SID-005', '2020-01-01', '2020-06-01', '6', 'PL-004');
insert into leases (lease_id, student_id, lease_start_date, lease_end_date, lease_term, place_id) 
values ('LID-004', 'SID-006', '2020-01-01', '2020-12-31', '12', 'PL-005');

insert into unit_details(unit_id, address_line1, accommodation_type, unit_room_count, postcode)
values ('UN-001', '1/233 Burwood Hwy', 'Unit', 3, '3023');
insert into unit_details(unit_id, address_line1, accommodation_type, unit_room_count, postcode)
values ('UN-002', '2/233 Burwood Hwy', 'Unit', 4, '3023');
insert into unit_details(unit_id, address_line1, accommodation_type, unit_room_count, postcode)
values ('UN-003', '3/233 Burwood Hwy', 'Unit', 4, '3023');
insert into unit_details(unit_id, address_line1, accommodation_type, unit_room_count, postcode)
values ('UN-004', '4/233 Burwood Hwy', 'Unit', 5, '3023');
insert into unit_details(unit_id, address_line1, accommodation_type, unit_room_count, postcode)
values ('UN-005', '5/233 Burwood Hwy', 'Unit', 3, '3023');
insert into unit_details(unit_id, address_line1, accommodation_type, unit_room_count, postcode)
values ('UN-006', '6/233 Burwood Hwy', 'Unit', 3, '3023');

insert into unit_room (room_id, unit_id, place_id) values ('UNRM-101', 'UN-001', 'PL-001');
insert into unit_room (room_id, unit_id, place_id) values ('UNRM-102', 'UN-001', 'PL-002');
insert into unit_room (room_id, unit_id, place_id) values ('UNRM-103', 'UN-001', 'PL-005');
insert into unit_room (room_id, unit_id, place_id) values ('UNRM-201', 'UN-002', 'PL-007');
insert into unit_room (room_id, unit_id, place_id) values ('UNRM-202', 'UN-002', 'PL-008');
insert into unit_room (room_id, unit_id, place_id) values ('UNRM-203', 'UN-002', 'PL-009');

insert into hall_details (hall_id, accommodation_type, hall_name, staff_id, address_line1, postcode, hall_phone)
values ('HL-001', 'Victoria Hall', 'Griffith', 'ST-002', '240 Burwood Hwy', '3023', '0388987787');
insert into hall_details (hall_id, accommodation_type, hall_name, staff_id, address_line1, postcode, hall_phone)
values ('HL-002', 'Victoria Hall', 'Medley', 'ST-003', '241 Burwood Hwy', '3023', '0388987798');
insert into hall_details (hall_id, accommodation_type, hall_name, staff_id, address_line1, postcode, hall_phone)
values ('HL-003', 'Victoria Hall', 'Xavier', 'ST-004', '242 Burwood Hwy', '3023', '0388987779');
insert into hall_details (hall_id, accommodation_type, hall_name, staff_id, address_line1, postcode, hall_phone)
values ('HL-004', 'Victoria Hall', 'Lowther', 'ST-121', '243 Burwood Hwy', '3023', '0388988879');
insert into hall_details (hall_id, accommodation_type, hall_name, staff_id, address_line1, postcode, hall_phone)
values ('HL-005', 'Victoria Hall', 'Bowden', 'ST-223', '244 Burwood Hwy', '3023', '0388966679');
insert into hall_details (hall_id, accommodation_type, hall_name, staff_id, address_line1, postcode, hall_phone)
values ('HL-006', 'Victoria Hall', 'Union', 'ST-527', '245 Burwood Hwy', '3023', '0388922279');

insert into hall_room (room_id, place_id, hall_id) values ('HLRM-101', 'PL-003', 'HL-001');
insert into hall_room (room_id, place_id, hall_id) values ('HLRM-102', 'PL-004', 'HL-001');
insert into hall_room (room_id, place_id, hall_id) values ('HLRM-201', 'PL-015', 'HL-002');
insert into hall_room (room_id, place_id, hall_id) values ('HLRM-202', 'PL-016', 'HL-002');
insert into hall_room (room_id, place_id, hall_id) values ('HLRM-203', 'PL-221', 'HL-002');
insert into hall_room (room_id, place_id, hall_id) values ('HLRM-501', 'PL-321', 'HL-005');
insert into hall_room (room_id, place_id, hall_id) values ('HLRM-502', 'PL-447', 'HL-005');

SET FOREIGN_KEY_CHECKS=1;

#Question 3 - (d) Task 1:
#Present a listing of the managers name and telephone number for each hall of residence:
Select
s.staff_id, s.first_name, s.last_name, h.hall_id, h.accommodation_type, h.hall_name, h.hall_phone
from staff_info s
inner join hall_details h
on s.staff_id = h.staff_id;

#Question 3 - (d) Task 2:
#present a report listing the names and student id with the details of their lease agreements.
Select 
s.student_id, s.first_name, s.last_name, l.lease_id, l.lease_start_date, 
l.lease_end_date, l.lease_term, l.place_id, p.monthly_rent, p.accommodation_type
from leases l
inner join student_details s
inner join place_details p
on l.lease_id = s.lease_id
and l.place_id = p.place_id;

#Question 3 - (d) Task 3:
#List each student and his mentor who lives in either Victoria Hall or Deakin Unit

Select
s.student_id, s.first_name, s.last_name, m.student_id as mentor_id, m.first_name as mentor_firstname, m.last_name as mentor_lastname, 
p.accommodation_type as student_accomodation_type, pm.accommodation_type as mentor_accomodation_type
from student_details s
inner join student_details m on s.student_id = m.mentee_id
inner join leases l on s.lease_id = l.lease_id
inner join place_details p on l.place_id = p.place_id
inner join leases lm on m.lease_id = lm.lease_id	
inner join place_details pm on lm.place_id = pm.place_id
where (p.accommodation_type like '%unit%' or p.accommodation_type like '%hall%') and 
(pm.accommodation_type like '%unit%' or pm.accommodation_type like '%hall%');


#Question 3 - (d) Task 4:
#present a report of the names and ID of students with their room number and place number on a particular hall of residence
Select
s.student_id, s.first_name, s.last_name, l.place_id, h.room_id, h.hall_id
from student_details s
inner join leases l 
inner join hall_room h
on s.student_id = l.student_id
and l.place_id = h.place_id;