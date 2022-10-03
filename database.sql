create database `sprint1`;
use `sprint1`;

create table if not exists `account` (
	account_id bigint primary key auto_increment,
    username varchar(20) unique not null,
    `password` varchar(255) not null,
    account_flag boolean default 0
);

create table if not exists `role` (
	role_id bigint primary key auto_increment,
    role_name varchar(30),
    role_flag boolean default 0
);

create table if not exists account_role (
	account_role_id bigint primary key auto_increment,				
	account_id bigint not null,				
	role_id bigint not null,				
    account_role_flag boolean default 0,
	foreign key (account_id) references `account`(account_id),				
	foreign key (role_id) references `role` (role_id)				
);

create table if not exists customer_type (
	customer_type_id bigint primary key auto_increment,
    customer_type_name varchar(50) unique not null,
    customer_type_flag boolean default 0
);

create table if not exists material_type (
	material_type_id bigint primary key auto_increment,
    material_name varchar(20) not null,
    material_type_flag boolean default 0
); 					

create table if not exists position (
	position_id bigint primary key auto_increment,
    position_name varchar(50) not null,
    position_flag boolean default 0
);

create table if not exists customer(						
	customer_id bigint primary key auto_increment,						
	customer_name varchar(50) not null,						
	customer_code varchar(10) not null,						
	customer_avatar varchar(255),						
	customer_address varchar(60),						
	customer_phone varchar (20),						
	customer_email varchar (50) not null,
    customer_flag boolean default 0,
	customer_type_id bigint not null,						
	foreign key (customer_type_id) references customer_type (customer_type_id)						
);	

create table if not exists employee(
	employee_id bigint primary key auto_increment,
    employee_code varchar(10) not null,
    employee_name varchar(50) not null,
    employee_avatar varchar(255),
    employee_date_of_birth date,
    employee_gender varchar(20), 
    employee_address varchar(60),
    employee_phone varchar(20),
    employee_salary double,
    employee_flag boolean default 0,
    employee_account_id bigint unique not null,
    employee_position_id bigint not null,
    foreign key (employee_account_id) references `account` (account_id),
    foreign key (employee_position_id) references position (position_id)
);

create table if not exists salary (							
	salary_id bigint primary key auto_increment,					
	salary_advance_payment double default 0,
    salary_flag boolean default 0,
	salary_employee_id bigint not null,					
	foreign key(salary_employee_id) references employee(employee_id)					
);					

create table if not exists material (
	material_id bigint auto_increment primary key ,
	material_code varchar(20) not null,
	material_name varchar(20)not null,
	material_price double not null,
	material_expiridate date not null,
    material_flag boolean default 0,
    material_unit varchar(20),
	material_type_id bigint not null,
    material_customer_id bigint not null,
	foreign key (material_type_id) references material_type(material_type_id),
    foreign key (material_customer_id) references customer(customer_id)
);

create table if not exists cart (					
	cart_id bigint primary key auto_increment,					
	cart_amount int not null,					
	cart_total_money double not null,					
	cart_status boolean not null,	
    cart_flag boolean default 0,
	cart_account_id bigint not null,					
	cart_customer_id bigint not null,					
	foreign key (cart_customer_id) references customer(customer_id),					
	foreign key (cart_account_id) references `account`(account_id)					
);					

create table if not exists cart_material (					
	cart_material_id bigint primary key auto_increment,					
	cart_id bigint not null,					
    cart_material_flag boolean default 0,
	material_id bigint not null,					
	foreign key(cart_id) references cart(cart_id),					
	foreign key(material_id) references material(material_id)					
);					

create table if not exists `import` (
	import_id bigint primary key auto_increment, 
	import_code varchar(10) not null, 
	import_start_date date,
	import_quantity int,
    import_flag boolean default 0,
	import_employee_id bigint not null,
	import_material_id bigint not null,
	foreign key (import_employee_id) references employee (employee_id),
	foreign key (import_material_id) references material (material_id)
);	

create table if not exists bill_output (
	bill_output_id bigint primary key auto_increment , 
	bill_output_date date, 
    bill_output_flag boolean default 0,
	bill_output_employee_id bigint not null,
	bill_output_customer_id  bigint not null,
	foreign key (bill_output_employee_id) references employee (employee_id),
	foreign key (bill_output_customer_id) references customer (customer_id)
);				

create table if not exists bill_output_material(
	bill_output_material_id bigint auto_increment primary key,
	bill_output_id bigint not null, 
    bill_output_material_quantity int,
    bill_output_material_flag boolean default 0,
	material_id bigint not null, 
	foreign key (bill_output_id) references bill_output(bill_output_id),
	foreign key (material_id) references material(material_id)
);			