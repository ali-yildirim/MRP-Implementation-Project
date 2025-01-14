drop DATABASE if exists data_base;

CREATE DATABASE data_base;

USE data_base;

CREATE TABLE item ( item_id VARCHAR(16) PRIMARY KEY,
                    item_name VARCHAR(96),
                    lot_size INT NOT NULL,
                    lead_time INT NOT NULL,
                    inventory INT NOT NULL);

INSERT INTO item (item_id, item_name, lot_size, lead_time, inventory)
VALUES  ("001", "Trumpet", 1, 2, 3),
        ("002", "Valve Casing Assembly", 10, 4, 4),
        ("003", "Bell Assembly", 10, 2, 5),
        ("004", "Slide Assemblies", 20, 2, 6),
        ("005", "Valves", 30, 3, 7);

CREATE TABLE bom (  item_id VARCHAR(16),
                    component_id VARCHAR(16),
                    bom_multiplier INT NOT NULL,
                    PRIMARY KEY (item_id, component_id));

INSERT INTO bom (item_id, component_id, bom_multiplier)
VALUES  ("001", "002", 1),
        ("001", "003", 1),
        ("002", "004", 3),
        ("002", "005", 3);                  

CREATE TABLE master_schedule (  item_id VARCHAR(16),
                            period_number INT,
                            gross_requirements INT,
                            scheduled_receipts INT,
                            projected_inventory INT,
                            net_requirements INT,
                            planned_order_receipts INT,
                            planned_order_releases INT,
                            PRIMARY KEY (item_id, period_number));

INSERT INTO master_schedule (   item_id, period_number, gross_requirements, scheduled_receipts,
                            projected_inventory, net_requirements, planned_order_receipts,
                            planned_order_releases)
VALUES  ("001", 0, 0, 0, 3, 0, 0, 0),         
        ("001", 1, 0, 0, 0, 0, 0, 0),       
        ("001", 2, 0, 0, 0, 0, 0, 0),
        ("001", 3, 0, 0, 0, 0, 0, 0),
        ("001", 4, 0, 0, 0, 0, 0, 0),
        ("001", 5, 0, 0, 0, 0, 0, 0),
        ("001", 6, 0, 0, 0, 0, 0, 0),
        ("001", 7, 0, 0, 0, 0, 0, 0),
        ("001", 8, 0, 0, 0, 0, 0, 0),
        ("001", 9, 0, 0, 0, 0, 0, 0),
        ("001", 10, 0, 0, 0, 0, 0, 0),
        ("001", 11, 0, 0, 0, 0, 0, 0),
        ("001", 12, 0, 0, 0, 0, 0, 0),
        ("002", 0, 0, 0, 4, 0, 0, 0),         
        ("002", 1, 0, 0, 0, 0, 0, 0),       
        ("002", 2, 0, 0, 0, 0, 0, 0),
        ("002", 3, 0, 0, 0, 0, 0, 0),
        ("002", 4, 0, 0, 0, 0, 0, 0),
        ("002", 5, 0, 0, 0, 0, 0, 0),
        ("002", 6, 0, 0, 0, 0, 0, 0),
        ("002", 7, 0, 0, 0, 0, 0, 0),
        ("002", 8, 0, 0, 0, 0, 0, 0),
        ("002", 9, 0, 0, 0, 0, 0, 0),
        ("002", 10, 0, 0, 0, 0, 0, 0),
        ("002", 11, 0, 0, 0, 0, 0, 0),
        ("002", 12, 0, 0, 0, 0, 0, 0),
        ("003", 0, 0, 0, 5, 0, 0, 0),         
		("003", 1, 0, 0, 0, 0, 0, 0),       
		("003", 2, 0, 0, 0, 0, 0, 0),
		("003", 3, 0, 0, 0, 0, 0, 0),
		("003", 4, 0, 0, 0, 0, 0, 0),
		("003", 5, 0, 0, 0, 0, 0, 0),
		("003", 6, 0, 0, 0, 0, 0, 0),
		("003", 7, 0, 0, 0, 0, 0, 0),
		("003", 8, 0, 0, 0, 0, 0, 0),
		("003", 9, 0, 0, 0, 0, 0, 0),
		("003", 10, 0, 0, 0, 0, 0, 0),
		("003", 11, 0, 0, 0, 0, 0, 0),
		("003", 12, 0, 0, 0, 0, 0, 0),
        ("004", 0, 0, 0, 6, 0, 0, 0),         
		("004", 1, 0, 0, 0, 0, 0, 0),       
		("004", 2, 0, 0, 0, 0, 0, 0),
		("004", 3, 0, 0, 0, 0, 0, 0),
		("004", 4, 0, 0, 0, 0, 0, 0),
		("004", 5, 0, 0, 0, 0, 0, 0),
		("004", 6, 0, 0, 0, 0, 0, 0),
		("004", 7, 0, 0, 0, 0, 0, 0),
		("004", 8, 0, 0, 0, 0, 0, 0),
		("004", 9, 0, 0, 0, 0, 0, 0),
		("004", 10, 0, 0, 0, 0, 0, 0),
		("004", 11, 0, 0, 0, 0, 0, 0),
		("004", 12, 0, 0, 0, 0, 0, 0),
        ("005", 0, 0, 0, 7, 0, 0, 0),         
		("005", 1, 0, 0, 0, 0, 0, 0),       
		("005", 2, 0, 0, 0, 0, 0, 0),
		("005", 3, 0, 0, 0, 0, 0, 0),
		("005", 4, 0, 0, 0, 0, 0, 0),
		("005", 5, 0, 0, 0, 0, 0, 0),
		("005", 6, 0, 0, 0, 0, 0, 0),
		("005", 7, 0, 0, 0, 0, 0, 0),
		("005", 8, 0, 0, 0, 0, 0, 0),
		("005", 9, 0, 0, 0, 0, 0, 0),
		("005", 10, 0, 0, 0, 0, 0, 0),
		("005", 11, 0, 0, 0, 0, 0, 0),
		("005", 12, 0, 0, 0, 0, 0, 0);

CREATE TABLE orders (   order_id VARCHAR(16) PRIMARY KEY,
                        period_number INT NOT NULL,
                        item_id VARCHAR(16) NOT NULL,
                        amount INT NOT NULL,
                        order_date DATETIME);

CREATE TABLE periods (  period_number INT PRIMARY KEY,
                        start_date DATE,
                        end_date DATE);

INSERT INTO periods (period_number)
VALUES  (1), (2), (3), (4), (5), (6),
        (7), (8), (9), (10), (11), (12);

