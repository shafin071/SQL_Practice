USE Sales;

create table items
(
	item_id VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10,2),
    company_id VARCHAR(255),
primary key (item_id)
);

DROP table companies;

create table companies
(
	company_id  INT AUTO_INCREMENT,
    company_name  VARCHAR(255),
    headquarters_phone_number  VARCHAR(255),
primary key (company_id)
);

ALTER TABLE companies
MODIFY column company_name VARCHAR(255) NOT NULL;

ALTER TABLE companies
MODIFY column company_name VARCHAR(255) NULL;

insert into companies (headquarters_phone_number)
values('+1 (202) 555-0196')
;

select * from companies;