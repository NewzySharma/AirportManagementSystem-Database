
/* AIRPORT MANAGEMENT SYSTEM*/


CREATE database airportmanagementsystem
CHARACTER SET utf8
COLLATE utf8_unicode_ci;


use airportmanagementsystem;



-- PRIVILIGES 

CREATE USER 'newzy'@'localhost'
IDENTIFIED BY 'newzy94';

CREATE USER 'bhagi'@'localhost'
IDENTIFIED BY 'bhagi18';

GRANT INSERT
ON airportmanagementsystem.EMPLOYEEDETAILS
TO 'newzy'@'localhost';

GRANT UPDATE
ON airportmanagementsystem.EMPLOYEEDETAILS
TO 'newzy'@'localhost';

GRANT DELETE
ON airportmanagementsystem.EMPLOYEEDETAILS
TO 'newzy'@'localhost';

GRANT SELECT
ON airportmanagementsystem.EMPLOYEEDETAILS
TO 'newzy'@'localhost';


GRANT SELECT
ON airportmanagementsystem.PASSENGERDETAILS
TO 'bhagi'@'localhost';

REVOKE SELECT
ON airportmanagementsystem.PASSENGERDETAILS
FROM 'bhagi'@'localhost';


CREATE TABLE CITY
(
CityName VARCHAR(15) NOT NULL,
STATE VARCHAR(15), 
COUNTRY VARCHAR(30),
PRIMARY KEY(CityName)
);


INSERT INTO CITY
VALUES
('Chandigarh','Chandigarh','India'),
('Delhi','Delhi','India'),
('Mumbai','Maharashtra','India'),
('Louisville','Kentucky','United States'),
('Boston','Massasuchetts','United States'),
('Fort Worth','Texas','United States'),
('San Francisco', 'California', 'United States'),
('Frankfurt','Hesse','Germany'),
('Houston','Texas','United States'),
('New York City','New York','United States'),
('Tampa', 'Florida', 'United States');


-- INDEX CREATION
CREATE FULLTEXT INDEX CityName_Index
ON AIRPORT(CityName);

CREATE TABLE AIRPORT
(
AirportName VARCHAR(100) NOT NULL,
STATE VARCHAR(15), 
COUNTRY VARCHAR(30),
CityName VARCHAR(15),
PRIMARY KEY(AirportName),
FOREIGN KEY(CityName) REFERENCES CITY(CityName) 
ON DELETE CASCADE
);

INSERT INTO AIRPORT
VALUES
('Chandigarh International Airport','Chandigarh','India','Chandigarh'),
('Indira GandhiInternational Airport','Delhi','India','Delhi'),
('Chhatrapati Shivaji International Airport','Maharashtra','India','Mumbai'),
('Louisville International Airport','Kentucky','United States','Louisville'),
('Logan International Airport' ,'Massasuchetts','United States','Boston'),
('Dallas/Fort Worth International Airport','Texas','United States','Fort Worth'),
('San Francisco International Airport','California', 'United States','San Francisco'),
('Frankfurt Airport','Hesse','Germany','Frankfurt'),
('George Bush Intercontinental Airport','Texas','United States','Houston'),
('John F. Kennedy International Airport','New York','United States','New York City'),
('Tampa International Airport','Florida', 'United States','Tampa');

CREATE TABLE AIRLINE
(
AirlineID VARCHAR(3) NOT NULL,
AirlineName VARCHAR(50),
ThreeDigitCode VARCHAR(3),
PRIMARY KEY(AirlineID)
);

INSERT INTO AIRLINE
VALUES
('AA','American Airlines','001'),
('AI','Air India Limited','098'),
('LH','Lufthansa', '209'),
('BA','British Airways','125'),
('QR','Qatar Airways','157'),
('9W','Jet Airways','222'),
('EK','Emirates','176'),
('EY','Ethiad Airways','607');


CREATE TABLE AIRPORTCONTAINSAIRLINES
(AirlineID VARCHAR(3) NOT NULL,
AirportName VARCHAR(100) NOT NULL,
PRIMARY KEY(AirlineID, AirportName),
FOREIGN KEY(AirlineID) REFERENCES AIRLINE(AirlineID) 
ON DELETE CASCADE,
FOREIGN KEY(AirportName) REFERENCES AIRPORT(AirportName) 
ON DELETE CASCADE
);

INSERT INTO AIRPORTCONTAINSAIRLINES
VALUES
('AA','Louisville International Airport'),
('AA','John F. Kennedy International Airport'),
('AA','George Bush Intercontinental Airport'),
('AA','San Francisco International Airport'),
('AA','Tampa International Airport'),

('AI','Chandigarh International Airport'),
('AI','Dallas/Fort Worth International Airport'),
('AI','Indira GandhiInternational Airport'),
('AI','Chhatrapati Shivaji International Airport'),
('AI','George Bush Intercontinental Airport'),

('LH','Chhatrapati Shivaji International Airport'),
('LH','Frankfurt Airport'),
('LH','John F. Kennedy International Airport'),
('LH','San Francisco International Airport'),
('LH','Dallas/Fort Worth International Airport'),

('BA','John F. Kennedy International Airport'),
('BA','Chhatrapati Shivaji International Airport'),
('BA','Chandigarh International Airport'),
('BA','Frankfurt Airport'),
('BA','San Francisco International Airport'),

('QR','Chhatrapati Shivaji International Airport'),
('QR','Dallas/Fort Worth International Airport'),
('QR','John F. Kennedy International Airport'),
('QR','Tampa International Airport'),
('QR','Louisville International Airport');



CREATE TABLE FLIGHT
(
FlightCode VARCHAR(10) NOT NULL,
SOURCE VARCHAR(3),
DESTINATION VARCHAR(3),
ARRIVAL VARCHAR(10),
DEPARTURE VARCHAR(10),
STATUS VARCHAR(10),
DURATION VARCHAR(30),
FlightType VARCHAR(10),
LayoverTime VARCHAR(30),
NoOfStops INT,
AirlineID VARCHAR(3),
PRIMARY KEY(FlightCode),
FOREIGN KEY(AirlineID) REFERENCES AIRLINE(AirlineID)
ON DELETE CASCADE
);


INSERT INTO FLIGHT
VALUES
('AI2014', 'BOM', 'DFW', '02:10', '03:15', 'On-time', '24hr', 'Connecting', 3, 1, 'AI'),
('QR2305', 'BOM', 'DFW', '13:00', '13:55', 'Delayed', '21hr', 'Non-stop', 0, 0, 'QR'),
('EY1234', 'JFK', 'TPA', '19:20', '20:05',' On-time',' 16hrs', 'Connecting', 5, 2, 'EY'),
('LH9876', 'JFK', 'BOM',' 05:50', '06:35', 'On-time', '18hrs', 'Non-stop', 0, 0, 'LH'),
('BA1689', 'FRA', 'DEL', '10:20', '10:55', 'On-time', '14hrs', 'Non-stop', 0, 0, 'BA'),
('AA4367', 'SFO', 'FRA', '18:10', '18:55', 'On-time', '21hrs', 'Non-stop' ,0 , 0,  'AA'),
('QR1902', 'IXC', 'IAH', '22:00' ,'22:50', 'Delayed',' 28hrs', 'Non-stop', 5, 1, 'QR'),
('BA3056', 'BOM', 'DFW', '02:15', '02:55', 'On-time', '29hrs', 'Connecting' ,3, 1, 'BA'),
('EK3456', 'BOM', 'SFO', '18:50', '19:40', 'On-time', '30hrs', 'Non-stop', 0, 0, 'EK'),
('9W2334','IAH','DEL','23:00','13:45','On-time','23hrs','Direct',0,0,'9W');


ALTER TABLE FLIGHT
ADD COLUMN DateOfTravel DATE ;

UPDATE  FLIGHT 
SET DateOfTravel = '2018-12-15'
where FlightCode = 'AI2014';

UPDATE  FLIGHT 
SET DateOfTravel = '2018-07-14'
where FlightCode = 'QR2305';

UPDATE  FLIGHT 
SET DateOfTravel = '2018-12-25'
where FlightCode = 'EY1234';


UPDATE  FLIGHT 
SET DateOfTravel = '2018-07-16'
where FlightCode = 'LH9876';

UPDATE  FLIGHT 
SET DateOfTravel = '2018-12-20'
where FlightCode = 'BA1689';

UPDATE  FLIGHT 
SET DateOfTravel = '2018-12-12'
where FlightCode = 'AA4367';


UPDATE  FLIGHT 
SET DateOfTravel = '2018-12-12'
where FlightCode = 'QR1902';


UPDATE  FLIGHT 
SET DateOfTravel = '2018-12-11'
where FlightCode = 'BA3056';

UPDATE  FLIGHT 
SET DateOfTravel = '2018-12-14'
where FlightCode = 'EK3456';

UPDATE  FLIGHT 
SET DateOfTravel = '2018-01-06'
where FlightCode = '9W2334';



CREATE TABLE EMPLOYEEDETAILS
(
SSN INT NOT NULL,
FName VARCHAR(20),
MName VARCHAR(1),
LName VARCHAR(20),
ADDRESS VARCHAR(100),
PHONE VARCHAR(10),
AGE INT,
SEX VARCHAR(1),
JobType VARCHAR(30),
Admintype VARCHAR(30),
EmployeeType VARCHAR(30),
AirportName VARCHAR(100),
PRIMARY KEY(SSN),
FOREIGN KEY(AirportName) REFERENCES AIRPORT(AirportName) 
ON DELETE CASCADE
);

-- INDEX CREATION
CREATE FULLTEXT INDEX Emplname_index
ON EMPLOYEEDETAILS(LName);

INSERT INTO EMPLOYEEDETAILS
VALUES
(123456789,'NEWZY','N','SHARMA','731 Fondren, Houston, TX',8578914638, 35, 'F','ADMINISTRATIVE SUPPORT', 'RECEPTIONIST','','Louisville International Airport'),
(333445555,'BHAGI','R','KUNDU','638 Voss, Houston, TX',8578914639, 40, 'F','ADMINISTRATIVE SUPPORT', 'SECRETARY','','Louisville International Airport'),
(999887777,'NEWZY','N','SHARMA','3321 Castle, Spring, TX',9834666995, 50, 'F','ENGINEER','','RADIO ENGINEER','Louisville International Airport'),
(987654321,'SHERLOCK','A','HOLMES','123 TOP HILL, SAN Francisco,CA',8089654321, 47, 'M','TRAFFIC MONITOR','','','San Francisco International Airport'),
(666884444,'SHELDON','A','COOPER','345 CHERRY PARK, HESSE,GERMANY',1254678903, 55, 'M','TRAFFIC MONITOR','','NIGHT','Frankfurt Airport'),
(453453453,'ROBIN','B','JOSHI','345 FLOYDS, MUMBAI,INDIA',4326789031, 35, 'M','AIRPORT AUTHORITY','','','Chhatrapati Shivaji International Airport'),
(987987987,'BHAVN','B','SHARMA','110 SYNERGY PARK, DALLAS,TX',5678904325, 33, 'M','ENGINEER','','AIRPORT CIVIL ENGINEER','Dallas/Fort Worth International Airport'),
(888665555,'SHUBHAM','R','GUPTA','567 CHANDANI CHOWK, DELHI, INDIA',8566778890, 39, 'M','ADMINISTRATIVE SUPPORT','DATA ENTRY WORKER','','Indira GandhiInternational Airport'),
(125478909,'PRATIK','T','GOMES','334 VITRUVIAN PARK, ALBANY, NY',4444678903, 56, 'M','TRAFFIC MONITOR','','DAY','John F. Kennedy International Airport'),
(324567897,'VIKAS','R','SINGH','987 SOMNATH, CHANDIGARH, INDIA',2244658909, 36, 'M','TRAFFIC MONITOR','','DAY','Chandigarh International Airport');


CREATE TABLE EMPLOYEESALARY
(
JobType VARCHAR(30) NOT NULL,
SALARY INT,
PRIMARY KEY(JobType)
);


INSERT INTO EMPLOYEESALARY
VALUES
('ADMINISTRATIVE SUPPORT',50000),
('ENGINEER',70000),
('TRAFFIC MONITOR',80000),
('AIRPORT AUTHORITY',90000);


CREATE TABLE PASSENGERDETAILS
(
PassportNumber VARCHAR(10) NOT NULL,
FName VARCHAR(20),
MName VARCHAR(1),
LName VARCHAR(20),        
ADDRESS VARCHAR(100),
PHONE VARCHAR(10),
AGE INT,
SEX VARCHAR(1),
PRIMARY KEY(PassportNumber)
);

-- INDEX CREATION
CREATE FULLTEXT INDEX FnameIndex
ON PASSENGERDETAILS(LName);

INSERT INTO PASSENGERDETAILS
VALUES
('A1234568','SHELLY','M','MADAN','2230 NORTHSIDE, APT 11, ALBANY, NY',8080367290,30,'F'),
('B9876541','RISHAV','V','SHARMA','3456 VIKAS APTS, APT 102,DOMBIVLI, INDIA',8080367280,26,'M'),
('C2345698','DEEPIKA','A','SINGH','7820 MCCALLUM COURTS, APT 234, AKRON, OH',8082267280,30,'F'),
('D1002004','NEETU','S','SAGAR','7720 MCCALLUM BLVD, APT 1082, DALLAS, TX',9080367266,23,'F'),
('X9324666','NEHA','B','GOYAL','9082 ESTAES OF RICHARDSON, RICHARDSON, TX',9004360125,28,'F'),
('B8765430','PARUL','P','MANOCHA','1110 FIR HILLS, APT 903, AKRON, OH',7666190505,30,'F'),
('J9801235','KUSHAL','D','MADAN','345 CHATHAM COURTS, APT 678, MUMBAI, INDIA',9080369290,29,'M'),
('A1122334','RINKAL','S','AGGARWAL','5589 CHTHAM REFLECTIONS, APT 349 HOUSTON, TX',9004335126,25,'F'),
('Q1243567','RANVEER','M','SINGH','4444 FRANKFORD VILLA, APT 77, GUILDERLAND, NY',9727626643,22,'M'),
('S1243269','HRITHIK','A','ROSHAN','7720 MCCALLUM BLVD, APT 2087, DALLAS, TX',9004568903,60,'M'),
('E3277889','SHAHID','A','KAPOOR','1234 BAKER APTS, APT 59, HESSE, GERMANY',9724569986,10,'M'),
('K3212322','ANUSHKA','B','SHARMA','6785 SPLITSVILLA, APT 34, MIAMI, FL',9024569226,15,'F'),
('P3452390','ANISHA','V','PAUDOKNE','548 MARKET PLACE, SAN Francisco, CA',9734567800,10,'F'),
('W7543336','JOHN','P','SMITH','6666 ROCK HILL, APT 2902, TAMPA, FL',4624569986,55,'M'),
('R8990566','VIVEK','T','SHARMA','3355 PALENCIA, APT 2065, MUMBAI, INDIA',4724512343,10,'M');


CREATE TABLE PASSENGER
(
PassangerID INT NOT NULL,
PassportNumber VARCHAR(10) NOT NULL,
PRIMARY KEY(PassangerID, PassportNumber)
);


INSERT INTO PASSENGER
VALUES
(1,'A1234568'),
(2,'B9876541'),
(3,'C2345698'),
(4,'D1002004'),
(5,'X9324666'),
(6,'B8765430'),
(7,'J9801235'),
(8,'A1122334'),
(9,'Q1243567'),
(10,'S1243269'),
(11,'E3277889'),
(12,'K3212322'),
(13,'P3452390'),
(14,'W7543336'),
(15,'R8990566');


CREATE TABLE PASSENGERFLIGHT
(
PassangerID INT NOT NULL,
FlightCode VARCHAR(10),
PRIMARY KEY(PassangerID),
FOREIGN KEY(FlightCode) REFERENCES FLIGHT(FlightCode) 
ON DELETE CASCADE
);


INSERT INTO PASSENGERFLIGHT
VALUES
(1,'AI2014'),
(2,'LH9876'),
(3,'9W2334'),
(4,'QR1902'),
(5,'EY1234'),
(6,'BA3056'),
(7,'9W2334'),
(8,'AA4367'),
(9,'QR1902'),
(10,'EK3456'),
(11,'BA1689'),
(12,'QR1902'),
(13,'AI2014'),
(14,'BA1689'),
(15,'QR2305');




CREATE TABLE TICKETDETAILS
(
TicketNumber VARCHAR(40) NOT NULL,
SOURCE VARCHAR(3),
DESTINATION VARCHAR(3),
DateOfBooking DATE,
DateOfCancellation DATE,
DateOfTravel DATE,
SeatNumber VARCHAR(5),
CLASS VARCHAR(15),
PassangerID INT,
PassportNumber VARCHAR(10),
FOREIGN KEY(PassangerID, PassportNumber) REFERENCES PASSENGER(PassangerID, PassportNumber) 
ON DELETE CASCADE
);


INSERT INTO TICKETDETAILS
VALUES
(0011234111122,'BOM','DFW','2018-05-11',null,'2018-12-15','32A','ECONOMY',1,'A1234568'),
(0984567222299,'JFK','BOM','2018-06-11','2018-07-04','2018-07-14','45D','ECONOMY',2,'B9876541'),
(1768901333273,'IAH','DEL','2018-08-16',null,'2018-12-25','1A','BUSINESS',3,'C2345698'),
(5890987441464,'IXC','IAH','2018-08-17',null,'2018-12-12','20C','FIRST-CLASS',4,'D1002004'),
(1577654664266,'JFK','TPA','2018-06-16',null,'2018-07-16','54E','ECONOMY',5,'X9324666'),
(2206543545545,'BOM','DFW','2018-11-16',null,'2018-12-20','43B','ECONOMY',6,'B8765430'),
(7064321779737,'IAH','DEL','2018-11-18',null,'2018-12-16','27B','FIRST-CLASS',7,'J9801235'),
(1571357215116,'SFO','FRA','2018-10-16',null,'2018-11-16','34E','ECONOMY',8,'A1122334'),
(1570864987655,'IXC','IAH','2018-11-16',null,'2018-11-26','54C','ECONOMY',9,'Q1243567'),
(1579283997799,'BOM','SFO','2018-01-02',null,'2018-02-02','38A','ECONOMY',10,'S1243269'),
(1255701876107,'FRA','DEL','2018-01-01',null,'2018-01-06','57F','ECONOMY',11,'E3277889'),
(1251334499699,'IXC','IAH','2018-11-02',null,'2018-11-27','45D','ECONOMY',12,'K3212322'),
(1258776199490,'BOM','DFW','2018-09-20','2018-12-14','2018-12-24','37C','ECONOMY',13,'P3452390'),
(5891155114477,'FRA','DEL','2018-01-06',null,'2018-01-18','55C','ECONOMY',14,'W7543336'),
(5893069766787,'BOM','DFW','2018-08-15',null,'2018-08-30','33F','ECONOMY',15,'R8990566');




CREATE TABLE TICKETBOOK
(
DateOfBooking DATE  NOT NULL,
SOURCE VARCHAR(3) NOT NULL,
DESTINATION VARCHAR(3) NOT NULL,
CLASS VARCHAR(15) NOT NULL,
PRICE INT,
PRIMARY KEY(DateOfBooking, SOURCE, DESTINATION, CLASS)
);

INSERT INTO TICKETBOOK
VALUES
('2018-05-11','BOM','DFW','ECONOMY',95000),
('2018-06-11','JFK','BOM','ECONOMY',100000),
('2018-08-16','IAH','DEL','BUSINESS',200000),
('2018-08-17','IXC','IAH','FIRST-CLASS',150000),
('2018-06-16','JFK','TPA','ECONOMY',98000),
('2018-11-16','BOM','DFW','ECONOMY',125000),
('2018-11-18','IAH','DEL','FIRST-CLASS',195000),
('2018-10-16','SFO','FRA','ECONOMY',170000),
('2018-11-16','IXC','IAH','ECONOMY',140000),
('2018-01-02','BOM','SFO','ECONOMY',45000),
('2018-01-01','FRA','DEL','ECONOMY',100000),
('2018-11-02','IXC','IAH','ECONOMY',120000),
('2018-09-20','BOM','DFW','ECONOMY',65000),
('2018-01-06','FRA','DEL','ECONOMY',80000),
('2018-08-15','BOM','DFW','ECONOMY',98000);


CREATE TABLE TICKETCANCEL
(
DateOfCancellation DATE NOT NULL,
CancellationCharges INT,
PRIMARY KEY(DateOfCancellation)
);


INSERT INTO TICKETCANCEL
VALUES
('2018-04-4',75000),
('2018-05-17',25000);


CREATE TABLE EMPLOYEESERVESPASSENGER
(SSN INT NOT NULL,
PassangerID INT NOT NULL,
PassportNumber VARCHAR(10) NOT NULL,
PRIMARY KEY(SSN, PassangerID, PassportNumber),
FOREIGN KEY(PassangerID, PassportNumber) REFERENCES PASSENGER(PassangerID, PassportNumber) ON DELETE CASCADE);


ALTER TABLE EMPLOYEESERVESPASSENGER 
ADD  FOREIGN  KEY(SSN) REFERENCES EMPLOYEEDETAILS(SSN);


-- View​​ Name: today_flight
-- Goal​​: This view is for the Airport Administrator Support (Help Desk). In this view employees can see all the relevant details of current date flight and inform the passengers.


CREATE VIEW today_flight
AS
SELECT FlightCode,AirlineName,SOURCE,DESTINATION,DEPARTURE,ARRIVAL
From FLIGHT 
INNER JOIN AIRLINE 
ON FLIGHT.AirlineID =AIRLINE.AirlineID
WHERE Flight.DateOfTravel = curdate()
ORDER BY SOURCE,DEPARTURE;

SELECT * FROM today_flight;


-- Stored procedure​​: get_passenger_details
-- Parameters​​: IN – passenger first name, IN – passenger last name, IN – airline name., IN – flight date
-- Goal​​: This is procedure is for the passengers to query flight details. 
--            They just need to give their first name, last name ,flight no & flight date and they will get all the details about their upcoming flight.

DELIMITER //

CREATE PROCEDURE get_passenger_details
(
IN fname VARCHAR(50) , lname VARCHAR(50), fcode VARCHAR(50))
BEGIN
		SELECT concat_ws(' ', pd.FName, pd.LName) as 'Passenger Name', f.FlightCode , f.AirlineID, f.SOURCE ,f.DESTINATION ,f.DEPARTURE, f.ARRIVAL
		FROM PASSENGERDETAILS pd
		INNER JOIN PASSENGER p
		ON pd.PassportNumber=  p.PassportNumber
		INNER JOIN PASSENGERFLIGHT pf
		ON pf.PassangerID = p.PassangerID
		INNER JOIN FLIGHT f
		ON pf.FlightCode = f.FlightCode
		INNER JOIN AIRLINE a
		ON f.AirlineID =a.AirlineID
		WHERE pd.FName = fname
        AND pd.LName =  lname
        AND f.FlightCode = fcode
        AND f.DateOfTravel = curdate() ;
       
END //

DELIMITER ; 


CALL  get_passenger_details ( 'Vivek', 'Sharma' ,'QR2306');

-- Stored procedure​​: get_flight_details
-- Parameters​​: 	IN alname ,IN src ,IN dest 
-- Goal​​: This is procedure is for the passengers to query flight details. 

DELIMITER //
CREATE PROCEDURE get_flight_details
(
	IN alname VARCHAR(50) ,
	src VARCHAR(50), 
	dest VARCHAR(50)
)
BEGIN
		SELECT al.AirlineName,f.SOURCE,f.DESTINATION,f.DEPARTURE,f.ARRIVAL
		From FLIGHT f
		INNER JOIN AIRLINE al
		ON f.AirlineID =al.AirlineID
		WHERE f.DateOfTravel = curdate()
		AND al.AirlineName = alname
		AND f.SOURCE = src
		AND f.DESTINATION = dest
		ORDER BY SOURCE,DEPARTURE;
END ; 
//

CALL  get_flight_details ( 'Qatar', 'BOM' ,'DFW');


-- Trigger, when flight is delayed it is logged into different table--

DELIMITER //
CREATE  TRIGGER DELAYEDFLIGHTS 
AFTER INSERT
 ON FLIGHT 
FOR EACH ROW 
BEGIN
       INSERT INTO DELAYEDFLIGHTS (FlightCode, SOURCE, DESTINATION , AirlineID ,ReportTime) 
       VALUES(new.FlightCode,new.source,new.DESTINATION,new.AirlineID,now());
END;
//


-- This is audit table for this trigger--
 CREATE TABLE DELAYEDFLIGHTS
   (           FlightCode VARCHAR(20), 
                DESTINATION VARCHAR(20), 
                SOURCE VARCHAR(20 ), 
                AirlineID VARCHAR(20), 
				ReportTime DATE
   );
   
 
INSERT INTO FLIGHT(FlightCode,
SOURCE,
DESTINATION ,
ARRIVAL ,
DEPARTURE ,
STATUS ,
DURATION ,
FlightType ,
LayoverTime ,
NoOfStops ,
AirlineID)
VALUES('AI127','BOM','DFW','02:10','03:15','Delayed','24hr','Connecting',3,1,'AI');

SELECT * FROM FLIGHT;
SELECT * FROM DELAYEDFLIGHTS;



-- TRIGGER TO UPDATE 'TICKET_PRICE_HISTORY' TABLE WHEN THE PRICE OF AN AIR TICKET IS UPDATED IN TICKET2 TABLE--

-- CREATING TABLE TICKET_PRICE_HISTORY--

CREATE TABLE TICKET_PRICE_HISTORY
(DateOfBooking DATE NOT NULL,
SOURCE VARCHAR(3) NOT NULL,
DESTINATION VARCHAR(3) NOT NULL,
CLASS VARCHAR(15) NOT NULL,
PRICE INT,
PRIMARY KEY(DateOfBooking, SOURCE, DESTINATION, CLASS));

-- CREATE A TRIGGER TICKET_PRICE_HISTORY --


DELIMITER //
CREATE  TRIGGER TICKET_PRICE_HISTORY
BEFORE UPDATE 
ON TICKETBOOK
FOR EACH ROW
BEGIN
INSERT INTO TICKET_PRICE_HISTORY 
VALUES(OLD.DateOfBooking, OLD.SOURCE, OLD.DESTINATION, OLD.CLASS,OLD.PRICE);
END;
//

-- LET'S UPDATE A PRICE OR FARE OF AN AIR TICKET --

UPDATE TICKETBOOK
SET PRICE=150000
WHERE DateOfBooking = '2018-11-11'
AND SOURCE='BOM'
AND DESTINATION='DFW'
AND CLASS='ECONOMY'



-- TRIGGER TO UPDATE SALARY OF AN EMPLOYEE DEPENDING ON JOBTYPE--
DELIMITER //
CREATE  TRIGGER UpdatedSalary 
AFTER
INSERT
ON EMPLOYEESALARY
FOR EACH ROW
BEGIN
		  CASE
					WHEN (JOBTYPE= 'Administrative Support') THEN
					  UPDATE EMPLOYEESALARY SET SALARY=SALARY+SALARY*.10;
					WHEN (JOBTYPE= 'ENGINEER') THEN
					  UPDATE EMPLOYEESALARY SET SALARY=SALARY+SALARY*.05;
					WHEN (JOBTYPE= 'TRAFFIC MONITOR') THEN
					  UPDATE EMPLOYEESALARY SET SALARY=SALARY+SALARY*.25;
					WHEN (JOBTYPE= 'AIRPORT AUTHORITY') THEN
					UPDATE EMPLOYEESALARY SET SALARY=SALARY+SALARY*.45;
		  END CASE;
END ;
//