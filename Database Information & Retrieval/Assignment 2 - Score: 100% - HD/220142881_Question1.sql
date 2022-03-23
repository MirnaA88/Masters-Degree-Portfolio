Create table postcodes(
postcode char(4) Not Null,
suburb varchar(20) Not Null,
state char(3) Not Null,
primary key (postcode));

create table account_type_id(
account_type_id varchar(10) Not Null,
account_description text(20) Not Null,
primary key (account_type_id));

create table application_outcome (
application_id varchar(10) Not Null,
application_outcome varchar(20) Not Null,
primary key (application_id));

create table staff (
staff_id varchar(10) Not Null,
staff_name varchar (20) Not Null,
staff_position varchar (20) Not Null,
primary key (staff_id));

Create table customer_info (
customer_id varchar(20) Not Null,
customer_salary Decimal(15,2) Not Null,
customer_name char(20) Not Null,
customer_address1 varchar(30) Not Null, 
postcode char(4) Not Null,
loan_id varchar(10) Null,
primary key (customer_id),
foreign key (postcode) references postcodes(postcode));

create table property(
property_id varchar(10) Not Null,
property_value decimal(8,2) Not Null,
property_address_line1 varchar(30) Not Null, 
sold_price decimal(8,2) Not Null,
sold_date date Not Null,
customer_id varchar(20) Not Null,
postcode char(4) Not Null,
primary key (property_id),
foreign key (customer_id) references customer_info(customer_id),
foreign key (postcode) references postcodes(postcode));

Create table customer_account_info(
account_number int(10) Not Null,
bsb_number varchar(7) Not Null,
account_balance decimal(8,2),
account_type_id varchar(10) Not Null,
primary key (account_number),
foreign key (account_type_id) references account_type_id(account_type_id));

create table customer_account(
customer_id varchar(20) Not Null,
account_number int(10) Not Null,
primary key (customer_id),
foreign key (account_number) references customer_account_info(account_number));

Create table loan_application (
customer_id varchar(20) Not Null,
property_id varchar(10) Not Null,
application_id varchar(10) Not Null,
primary key (customer_id, property_id),
foreign key (property_id) REFERENCES property(property_id),
foreign key (customer_id) REFERENCES customer_info(customer_id));

create table home_loan(
loan_id varchar(10) Not Null,
staff_id varchar(10) Not Null,
property_id varchar(10) Not Null,
customer_id varchar(20) Not Null,
loan_amount decimal(10,2) Not Null,
account_number int(10) Not Null,
application_id varchar(10) Not Null,
primary key (loan_id),
foreign key (customer_id) references customer_info(customer_id),
foreign key (account_number) references customer_account_info(account_number),
foreign key (staff_id) references staff(staff_id));

create table owner_property(
property_id varchar(10) Not Null,
customer_id varchar(20) Not Null,
primary key (property_id, customer_id),
foreign key (customer_id) references customer_info(customer_id),
foreign key (property_id) references property(property_id));

create table suburb_average(
postcode char(4) Not Null,
suburb varchar(20) Not Null,
average_price Decimal(15,2) Not Null,
primary key (postcode, suburb));

SET FOREIGN_KEY_CHECKS=0;

insert into postcodes(postcode, suburb, state) values (3130, 'collingwood', 'VIC');
insert into postcodes(postcode, suburb, state) values (3000, 'Melbourne', 'VIC');
insert into postcodes(postcode, suburb, state) values (3132, 'Fitzroy', 'VIC');
insert into postcodes(postcode, suburb, state) values (3754, 'Seven Hills', 'VIC');
insert into postcodes(postcode, suburb, state) values (3153, 'Bayswater', 'VIC');

Insert into customer_info (customer_id, customer_salary, customer_name, customer_address1, postcode, loan_id) values ('Cus-001', 150000.00, 'Tom Smith', '1 Smith Street', 3130, 'HL-001');
Insert into customer_info (customer_id, customer_salary, customer_name, customer_address1, postcode, loan_id) values ('Cus-002', 160000.00, 'Anna Smith', '1 Smith Street', 3130, 'HL-001');
Insert into customer_info (customer_id, customer_salary, customer_name, customer_address1, postcode, loan_id) values ('Cus-003', 75000.00, 'Andrea Smith', '1 Sam Street', 3000, 'HL-002');
Insert into customer_info (customer_id, customer_salary, customer_name, customer_address1, postcode, loan_id) values ('Cus-004', 95000.00, 'Mark Smith', '5 John Street', 3132, 'HL-003');
Insert into customer_info (customer_id, customer_salary, customer_name, customer_address1, postcode, loan_id) values ('Cus-005', 60000.00, 'Andrew Smith', '5 Mark Street', 3000, 'HL-004');

insert into property(property_id, property_value, property_address_line1, sold_price, sold_date, customer_id, postcode) values ('PID-001', 700000.00, '1 Seven Hills Rd', 500000, '2019-12-01', 'Cus-001', 3754);
insert into property(property_id, property_value, property_address_line1, sold_price, sold_date, customer_id, postcode) values ('PID-005', 600000.00, '20 Melview Dr', 4, '2019-10-01', 'Cus-001', 3132);
insert into property(property_id, property_value, property_address_line1, sold_price, sold_date, customer_id, postcode) values ('PID-002', 500000.00, '50 Bakes Rd', 300000, '2018-08-01', 'Cus-003', 3000);
insert into property(property_id, property_value, property_address_line1, sold_price, sold_date, customer_id, postcode) values ('PID-003', 450000.00, '70 East parade', 300000, '2017-01-01', 'Cus-004', 3130);
insert into property(property_id, property_value, property_address_line1, sold_price, sold_date, customer_id, postcode) values ('PID-004', 800000.00, '12 John Street', 750000, '2021-12-01', 'Cus-005', 3130);

insert into account_type_id(account_type_id, account_description) values ('AT-001', 'Savings Account');
insert into account_type_id(account_type_id, account_description) values ('AT-002', 'Credit Account');
insert into account_type_id(account_type_id, account_description) values ('AT-003', 'Fixed Deposit');
insert into account_type_id(account_type_id, account_description) values ('AT-004', 'Everyday Account');

Insert into customer_account_info(account_number, bsb_number, account_balance, account_type_id) values (123456, '322_010', 50000.00, 'AT-001');
Insert into customer_account_info(account_number, bsb_number, account_balance, account_type_id) values (234567, '322_010', 70000.00, 'AT-001');
Insert into customer_account_info(account_number, bsb_number, account_balance, account_type_id) values (345678, '322_010', 35000.00, 'AT-001');
Insert into customer_account_info(account_number, bsb_number, account_balance, account_type_id) values (456789, '322_010',70000.00, 'AT-001');
Insert into customer_account_info(account_number, bsb_number, account_balance, account_type_id) values (567891, '322_010', 45000.00, 'AT-001');

insert into customer_account(customer_id, account_number) values ('Cus-001', 123456);
insert into customer_account(customer_id, account_number) values ('Cus-002', 234567);
insert into customer_account(customer_id, account_number) values ('Cus-003', 345678);
insert into customer_account(customer_id, account_number) values ('Cus-004', 456789);
insert into customer_account(customer_id, account_number) values ('Cus-005', 567891);

insert into home_loan(loan_id, staff_id, property_id, customer_id, loan_amount, account_number, application_id) values ('HL-001', 'ST-001', 'PID-001', 'Cus-001', 300000.00, 123456, 'HLA-005');
insert into home_loan(loan_id, staff_id, property_id, customer_id, loan_amount, account_number, application_id) values ('HL-005', 'ST-001', 'PID-005', 'Cus-001', 200000.00, 123456, 'HLA-006');
insert into home_loan(loan_id, staff_id, property_id, customer_id, loan_amount, account_number, application_id) values ('HL-002', 'ST-001', 'PID-002', 'Cus-003', 500000.00, 345678, 'HLA-002');
insert into home_loan(loan_id, staff_id, property_id, customer_id, loan_amount, account_number, application_id) values ('HL-003', 'ST-001', 'PID-003', 'Cus-004', 600000.00, 456789, 'HLA-003');
insert into home_loan(loan_id, staff_id, property_id, customer_id, loan_amount, account_number, application_id) values ('HL-004', 'ST-001', 'PID-004', 'Cus-005', 450000.00, 567891, 'HLA-004');

insert into suburb_average(postcode, suburb, average_price) values (3134, 'Ringwood', 900000.00);
insert into suburb_average(postcode, suburb, average_price) values (3153, 'Bayswater', 800000.00);
insert into suburb_average(postcode, suburb, average_price) values (3002, 'East Melbourne', 1200000.00);
insert into suburb_average(postcode, suburb, average_price) values (3145, 'Heathmont', 850000.00);
insert into suburb_average(postcode, suburb, average_price) values (3155, 'Wantirna', 900000.00);

SET FOREIGN_KEY_CHECKS=1;

#Query to find Tom & Anna's borrowing power
#first calculate the combined salary *10
Select @decadesalary:= SUM(c.customer_salary*10) as Decade_Salary
from customer_info c
where c.customer_id = 'Cus-001'
or c.customer_id = 'Cus-002';

#Find total Savings for Tom & Anna
Select @totalsavings:= Sum(ai.account_balance) as total_savings
from customer_account_info ai
inner join customer_account ca
on ca.account_number = ai.account_number
where ca.customer_id = 'Cus-001'
or ca.customer_id = 'Cus-002';

#Find 0.65 of average property price for proeprty to purchase in ringwood
Select @propertyvalue:= Sum(s.average_price *0.65) as property_value
from suburb_average s
where s.suburb = 'Ringwood';

# Now find amount of existing homeloan for tom
Select  @totalloan:= Sum(l.loan_amount) as total_loan
from home_loan l
where l.customer_id = 'Cus-001';

#how much tom & anna can borrow:
#(Decade Salary + Total Savings + Property Value (0.65) - total loan
Select Round((@decadesalary + @totalsavings + @propertyvalue) - @totalloan);