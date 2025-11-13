create database Supplier_database;
use supplier_database;
CREATE TABLE Supplier (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Parts (
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost DECIMAL(10,2),
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Supplier(sid),
    FOREIGN KEY (pid) REFERENCES Parts(pid)
);



INSERT INTO Supplier VALUES
(1, 'Acme Widget Suppliers', 'London'),
(2, 'Best Parts Co', 'Paris'),
(3, 'Global Supplies', 'New York');

select * from Supplier;

INSERT INTO Parts VALUES
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Green'),
(103, 'Screw', 'Red'),
(104, 'Washer', 'Blue');
select * from Parts;


INSERT INTO Catalog VALUES
(1, 101, 12.50),
(1, 102, 14.00),
(2, 101, 10.00),
(2, 103, 15.50),
(3, 101, 11.00),
(3, 104, 16.00);

INSERT INTO Catalog VALUES
(1, 103, 15.00),
(1, 104, 17.00);


select * from Catalog;

SELECT DISTINCT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid;

SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM Parts p
    WHERE p.pid NOT IN (
        SELECT c.pid FROM Catalog c WHERE c.sid = s.sid
    )
);

SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM Parts p
    WHERE p.color = 'Red'
    AND p.pid NOT IN (
        SELECT c.pid FROM Catalog c WHERE c.sid = s.sid
    )
);

SELECT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
JOIN Supplier s ON s.sid = c.sid
WHERE s.sname = 'Acme Widget Suppliers'
AND p.pid NOT IN (
    SELECT c2.pid
    FROM Catalog c2
    JOIN Supplier s2 ON s2.sid = c2.sid
    WHERE s2.sname <> 'Acme Widget Suppliers'
);

SELECT DISTINCT s.sname
FROM Supplier s
JOIN Catalog c ON s.sid = c.sid
WHERE c.cost > (
    SELECT AVG(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = c.pid
);




                                                             





