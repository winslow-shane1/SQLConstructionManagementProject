-- --------------------------------------------------------------------------------
-- Name: Shane Winslow
-- Class: IT-111
-- Abstract: Fixinyerleaks, LLC Database 
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbFixinyerleak;	-- Get out of the master database
SET NOCOUNT ON;			-- Report only errors

-- uspCleanDatabase

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID( 'TPlumbersSkills' )	IS NOT NULL DROP TABLE TPlumbersSkills
IF OBJECT_ID( 'TJobsPlumbers' )		IS NOT NULL DROP TABLE TJobsPlumbers
IF OBJECT_ID( 'TMaterialsVendors' )	IS NOT NULL DROP TABLE TMaterialsVendors
IF OBJECT_ID( 'TJobsMaterials' )	IS NOT NULL DROP TABLE TJobsMaterials
IF OBJECT_ID( 'TJobs' )				IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID( 'TVendors' )			IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID( 'TMaterials')			IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID( 'TJobStatus' )		IS NOT NULL DROP TABLE TJobStatus
IF OBJECT_ID( 'TCustomers' )		IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID( 'TPlumbers' )			IS NOT NULL DROP TABLE TPlumbers
IF OBJECT_ID( 'TSkills' )			IS NOT NULL DROP TABLE TSkills

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TPlumbersSkills
(
	 sintPlumberSkillID					SMALLINT		NOT NULL
	,sintPlumberID						SMALLINT		NOT NULL
	,sintSkillID						SMALLINT		NOT NULL
	,CONSTRAINT TPlumbersSkills_PK PRIMARY KEY ( sintPlumberSkillID )
)

CREATE TABLE TJobsPlumbers
(
	 sintJobPlumberID					SMALLINT		NOT NULL
	,sintJobID							SMALLINT		NOT NULL
	,sintPlumberID						SMALLINT		NOT NULL
	,realHoursWorked					REAL			NOT NULL
	,CONSTRAINT TJobsPlumbers_PK PRIMARY KEY ( sintJobPlumberID )
)

CREATE TABLE TMaterialsVendors
(
	 sintMaterialVendorID				SMALLINT		NOT NULL
	,sintMaterialID						SMALLINT		NOT NULL
	,sintVendorID						SMALLINT		NOT NULL
	,monCostPerUnit						MONEY			NOT NULL
	,CONSTRAINT TMaterialsVendors_PK PRIMARY KEY (  sintMaterialVendorID )
)

CREATE TABLE TJobsMaterials
(						
	 sintJobMaterialID					SMALLINT		NOT NULL
	,sintJobID							SMALLINT		NOT NULL
	,sintMaterialID						SMALLINT		NOT NULL
	,sintMaterialAmt					SMALLINT		NOT NULL
	,CONSTRAINT TJobsMaterials_PK PRIMARY KEY ( sintJobMaterialID )
)

CREATE TABLE TJobs
(						
	 sintJobID							SMALLINT		NOT NULL
	,sintCustomerID						SMALLINT		NOT NULL
	,strJobDesc							VARCHAR(2000)	NOT NULL
	,sintJobStatusID					SMALLINT		NOT NULL
	,dteStartDate						DATE			NOT NULL
	,dteEndDate							DATE			NOT NULL
	,CONSTRAINT TJobs_PK PRIMARY KEY ( sintJobID )
)

CREATE TABLE TVendors
(						
	 sintVendorID						SMALLINT		NOT NULL
	,strVendorName						VARCHAR(255)	NOT NULL
	,strVendorAddress					VARCHAR(255)	NOT NULL
	,CONSTRAINT TVendors_PK PRIMARY KEY ( sintVendorID )
)

CREATE TABLE TMaterials
(
	 sintMaterialID						SMALLINT		NOT NULL
	,strMaterialType					VARCHAR(255)	NOT NULL
	,CONSTRAINT TMaterials_PK PRIMARY KEY ( sintMaterialID )
)

CREATE TABLE TJobStatus
(
	 sintJobStatusID					SMALLINT		NOT NULL
	,strStatus							VARCHAR(255)	NOT NULL
	,CONSTRAINT TJobStatus_PK PRIMARY KEY ( sintJobStatusID )
)

CREATE TABLE TCustomers
(
	 sintCustomerID						SMALLINT		NOT NULL
	,strFirstName						VARCHAR(255)	NOT NULL
	,strLastName						VARCHAR(255)	NOT NULL
	,strAddress							VARCHAR(255)	NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( sintCustomerID )
)

CREATE TABLE TPlumbers 
(
	 sintPlumberID						SMALLINT		NOT NULL
	,strFirstName						VARCHAR(255)	NOT NULL
	,strLastName						VARCHAR(255)	NOT NULL
	,dteHireDate						DATE			NOT NULL
	,monHourlyRate						MONEY			NOT NULL
	,CONSTRAINT TPlumbers_PK PRIMARY KEY ( sintPlumberID )
)

CREATE TABLE TSkills
(
	 sintSkillID						SMALLINT		NOT NULL
	,strSkill							VARCHAR(255)	NOT NULL
	,CONSTRAINT TSkills_PK PRIMARY KEY ( sintSkillID )
)


-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child										Parent							Column(s)
-- -	-----										------							---------
-- 1	TPlumbersSkills								TSkills							sintSkillID   --
-- 2	TPlumbersSkills								TPlumbers						sintPlumberID --
-- 3	TJobsPlumbers								TPlumbers						sintPlumberID --
-- 4	TJobsPlumbers								TJobs							sintJobID --
-- 5	TJobs										TCustomers						sintCustomerID --
-- 6	TJobs										TJobStatus						sintJobStatusID --
-- 7	TJobsMaterials								TMaterials						sintMaterialID --
-- 8	TJobsMaterials								TJobs							sintJobID --
-- 9	TMaterialsVendors							TMaterials						sintMaterialID --
-- 10	TMaterialsVendors							TVendors						sintVendorID --

-- 1
ALTER TABLE TPlumbersSkills ADD CONSTRAINT TPlumbersSkills_TSkills_FK
FOREIGN KEY ( sintSkillID ) REFERENCES TSkills ( sintSkillID )

-- 2
ALTER TABLE TPlumbersSkills ADD CONSTRAINT TPlumbersSkills_TPlumbers_FK
FOREIGN KEY ( sintPlumberID ) REFERENCES TPlumbers ( sintPlumberID )

-- 3
ALTER TABLE TJobsPlumbers ADD CONSTRAINT TJobsPlumbers_TPlumbers_FK
FOREIGN KEY ( sintPlumberID ) REFERENCES TPlumbers ( sintPlumberID )

-- 4
ALTER TABLE TJobsPlumbers ADD CONSTRAINT TJobsPlumbers_TJobs_FK
FOREIGN KEY ( sintJobID ) REFERENCES TJobs ( sintJobID )

-- 5
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
FOREIGN KEY ( sintCustomerID ) REFERENCES TCustomers ( sintCustomerID )

-- 6
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TJobStatus_FK
FOREIGN KEY ( sintJobStatusID ) REFERENCES TJobStatus( sintJobStatusID )

-- 7
ALTER TABLE TJobsMaterials ADD CONSTRAINT TJobsMaterials_TMaterials_FK
FOREIGN KEY ( sintMaterialID ) REFERENCES TMaterials ( sintMaterialID )

-- 8
ALTER TABLE TJobsMaterials ADD CONSTRAINT TJobsMaterials_TJobs_FK
FOREIGN KEY ( sintJobID ) REFERENCES TJobs ( sintJobID )

-- 9
ALTER TABLE TMaterialsVendors ADD CONSTRAINT TMaterialsVendors_TMaterials_FK
FOREIGN KEY ( sintMaterialID ) REFERENCES TMaterials (sintMaterialID )

-- 10
ALTER TABLE TMaterialsVendors ADD CONSTRAINT TMaterialsVendors_TVendors_FK
FOREIGN KEY ( sintVendorID ) REFERENCES TVendors ( sintVendorID )

-- --------------------------------------------------------------------------------
-- Add Records into Skills
-- --------------------------------------------------------------------------------
INSERT INTO TSkills ( sintSkillID, strSkill )
VALUES	 ( 1, 'Toilet Installation' )
		,( 2, 'Sink Installation' )
		,( 3, 'Pipe Fitting' )
		,( 4, 'Sewer Connections' )
		,( 5, 'Underground Piping' )
		,( 6, 'Water Intake' )

-- --------------------------------------------------------------------------------
-- Add Records into Plumbers
-- --------------------------------------------------------------------------------

INSERT INTO TPlumbers ( sintPlumberID, strFirstName, strLastName, dteHireDate, monHourlyRate )
VALUES	 ( 1, 'Keith', 'LeVine', '01/13/2010', 25.50 )
		,(2, 'Mary Lou', 'Stevenson', '02/23/2020', 20.00)
		,(3, 'John', 'Kettering', '05/06/2013', 27.00)
		,(4, 'Kevin', 'Bacon', '07/07/2018', 19.00)
		,(5, 'Roselynn', 'Montgomery', '07/02/2014', 31.00)
		,(6, 'Anton', 'McGovern', '06/29/2020', 21.00)

-- --------------------------------------------------------------------------------
-- Add Records into Customers
-- --------------------------------------------------------------------------------
INSERT INTO TCustomers ( sintCustomerID, strFirstName, strLastName, strAddress )
VALUES	 ( 1, 'Bob', 'Nields', '8741 Rosebrook Drive, Florence, KY 41042')
		,( 2, 'Terry', 'Grosse', '389 Kenton Way, Alexandria, KY 45248')
		,( 3, 'Ashton', 'Stervont', '993 Kale Street, Cincinnati, OH 43893')
		,( 4, 'Renee', 'Sweeney', '2928 Rampart Court, Mason, OH 23930')
		,( 5, 'Tim', 'Burton', '3293 Heaverit Place, Ross, IN 39220')
		,( 6, 'Klye', 'Renner', '234 Cantankerous Way, Haveford, OH 38493')
		,( 7, 'Kylie', 'Jooper', '345 Main Street, Trent, OH 34430')
		,( 8, 'Lawrence', 'Fishburn', '34 Main Street, Ross, OH 34903')
		,( 9, 'Sammy', 'Davis', '87 Main Street, Razamajazz, OH 98344')
		
-- --------------------------------------------------------------------------------
-- Add Records into Job Status
-- --------------------------------------------------------------------------------

INSERT INTO TJobStatus ( sintJobStatusID, strStatus )
VALUES	 ( 1, 'Open' )
		,( 2, 'In Process' )
		,( 3, 'Complete' )

-- --------------------------------------------------------------------------------
-- Add Records into Materials
-- --------------------------------------------------------------------------------

INSERT INTO TMaterials ( sintMaterialID, strMaterialType )
VALUES	 ( 1, 'Concrete' )
		,( 2, 'PVC Pipes' )	
		,( 3, 'Metal Pipes' )
		,( 4, 'Caulk' )
		,( 5, 'Ceramic Glue' )
		,( 6, 'Nuts' )
		,( 7, 'Bolts' )
		,( 8, 'Washers' )
 

-- --------------------------------------------------------------------------------
-- Add Records into Vendors
-- --------------------------------------------------------------------------------

INSERT INTO TVendors ( sintVendorID, strVendorName, strVendorAddress )
VALUES	 ( 1, 'PVCS R US', '14 Flank Street, Columbia, NY 45602' )
		,( 2, 'We Sell Pipes', '3490 Torrilla Lane, Yuton, MA 34304' )
		,( 3, 'FlushemDown', '84 Waterworks Way, Tikkal, FL 95895' )
		,( 4, 'Wash-it-well', '894 Erasmus Drive, Cavers, KY 38293' )
		,( 5, 'BuyourConcrete', '98 Pavers Road, Chatanooga, TN 83923' )
		,( 6, 'Lowes Home Improvement', '87 Kyles Lane, Crescent Springs, KY 41017')
		
	
-- --------------------------------------------------------------------------------
-- Add Records into Jobs
-- --------------------------------------------------------------------------------

INSERT INTO TJobs ( sintJobID, sintCustomerID, strJobDesc, sintJobStatusID, dteStartDate, dteEndDate )
VALUES	 ( 1, 1, 'Leaky Faucet', 3, '01/22/2016', '01/24/2016' )
		,( 2, 3, 'Toilet cracked along with piping leading to and from the connection', 3, '07/08/2017', '08/02/2017' )
		,( 3, 2, 'Leaking water intake valve in 2nd story bathroom', 2, '09/02/2020', '01/01/2999')
		,( 4, 4, 'Sewage drainage from house is blocked', 1, '10/02/2020', '01/01/2999' )
		,( 5, 6, 'Underground piping in backyard is broken and leaked into backyard', 2, '09/26/2020', '01/01/2999' )
		,( 6, 3, 'Drainage system to sink is blocked', 1, '12/02/2020', '01/01/2999' )
		,( 7, 3, 'Basement flooding due to pipe burst', 3, '01/06/2017', '01/09/2017' )
		,( 8, 3, 'Piping contains lead and needed to be replaced', 3, '05/05/2012', '08/04/2013')
		,( 9, 3, 'Installing new bathroom addition with toilet, bathtub, and sink', 2, '11/02/2020', '01/01/2999' )

-- --------------------------------------------------------------------------------
-- Add Records into JobsMaterials
-- --------------------------------------------------------------------------------

INSERT INTO TJobsMaterials ( sintJobMaterialID, sintJobID, sintMaterialID, sintMaterialAmt )
VALUES	 ( 1, 1, 1, 4 )
		,( 2, 2, 2, 5 )
		,( 3, 2, 3, 2 )
		,( 4, 3, 4, 6 )
		,( 5, 4, 6, 20)
		,( 6, 4, 5, 25)
		,( 7, 6, 2, 15)
		,( 8, 6, 3, 20)
		,( 9, 7, 4, 13)
		,( 10, 8, 5, 20)
		,( 11, 9, 5, 19)
		,( 12, 2, 8, 25)

-- --------------------------------------------------------------------------------
-- Add Records into MaterialsVendors
-- --------------------------------------------------------------------------------

INSERT INTO TMaterialsVendors ( sintMaterialVendorID, sintMaterialID, sintVendorID, monCostPerUnit )
VALUES	 ( 1, 1, 1, 8.99 )
		,( 2, 2, 1, 4.05 )
		,( 3, 3, 2, 9.99 )
		,( 4, 4, 6, 4.99 )
		,( 5, 5, 3, 6.00 )
		,( 6, 6, 6, 2.00 ) 
		,( 7, 7, 6, 2.00 )
		,( 8, 8, 2, 1.00 )
		
-- --------------------------------------------------------------------------------
-- Add Records into JobsPlumbers 
-- --------------------------------------------------------------------------------

INSERT INTO TJobsPlumbers ( sintJobPlumberID, sintJobID, sintPlumberID, realHoursWorked )  
VALUES	 ( 1, 1, 1, 20.5)
		,( 2, 2, 2, 19.0)
		,( 3, 2, 3, 5.0)
		,( 4, 3, 4, 30.0)
		,( 5, 4, 6, 17.0)
		,( 6, 5, 3, 19.0)
		,( 7, 6, 4, 20.5)
		,( 8, 7, 4, 18.5)
		,( 9, 8, 3, 35.0)
		,( 10, 3, 3, 14.0)
		,( 11, 7, 3, 17.5)
		,( 12, 9, 3, 25.0)
		,( 13, 9, 4, 10.0)

-- --------------------------------------------------------------------------------
-- Add Records into PlumbersSkills
-- --------------------------------------------------------------------------------

INSERT INTO TPlumbersSkills ( sintPlumberSkillID, sintPlumberID, sintSkillID )
VALUES	 ( 1, 1, 2 ) 
		,( 2, 2, 1 )
		,( 3, 3, 6 )
		,( 4, 3, 2 )
		,( 5, 4, 6 )
		,( 6, 6, 5 )

-- ------------------------------------------------------------------------------------
-- Final Update and Delete Statements
-- -------------------------------------------------------------------------------------
-- 1.) Create SQL to update the address for a specific customer. Include a select statement before and after the update. 
Select *
From TCustomers
Where strLastName = 'Grosse'
Update TCustomers
Set strAddress = '78 Cherry Street, Philadelphia, PA 43093'
Where strLastName = 'Grosse'
Select *
From TCustomers
Where strLastName = 'Grosse'

-- 2.) Create SQL to increase the hourly rate by $2 for each worker that has been an employee for at least 1 year. Include a select before and after the update. Make sure that you have data so that some rows are updated and others are not. 
Select *
From TPlumbers
Update TPlumbers
Set monHourlyRate = monHourlyRate + 2.00
Where dteHireDate < '12/04/2019'
Select *
From TPlumbers

-- 3.) Create SQL to delete a specific job that has associated work hours and materials assigned to it. Include a select before and after the statement(s). 
Select *
From TJobs As TJ join TJobsMaterials As TJM
	ON TJ.sintJobID = TJM.sintJobID

	join TMaterials As TM
	On TM.sintMaterialID = TJM.sintMaterialID

	join TJobsPlumbers As TJP
	On TJ.sintJobID = TJP.sintJobID

Delete From TJobsMaterials
Where sintJobID = 1

Delete From TJobsPlumbers
Where sintJobID = 1

Delete From TJobs
Where sintJobID = 1

Select *
From TJobs As TJ join TJobsMaterials As TJM
	ON TJ.sintJobID = TJM.sintJobID

	join TMaterials As TM
	On TM.sintMaterialID = TJM.sintMaterialID

	join TJobsPlumbers As TJP
	On TJ.sintJobID = TJP.sintJobID

-- -------------------------------------------------------------------------
-- Final Query Statements
-- --------------------------------------------------------------------------
-- 4.) Write a query to list all jobs that are in process. Include the Job ID and Description, Customer ID and name, and the start date. Order by the Job ID. 
Select TJ.sintJobID as 'Job ID', TJ.strJobDesc as 'Job Description', TJS.strStatus as Status, TC.sintCustomerID as 'Customer ID', TC.strFirstName +' '+ TC.strLastName as Customer, TJ.dteStartDate as 'Start Date'
From TJobs As TJ join TJobStatus AS TJS
	On TJ.sintJobStatusID = TJS.sintJobStatusID

	Join TCustomers As TC
	On TC.sintCustomerID = TJ.sintCustomerID

Where TJS.strStatus = 'In Process'
Order by TJ.sintJobID

-- 5.) Write a query to list all complete jobs for a specific customer and the materials used on each job. Include the quantity, unit cost, and total cost for each material on each job.
--     Order by Job ID and material ID. Note: Select a customer that has at least 3 complete jobs and at least 1 open job and 1 in process job. At least one of the complete jobs should have multiple materials. 
--     If needed, go back to your inserts and add data.
Select TJ.sintJobID as 'Job ID', TJS.strStatus as Status, TC.sintCustomerID as 'Customer ID', TC.strFirstName +' '+ TC.strLastName as Customer, TM.sintMaterialID as 'Material ID', TM.strMaterialType as 'Material Type', TJM.sintMaterialAmt as Quantity, TMV.monCostPerUnit as 'Cost per Unit', Cast((TJM.sintMaterialAmt*TMV.monCostPerUnit) as Money) As 'Total Cost of Materials'
From TJobs As TJ join TJobStatus AS TJS
	On TJ.sintJobStatusID = TJS.sintJobStatusID

	Join TCustomers As TC
	On TC.sintCustomerID = TJ.sintCustomerID

	Join TJobsMaterials As TJM
	On TJM.sintJobID = TJ.sintJobID
	
	Join TMaterials As TM
	On TM.sintMaterialID = TJM.sintMaterialID

	Join TMaterialsVendors As TMV
	On TMV.sintMaterialID = TM.sintMaterialID
Where TC.sintCustomerID = 3 and TJS.strStatus = 'Complete'
Order by TJ.sintJobID, TM.sintMaterialID

-- 6.) This step should use the same customer as in step 4.2. Write a query to list the total cost for all materials for each completed job for the customer. Use the data returned in step 4.2 to validate your results. 
Select TJ.sintJobID as 'Job ID', TJS.strStatus as Status, TC.sintCustomerID as 'Customer ID', TC.strFirstName+' '+TC.strLastName as Customer, Cast(SUM(TJM.sintMaterialAmt*TMV.monCostPerUnit) as Money) AS 'Total Cost Per Job'
From TJobs As TJ join TJobStatus AS TJS
	On TJ.sintJobStatusID = TJS.sintJobStatusID

	Join TCustomers As TC
	On TC.sintCustomerID = TJ.sintCustomerID

	Join TJobsMaterials As TJM
	On TJM.sintJobID = TJ.sintJobID
	
	Join TMaterials As TM
	On TM.sintMaterialID = TJM.sintMaterialID

	Join TMaterialsVendors As TMV
	On TMV.sintMaterialID = TM.sintMaterialID
Where TC.sintCustomerID = 3 and TJS.strStatus = 'Complete'
Group by TJ.sintJobID, TJS.strStatus, TC.sintCustomerID, TC.strFirstName, TC.strLastName

-- 7.) Write a query to list all jobs that have work entered for them. Include the job ID, job description, and job status description. 
--     List the total hours worked for each job with the lowest, highest, and average hourly rate. The average hourly rate should be weighted based on the number of hours worked at that rate. 
--     Make sure that your data includes at least one job that does not have hours logged. This job should not be included in the query. Order by highest to lowest average hourly rate. 
Select TJ.sintJobID as 'Job ID', TJ.strJobDesc as 'Job Description', TJS.strStatus as Status, Sum(TJP.realHoursWorked) As 'Total Hours Worked', Max(TP.monHourlyRate) AS 'Max Hourly Rate', Min(TP.monHourlyRate) As 'Minimum Hourly Rate', Cast((SUM(TP.monHourlyRate*TJP.realHoursWorked)/SUM(TJP.realHoursWorked)) as Money) As 'Weighted Average Hourly Rate'
From TJobs As TJ join TJobsPlumbers As TJP
	On TJ.sintJobID = TJP.sintJobID
	
	Join TJobStatus As TJS
	On TJ.sintJobStatusID = TJS.sintJobStatusID

	Join TPlumbers As TP
	On TJP.sintPlumberID = TP.sintPlumberID
	
	Group by TJ.sintJobID, TJ.strJobDesc, TJS.strStatus
	Order by 'Weighted Average Hourly Rate'


-- 8.) Write a query that lists all materials that have not been used on any jobs. Include Material ID and Description. Order by Material ID. 
Select TM.sintMaterialID as 'Material ID', TM.strMaterialType as 'Material Type'
From TMaterials As TM
Where TM.strMaterialType NOT IN ( Select TM.strMaterialType
									From TJobsMaterials As TJM join TMaterials As TM
									On TJM.sintMaterialID = TM.sintMaterialID)
Order by TM.sintMaterialID


-- 9.) Create a query that lists all workers with a specific skill, their hire date, and the total number of jobs that they worked on. List the Skill ID and description with each row. Order by Worker ID. 
Select TP.sintPlumberID as 'Plumber ID', TP.strFirstName+' '+TP.strLastName As Plumber, TP.dteHireDate as 'Date of Hire', TS.sintSkillID as 'Skill ID', TS.strSkill as 'Skill', COUNT(TJP.sintJobPlumberID) As 'Number of Jobs Worked'
From TPlumbers As TP Join TPlumbersSkills AS TPS
	On TP.sintPlumberID = TPS.sintPlumberID

	Join TSkills As TS
	On TS.sintSkillID = TPS.sintSkillID

	Join TJobsPlumbers As TJP
	On TJP.sintPlumberID = TP.sintPlumberID

	Group by TP.sintPlumberID, TP.strFirstName, TP.strLastName, TP.dteHireDate, TS.sintSkillID, TS.strSkill
	Order by TP.sintPlumberID


-- 10.) Create a query that lists all workers that worked greater than 20 hours for all jobs that they worked on. Include the Worker ID and name, number of hours worked, and number of jobs that they worked on. Order by Worker ID. 
Select TP.sintPlumberID as 'Plumber ID', TP.strFirstName + ' ' + TP.strLastName as 'Plumber Name', SUM(TJP.realHoursWorked) as 'Total Hours Worked', COUNT(TJP.sintJobPlumberID) as 'Number of Jobs Worked'
From TPlumbers as TP Join TJobsPlumbers as TJP
	On TP.sintPlumberID = TJP.sintPlumberID

	Group by TP.sintPlumberID, TP.strFirstName + ' ' + TP.strLastName
	Having SUM(TJP.realHoursWorked) > 20
	Order by TP.sintPlumberID

-- 11.) Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. Order by Customer ID. Make sure that you have at least three customers on 'Main Street' each with different house numbers. Make sure that you also have customers that are not on 'Main Street'. 
Select TC.sintCustomerID as 'Customer ID', TC.strFirstName+' '+TC.strLastName as Customer, TC.strAddress as Address
From TCustomers As TC
Where TC.strAddress LIKE '%Main Street%'

-- 12.) Write a query to list completed jobs that started and ended in the same month. List Job, Job Status, Start Date and End Date. 
Select TJ.sintJobID as 'Job ID', TJ.strJobDesc as 'Job Description', TJS.strStatus as Status, TJ.dteStartDate as 'Start Date', TJ.dteEndDate as 'End Date', DATEDIFF(Month, TJ.dteStartDate, TJ.dteEndDate) as 'Number of Months'
From TJobs AS TJ join TJobStatus AS TJS
	On TJ.sintJobStatusID = TJS.sintJobStatusID
	Where DATEDIFF(Month, TJ.dteStartDate, TJ.dteEndDate) = 0
		and TJS.strStatus = 'Complete'

-- 13.) Create a query to list workers that worked on three or more jobs for the same customer. 
Select TP.strFirstName + ' ' + TP.strLastName as Plumber, TC.strFirstName +' '+ TC.strLastName as Customer, COUNT(TJP.sintPlumberID) As 'Number of Jobs Worked for Customer'
From TJobs as TJ join TJobsPlumbers as TJP
	On TJ.sintJobID = TJP.sintJobID

	Join TCustomers as TC
	On TC.sintCustomerID = TJ.sintCustomerID

	Join TPlumbers as TP
	On TP.sintPlumberID = TJP.sintPlumberID
		
	Group by TP.strFirstName, TP.strLastName, TC.strFirstName, TC.strLastName
	Having Count(TJP.sintPlumberID) >=3


-- 14.) Create a query to list all workers and their total # of skills. Make sure that you have workers that have multiple skills and that you have at least 1 worker with no skills. The worker with no skills should be included with a total number of skills = 0. Order by Worker ID. 
Select TP.sintPlumberID as 'Plumber ID', TP.strFirstName+' '+TP.strLastName as Plumber, Count(TPS.sintPlumberSkillID) as 'Total # of Skills'
From TPlumbers as TP Left Join TPlumbersSkills as TPS
	On TP.sintPlumberID = TPS.sintPlumberID

	Left Join TSkills as TS
	On TS.sintSkillID = TPS.sintSkillID

	Group by TP.sintPlumberID, TP.strFirstName, TP.strLastName
	Order by TP.sintPlumberID
	

-- 15.) Write a query to list the total Charge to the customer for each job. Calculate the total charge to the customer as the total cost of materials + total Labor costs + 30% Profit. 
Select TJ.sintJobID as 'Job ID', TJ.strJobDesc as 'Job Description', Cast(SUM(((TJP.realHoursWorked*TP.monHourlyRate) + (TJM.sintMaterialAmt*TMV.monCostPerUnit))+(((TJP.realHoursWorked*TP.monHourlyRate) + (TJM.sintMaterialAmt*TMV.monCostPerUnit))*.3)) as Money) as 'Total Cost of Project'
From TJobs as TJ join TJobsMaterials as TJM
	On TJ.sintJobID = TJM.sintJobID

	Join TMaterials as TM
	On TJM.sintMaterialID = TM.sintMaterialID

	Join TMaterialsVendors as TMV
	On TMV.sintMaterialID = TM.sintMaterialID

	Join TJobsPlumbers as TJP
	On TJP.sintJobID = TJ.sintJobID

	Join TPlumbers as TP
	On TP.sintPlumberID = TJP.sintPlumberID

	Group by TJ.sintJobID, TJ.strJobDesc

--16.) Write a query that totals what is owed to each vendor for a particular job. 
Select TJ.sintJobID as 'Job ID', TJ.strJobDesc as'Job Description', TV.strVendorName as Vendor, Cast(SUM(TJM.sintMaterialAmt*TMV.monCostPerUnit) as Money) as 'Total Amount Owed to Vendor'
From TJobs as TJ join TJobsMaterials as TJM
	On TJ.sintJobID = TJM.sintJobID

	Join TMaterials as TM
	On TM.sintMaterialID = TJM.sintMaterialID

	Join TMaterialsVendors as TMV
	On TMV.sintMaterialID = TM.sintMaterialID

	Join TVendors as TV
	On TV.sintVendorID = TMV.sintVendorID

	Where TJ.sintJobID = 2
	Group by TV.strVendorName, TJ.sintJobID, TJ.strJobDesc
	

