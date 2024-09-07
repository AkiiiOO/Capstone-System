CREATE TABLE UserStatus (StatusID INT PRIMARY KEY, 
                         StatusName VARCHAR(50));
                         
CREATE TABLE AccessLevels (AccessLevelID INT PRIMARY KEY IDENTITY(1,1),
                           AccessLevelName VARCHAR(100)UNIQUE NOT NULL);
                         
CREATE TABLE Permissions (PermissionID INT PRIMARY KEY IDENTITY(1,1),
						  PermissionName VARCHAR(50)UNIQUE NOT NULL);

CREATE TABLE Users (UserID INT PRIMARY KEY IDENTITY(1,1),
					Username VARCHAR(50) UNIQUE NOT NULL,
					Password VARCHAR(255) NOT NULL, 
					FirstName VARCHAR(100),
					LastName VARCHAR(100),
					Contact_No Char(11), 
					StatusID INT, 
					CreatedDate DATETIME DEFAULT GETDATE(),
					UpdatedDate DATETIME DEFAULT GETDATE(),
					FOREIGN KEY (StatusID) REFERENCES UserStatus(StatusID));
SELECT * FROM Users

CREATE TABLE UserAccessLevels (UserAccessLevelID INT PRIMARY KEY IDENTITY(1,1),
							   UserID INT,
							   AccessLevelID INT,
							   FOREIGN KEY (UserID) REFERENCES Users(UserID),
							   FOREIGN KEY (AccessLevelID) REFERENCES AccessLevels(AccessLevelID),
							   UNIQUE(UserID, AccessLevelID));


--changed added User ID fix tommorow
CREATE TABLE AccessLevelPermissions (AccessLevelPermissionID INT PRIMARY KEY IDENTITY(1,1),
									 AccessLevelID INT,
									 PermissionID INT,
									 FOREIGN KEY (AccessLevelID) REFERENCES AccessLevels(AccessLevelID),
									 FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID));
									 


INSERT INTO UserStatus (StatusID, StatusName) VALUES (1, 'Active');
INSERT INTO UserStatus (StatusID, StatusName) VALUES (2, 'Inactive');

SELECT * FROM UserStatus

INSERT INTO AccessLevels (AccessLevelName) VALUES ('Admin');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Service');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Inventory');

SELECT * FROM AccessLevels

INSERT INTO Permissions (PermissionName) VALUES ('Full control');
INSERT INTO Permissions (PermissionName) VALUES ('Modify');
INSERT INTO Permissions (PermissionName) VALUES ('Read');
INSERT INTO Permissions (PermissionName) VALUES ('Write');

SELECT * FROM Permissions

--Users
INSERT INTO Users (Username, Password, FirstName, LastName, Contact_No, StatusID)
VALUES ('admin', 'admin', 'John', 'A', '09345678911', 1);

--UserAccessLevels
INSERT INTO UserAccessLevels (UserID, AccessLevelID) VALUES (1, 1);
SELECT * FROM UserAccessLevels

--AccessLevelPermissions
INSERT INTO AccessLevelPermissions (AccessLevelID, PermissionID) VALUES (1, 1);
SELECT * FROM AccessLevelPermissions


CREATE TABLE Clients (ClientID INT IDENTITY(1,1) PRIMARY KEY,
					  UserID INT,
					  FirstName VARCHAR(100),
					  MiddleInitial CHAR(1),
					  LastName VARCHAR(100),
					  Address VARCHAR(200),
					  Contact_No Char(11),
					  DateCreated DATETIME DEFAULT GETDATE(),
					  CreatedBy VARCHAR(200),
					  FOREIGN KEY (UserID) REFERENCES Users (UserID));
SELECT * FROM Clients

--FOr the casket
CREATE TABLE CasketType (CasketTypeID INT IDENTITY(1,1) PRIMARY KEY,
						 CasketTypeName VARCHAR(50));

INSERT INTO CasketType (CasketTypeName) VALUES ('Ordinary'),
											  ('Semi-ordinary'),
											  ('First-class ');
SELECT * FROM CasketType

CREATE TABLE Casket (CasketID INT IDENTITY(1,1) PRIMARY KEY,
					 CasketTypeID INT FOREIGN KEY REFERENCES CasketType(CasketTypeID),
					 CasketImage IMAGE,
					 CasketName VARCHAR(100),
					 Price DECIMAL(10, 2));	
INSERT INTO Casket (CasketTypeID, CasketImage, CasketName, Price)VALUES (1, NULL, 'Classic Oak Casket', 600.00),
																		(2, NULL, 'Stainless Steel Casket', 900.00);
																		
--For the Vehicle
CREATE TABLE VehicleType (VehicleTypeID INT IDENTITY(1,1) PRIMARY KEY,
						  VehicleTypeName VARCHAR(50));
						  
INSERT INTO VehicleType (VehicleTypeName) VALUES ('Hearse'),
												 ('Van');
SELECT * FROM VehicleType

CREATE TABLE Vehicle (VehicleID INT IDENTITY(1,1) PRIMARY KEY,
					  VehicleTypeID INT FOREIGN KEY REFERENCES VehicleType(VehicleTypeID),
					  VehicleImage IMAGE,
					  VehicleName VARCHAR(100),
					  Price DECIMAL(10, 2));
					  
INSERT INTO Vehicle (VehicleTypeID, VehicleImage, VehicleName, Price) VALUES (1, NULL, 'Luxury Hearse', 250.00),
																			 (2, NULL, 'Standard Van', 150.00);
					  
-- For the Flower Arrangement
CREATE TABLE FlowerArrangementsType (ArrangementTypeID INT IDENTITY(1,1) PRIMARY KEY,
									 ArrangementTypeName VARCHAR(50));
									 
INSERT INTO FlowerArrangementsType (ArrangementTypeName)VALUES ('Bouquet'),
															   ('Wreath');
									 
CREATE TABLE FlowerArrangements (ArrangementID INT IDENTITY(1,1) PRIMARY KEY,
							 	 ArrangementTypeID INT FOREIGN KEY REFERENCES FlowerArrangementsType(ArrangementTypeID),
								 ArrangementImage IMAGE,
							 	 ArrangementName VARCHAR(50),
								 Price DECIMAL(10, 2));
								 
INSERT INTO FlowerArrangements (ArrangementTypeID, ArrangementImage, ArrangementName, Price) VALUES (1, NULL, 'White Sympathy Floor', 45.00),
																								    (2, NULL, 'Tulip Centerpiece', 55.00);
SELECT * FROM FlowerArrangements


CREATE TABLE Package (PackageID INT IDENTITY(1,1) PRIMARY KEY,
				  	  PackageName VARCHAR(100),
					  Description TEXT,
					  Price DECIMAL(10, 2));
