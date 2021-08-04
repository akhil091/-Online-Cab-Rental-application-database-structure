-- create a table
/*creating  a table Cab_Rentals here PassengerID and DriverID are the dummy foreign keys*/


create table Cab_Rentals (
 rideID int(20),
 passengerID varchar(30) not null,
 driverID varchar(30) not null,
 cabID varchar(10) not null,
 transactionID varchar(20) not null,
 payment_mode char(30) not null,
 fair int(5) not null,
 date datetime,
 pay int(10),
 service_tax float(5,2),
 payment_to_driver float(5,2),
 primary key (rideID),
 foreign key (passengerID) references Passengers(passengerID),
 foreign key (driverID) references Drivers(driverID),
 foreign key (transactionID) references Transactions(transactionID)
 );

-- Inserting data into the table
 
INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (01,100,010,"CSD89",648396,"cash",300,'24/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (02,200,020,"DKS97",798313,"Net Banking",390,'20/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (03,300,030,"SWR78",985985,"credit card",450,'21/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (04,400,040,"LJT39",438972,"credit card",260,'21/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (05,500,050,"SHU38",364299,"cash",800,'17/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (06,600,060,"AHH38",469827,"Net Banking",690,'19/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (07,700,070,"DFL37",346028,"cash",437,'20/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (08,800,080,"UDQ37",346031,"credit card",730,'21/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (09,900,090,"SIS27",723202,"cash",600,'23/07/2021');

INSERT INTO Cab_Rentals(rideID,passengerID,driverID,cabID,transactionID,payment_mode,fair,date)
VALUES (10,1000,0100,"OAS72",342811,"credit card",290,'18/07/2021');

-- Transaction query for calculating taxes and payouts

begin transaction T1;
    update Cab_Rentals
    set pay=fair + (fair*0.18), /*total amount to be paid by the passenger*/
        service_tax=fair*0.18,  /*calculating the service tax to the company*/
        payment_to_driver=fair - (fair*0.15)  /*money payed to the driver after deducting fee*/
    where passengerID IS NOT NULL;
    commit transaction T1;

select * from Cab_Rentals;

 -- Reports

-- 1. The total amount of transactions processed through Credit card for the selected date range


-- SELECT sum(pay) from Cab_Rentals
-- WHERE payment_mode = "credit card" and date BETWEEN "20/07/2021" and "25/072021";

-- 2. Total earned by a driver for the selected date range

-- SELECT sum(payment_to_driver) from Cab_Rentals
-- WHERE  date BETWEEN "20/07/2021" and "25/072021";


-- 3. Weekly revenue for the company including tax

/*SET DATEFIRST 1

    SELECT CAST(MIN( [date]) AS VARCHAR(20))+' TO '+CAST (MAX([date]) AS VARCHAR(20)) AS DATE,
           SUM(pay) AS Weekly_Revenue
    FROM Car_Rental
    GROUP BY DATEPART(WEEK,[date])
    HAVING COUNT(DISTINCT[date])=7

SET DATEFIRST 7*/

-- 4. Weekly amount paid to drivers

/*SET DATEFIRST 1

    SELECT CAST(MIN( [journey_date]) AS VARCHAR(20))+' TO '+CAST (MAX([journey_date]) AS VARCHAR(20)) AS DATE,
           SUM(driver_fare) AS Weekly_Revenue
    FROM passenger_driver
    GROUP BY DATEPART(WEEK,[journey_date])
    HAVING COUNT(DISTINCT[journey_date])=7

SET DATEFIRST 7*/
    



