Use petrolpump ; 

CREATE TABLE Pumpdata(
Pump_ID int primary key , 
PetrolPump_Name char(100), 
Location char(50),
Owner_name char(100),
Contact_info bigint ,
Operating_hrs time 
) ; 

INSERT INTO Pumpdata (Pump_ID, PetrolPump_Name, Location, Owner_name, Contact_info, Operating_hrs) VALUES
(101,'ABC Fuel', 'Jabalpur', 'Ravi Sharma', 9826000001, '07:00:00'),
(102,'XYZ Petroleum', 'Katni', 'Meena Kumari', 9826000002, '06:30:00'),
(103,'SpeedWay Fuel', 'Sagar', 'Arun Tiwari', 9826000003, '08:00:00'),
(104,'Highway Pumps', 'Damoh', 'Ritu Singh', 9826000004, '07:30:00'),
(105,'Bharat Filling Station', 'Chhindwara', 'Vikram Jain', 9826000005, '06:45:00');

SELECT * from Pumpdata ; 
