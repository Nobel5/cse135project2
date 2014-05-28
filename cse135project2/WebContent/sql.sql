DROP TABLE users CASCADE;
DROP TABLE categories CASCADE;
DROP TABLE products CASCADE;
DROP TABLE sales CASCADE;


/**table 1: [entity] users**/
CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    role        TEXT NOT NULL,
    age   	INTEGER NOT NULL,
    state  	TEXT NOT NULL
);
INSERT INTO users (name, role, age, state) VALUES('CSE','owner',35,'California');
INSERT INTO users (name, role, age, state) VALUES('David','customer',33,'New York');
INSERT INTO users (name, role, age, state) VALUES('Floyd','customer',27,'Florida');
INSERT INTO users (name, role, age, state) VALUES('James','customer',55,'Texas');
INSERT INTO users (name, role, age, state) VALUES('Ross','customer',24,'Arizona');
SELECT * FROM  users  order by id asc limit 5;


/**table 2: [entity] category**/
CREATE TABLE categories (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    description TEXT
);
INSERT INTO categories (name, description) VALUES('Computers','A computer is a general purpose device that can be programmed to carry out a set of arithmetic or logical operations automatically. Since a sequence of operations can be readily changed, the computer can solve more than one kind of problem.');
INSERT INTO categories (name, description) VALUES('Cell Phones','A mobile phone (also known as a cellular phone, cell phone, and a hand phone) is a phone that can make and receive telephone calls over a radio link while moving around a wide geographic area. It does so by connecting to a cellular network provided by a mobile phone operator, allowing access to the public telephone network.');
INSERT INTO categories (name, description) VALUES('Cameras','A camera is an optical instrument that records images that can be stored directly, transmitted to another location, or both. These images may be still photographs or moving images such as videos or movies.');
INSERT INTO categories (name, description) VALUES('Video Games','A video game is an electronic game that involves human interaction with a user interface to generate visual feedback on a video device..');
SELECT * FROM categories order by id asc;

/**table 3: [entity] product**/
CREATE TABLE products (
    id          SERIAL PRIMARY KEY,
    cid         INTEGER REFERENCES categories (id) ON DELETE CASCADE,
    name        TEXT NOT NULL,
    SKU         TEXT NOT NULL UNIQUE,
    price       INTEGER NOT NULL
);
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'Apple MacBook',		'103001',	1200); /**1**/
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'HP Laptop',    		'106044',	480);
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'Dell Laptop',  		'109023',	399);/**3**/
INSERT INTO products (cid, name, SKU, price) VALUES(2, 'Iphone 5s',        	'200101',	709);
INSERT INTO products (cid, name, SKU, price) VALUES(2, 'Samsung Galaxy S4',	'208809',	488);/**5**/
INSERT INTO products (cid, name, SKU, price) VALUES(2, 'LG Optimus g',    	 '209937',	375);
INSERT INTO products (cid, name, SKU, price) VALUES(3, 'Sony DSC-RX100M',	'301211',	689);/**7**/
INSERT INTO products (cid, name, SKU, price) VALUES(3, 'Canon EOS Rebel T3', 	 '304545',	449);
INSERT INTO products (cid, name, SKU, price) VALUES(3, 'Nikon D3100',  		'308898',	520);
INSERT INTO products (cid, name, SKU, price) VALUES(4, 'Xbox 360',  		'405065',	249);/**10**/
INSERT INTO products (cid, name, SKU, price) VALUES(4, 'Nintendo Wii U ', 	 '407033',	430);
INSERT INTO products (cid, name, SKU, price) VALUES(4, 'Nintendo Wii',  	'408076',	232);
SELECT * FROM products order by id asc limit 10;



/**table 4: [relation] carts**/
CREATE TABLE sales (
    id          SERIAL PRIMARY KEY,
    uid         INTEGER REFERENCES users (id) ON DELETE CASCADE,
    pid         INTEGER REFERENCES products (id) ON DELETE CASCADE,
    quantity    INTEGER NOT NULL,
    price	INTEGER NOT NULL
);
INSERT INTO sales (uid, pid, quantity, price) VALUES(3, 1 , 2, 1200);
INSERT INTO sales (uid, pid, quantity, price) VALUES(3, 2 , 1, 480);
INSERT INTO sales (uid, pid, quantity, price) VALUES(4, 10, 4, 249);
INSERT INTO sales (uid, pid, quantity, price) VALUES(5, 12, 2, 232);
INSERT INTO sales (uid, pid, quantity, price) VALUES(5, 9 , 5, 520);
INSERT INTO sales (uid, pid, quantity, price) VALUES(5, 5 , 3, 488);
INSERT INTO sales (uid, pid, quantity, price) VALUES(5, 1, 1, 1200);

CREATE TABLE carts (
    id          SERIAL PRIMARY KEY,
    uid         INTEGER REFERENCES users (id) ON DELETE CASCADE,
    pid         INTEGER REFERENCES products (id) ON DELETE CASCADE,
    quantity    INTEGER NOT NULL,
    price	INTEGER NOT NULL
);

DROP TABLE IF EXISTS states;
CREATE TABLE states(id SERIAL PRIMARY KEY, name TEXT);
insert into states(name) values ('Alabama');
insert into states(name) values ('Alaska');
insert into states(name) values ('Arizona');
insert into states(name) values ('Arkansas');
insert into states(name) values ('California');
insert into states(name) values ('Colorado');
insert into states(name) values ('Connecticut');
insert into states(name) values ('Delaware');
insert into states(name) values ('District of Columbia');
insert into states(name) values ('Florida');
insert into states(name) values ('Georgia');
insert into states(name) values ('Hawaii');
insert into states(name) values ('Idaho');
insert into states(name) values ('Illinois');
insert into states(name) values ('Indiana');
insert into states(name) values ('Iowa');
insert into states(name) values ('Kansas');
insert into states(name) values ('Kentucky');
insert into states(name) values ('Louisiana');
insert into states(name) values ('Maine');
insert into states(name) values ('Maryland');
insert into states(name) values ('Massachusetts');
insert into states(name) values ('Michigan');
insert into states(name) values ('Minnesota');
insert into states(name) values ('Mississippi');
insert into states(name) values ('Missouri');
insert into states(name) values ('Montana');
insert into states(name) values ('Nebraska');
insert into states(name) values ('Nevada');
insert into states(name) values ('New Hampshire');
insert into states(name) values ('New Jersey');
insert into states(name) values ('New Mexico');
insert into states(name) values ('New York');
insert into states(name) values ('North Carolina');
insert into states(name) values ('North Dakota');
insert into states(name) values ('Ohio');
insert into states(name) values ('Oklahoma');
insert into states(name) values ('Oregon');
insert into states(name) values ('Pennsylvania');
insert into states(name) values ('Rhode Island');
insert into states(name) values ('South Carolina');
insert into states(name) values ('South Dakota');
insert into states(name) values ('Tennessee');
insert into states(name) values ('Texas');
insert into states(name) values ('Utah');
insert into states(name) values ('Vermont');
insert into states(name) values ('Virginia');
insert into states(name) values ('Washington');
insert into states(name) values ('West Virginia');
insert into states(name) values ('Wisconsin');
insert into states(name) values ('Wyoming');

SELECT * FROM sales order by id desc;