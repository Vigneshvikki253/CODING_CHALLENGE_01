create database coding
use coding
--Creating Tables
CREATE TABLE Crime (
 CrimeID INT PRIMARY KEY,
 IncidentType VARCHAR(255),
 IncidentDate DATE,
 Location VARCHAR(255),
 Description TEXT,
 Status VARCHAR(20)
);CREATE TABLE Victim (
 VictimID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 ContactInfo VARCHAR(255),
 Injuries VARCHAR(255),
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);CREATE TABLE Suspect (
 SuspectID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 Description TEXT,
 CriminalHistory TEXT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);-- Insert sample data
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
 (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
 (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under
Investigation'),
 (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed'); INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
 (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
 (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
 (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');

 INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
 (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
 (2, 2, 'Unknown', 'Investigation ongoing', NULL),
 (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');

 -- 1. Select all open incidents
 select * from Crime where Status='Open'

 -- 2. Find the total number of incidents.
 select count(*) as No_of_Incidents from Crime

 -- 3. List all unique incident types.
 select distinct IncidentType from Crime

 -- 4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.
 select * from Crime
 where IncidentDate between '2023-09-01' and '2023-09-10'

 --Adding age column
 alter table Suspect add age int
 alter table Victim add age int
 update Victim set age=20 where VictimID=1
 update Victim set age=30 where VictimID=2
 update Victim set age=40 where VictimID=3

 update Suspect set age=30 where SuspectID=1
 update Suspect set age=40 where SuspectID=2
 update Suspect set age=50 where SuspectID=3   select * from Suspect
 
 -- 5. List persons involved in incidents in descending order of age.
 select s.Name,s.age,v.Name from Suspect as s
 join Victim v on s.CrimeID=v.CrimeID
 order by s.age desc

 -- 6. Find the average age of persons involved in incidents.
 select avg(age) as AVG_AGE 
 from(select age from Suspect union all select age from Victim)People_invloved

 -- 7. List incident types and their counts, only for open cases.
 select IncidentType ,count(*)as Incident_count 
 from Crime
 where Status='Open'
 group by IncidentType

 -- 8. Find persons with names containing 'Doe'.
 select name from Suspect where name like '%Doe%'
 union all
 select name from Victim where name like '%Doe%'

 -- 9. Retrieve the names of persons involved in open cases and closed cases
 select v.name as Victim_name,s.name as Suspect_name,c.Status
 from Victim v
join Suspect s on v.CrimeID=s.CrimeID
join Crime c on v.CrimeID=c.CrimeID
where c.Status in ('Open','Closed')

-- 10. List incident types where there are persons aged 30 or 35 involved
select c.IncidentType
from Crime c
join Victim v on c.CrimeID=v.CrimeID
join Suspect s on s.CrimeID=c.CrimeID
where s.age>=30 and s.age<=35 or v.age>=30 and v.age<=30

-- 11. Find persons involved in incidents of the same type as 'Robbery'.
select v.name as Victim_name,s.name as Suspect_name
from Victim v
join Suspect s on v.CrimeID=s.CrimeID
join Crime c on c.CrimeID=v.CrimeID
where c.IncidentType='Robbery'

--inserting
INSERT INTO Crime 
VALUES
 (4, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at an ammunition store', 'Open')
 INSERT INTO Victim 
VALUES
 (4, 4, 'Mary Doe', 'johndoe@example.com', 'Minor injuries',40)
  INSERT INTO Suspect 
VALUES
 (4, 4, 'Robber 2', 'Armed and masked robber', 'Previous robbery convictions',50)


-- 12. List incident types with more than one open case.
select IncidentType,count(*) as Incident_count from Crime
where Status='Open'
group by IncidentType
having count(*)>1

--inserting
INSERT INTO Crime 
VALUES
 (5, 'Robbery', '2023-09-15', '125 Main St, Cityville', 'Armed robbery at a jewellery store', 'Open')
 INSERT INTO Victim 
VALUES
 (5, 5, 'Robber 2', 'johndoe@example.com', 'Minor injuries',50)
  INSERT INTO Suspect 
VALUES
 (5, 5, 'Mary Doe', 'Armed and masked ', 'victim in previous case',40)

-- 13. List all incidents with suspects whose names also appear as victims in other incidents.
select IncidentDate,IncidentType,Location,c.Description,Status from Crime c
join Suspect s on s.CrimeID=c.CrimeID
where s.name in(select name from Victim)
------------
update Crime set Location='128 Main St, Cityville' where CrimeID=4;
-- 14. Retrieve all incidents along with victim and suspect details.
select v.name as Victim_name,s.name as Suspect_name,c.IncidentDate,c.IncidentType,c.Location,c.Description,c.Status
from Crime c
join Victim v on v.CrimeID=c.CrimeID
join Suspect s on s.CrimeID=c.CrimeID

-- 15. Find incidents where the suspect is older than any victim.
select v.name as Victim_name,s.name as Suspect_name,c.IncidentDate,c.IncidentType,c.Location,
c.Description,c.Status,s.age as Suspect_age,v.age as Victim_age
from Crime c
join Victim v on v.CrimeID=c.CrimeID
join Suspect s on s.CrimeID=c.CrimeID
where s.age>v.age
--inserting
INSERT INTO Crime 
VALUES
 (6, 'Robbery', '2023-09-16', '129 Main St, Cityville', 'Armed robbery at a chemical store', 'Open')
 INSERT INTO Victim 
VALUES
 (6, 6, 'Mary Doe', 'marydoe@example.com', 'Minor injuries',40)
  INSERT INTO Suspect 
VALUES
 (6, 6, 'Robber 2', 'Armed and masked robber', 'Previous robbery convictions',50)
-- 16. Find suspects involved in multiple incidents.
select name as Suspect_name from Suspect
group by name
having count(*)>1

-- 17. List incidents with no suspects involved.
select v.name as Victim_name,c.IncidentDate,c.IncidentType,c.Location,c.Description
from Crime c
join Victim v on v.CrimeID=c.CrimeID
join Suspect s on s.CrimeID=c.CrimeID
where s.name='Unknown'

-- 18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.
SELECT c.*
from Crime c
where exists (select 1 from Crime where IncidentType = 'Homicide')
and not exists (select 1 from Crime where IncidentType not in ('Homicide', 'Robbery'));

---trying to alter tables to get a result
select*from Crime
--replacing theft with homicide to satisy the query
update Crime set IncidentType='Homicide' where CrimeID=3
--running the 18th query provides output now ,so reversing the changes as per provided schema
update Crime set IncidentType='Theft' where CrimeID=3


-- 19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.
--using case since the suspect is filled as 'Unknown' instead of NULL.
select c.IncidentDate,c.IncidentType,c.Location,
c.Description,c.Status,
case when s.name='Unknown' then 'No Suspect' else s.name end
as Suspect_name
from Crime c
join Suspect s on s.CrimeID=c.CrimeID

-- 20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'.
select distinct s.name as Suspect_Name from Suspect s
join Crime c on c.CrimeID=s.CrimeID
where c.IncidentType in('Robbery','Assault')
