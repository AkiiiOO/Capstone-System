CREATE TABLE UserStatus (StatusID INT PRIMARY KEY, 
                         StatusName VARCHAR(50));

INSERT INTO UserStatus (StatusID, StatusName) VALUES (1, 'Active');
INSERT INTO UserStatus (StatusID, StatusName) VALUES (2, 'Inactive');

SELECT * FROM UserStatus

CREATE TABLE AccessLevels (AccessLevelID INT PRIMARY KEY IDENTITY(1,1),
                           AccessLevelName VARCHAR(100)UNIQUE NOT NULL);
                         
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Admin');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Service');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Inventory');

SELECT * FROM AccessLevels

CREATE TABLE Permissions (PermissionID INT PRIMARY KEY IDENTITY(1,1),
						  PermissionName VARCHAR(50)UNIQUE NOT NULL);

INSERT INTO Permissions (PermissionName) VALUES ('Full control');
INSERT INTO Permissions (PermissionName) VALUES ('Modify');
INSERT INTO Permissions (PermissionName) VALUES ('Read');
INSERT INTO Permissions (PermissionName) VALUES ('Write');

SELECT * FROM Permissions

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
							   UserID INT FOREIGN KEY REFERENCES Users(UserID),
							   AccessLevelID INT FOREIGN KEY REFERENCES AccessLevels(AccessLevelID),
							   UNIQUE(UserID, AccessLevelID));
SELECT * FROM UserAccessLevels


CREATE TABLE AccessLevelPermissions (AccessLevelPermissionID INT PRIMARY KEY IDENTITY(1,1),
									 AccessLevelID INT,
									 PermissionID INT,
									 FOREIGN KEY (AccessLevelID) REFERENCES AccessLevels(AccessLevelID),
									 FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID));
									 

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
					  FirstName VARCHAR(100)NOT NULL,
					  MiddleInitial CHAR(1)NULL,
					  LastName VARCHAR(100)NOT NULL,
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
SELECT * FROM Casket
												
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
					  
INSERT INTO Vehicle (VehicleTypeID, VehicleImage, VehicleName, Price) VALUES (1, NULL, 'car1', 250.00),
																			 (2, NULL, 'car2', 150.00);
SELECT * FROM Vehicle		  
-- For the Flower Arrangement
CREATE TABLE FlowerArrangementsType (ArrangementTypeID INT IDENTITY(1,1) PRIMARY KEY,
									 ArrangementTypeName VARCHAR(100));
									 
INSERT INTO FlowerArrangementsType (ArrangementTypeName)VALUES ('Bouquet'),
															   ('Wreath');
									 
CREATE TABLE FlowerArrangements (ArrangementID INT IDENTITY(1,1) PRIMARY KEY,
							 	 ArrangementTypeID INT FOREIGN KEY REFERENCES FlowerArrangementsType(ArrangementTypeID),
								 ArrangementImage IMAGE,
							 	 ArrangementName VARCHAR(200),
								 Price DECIMAL(10, 2));
								 
INSERT INTO FlowerArrangements (ArrangementTypeID, ArrangementImage, ArrangementName, Price) VALUES (1, NULL, 'White Sympathy Floor', 45.00),
																								    (2, NULL, 'Tulip Centerpiece', 55.00);
SELECT * FROM FlowerArrangements

--songs
CREATE TABLE Song (SongID INT IDENTITY(1,1) PRIMARY KEY,
				   UserID INT FOREIGN KEY REFERENCES Users(UserID),
                   SongName VARCHAR(100),
                   Artist VARCHAR(100),
                   CreatedBy VARCHAR(250),
                   DateCreated DATETIME DEFAULT GETDATE());
                   
INSERT INTO Song (SongName, Artist) VALUES ('Yesterday', 'The Beatles');
INSERT INTO Song (SongName, Artist) VALUES ('About You', 'The 1975');
SELECT * FROM Song

CREATE TABLE Playlists (PlaylistsID INT IDENTITY(1,1) PRIMARY KEY,
						UserID INT FOREIGN KEY REFERENCES Users(UserID),
						PlaylistsName VARCHAR(100),
						CreatedBy VARCHAR(250),
						DateCreated DATETIME DEFAULT GETDATE());

INSERT INTO Playlists (UserID, PlaylistsName, CreatedBy) VALUES (1, 'My Favorite Songs', 'John A');
INSERT INTO Playlists (UserID, PlaylistsName, CreatedBy) VALUES (1, 'Sad', 'John A');
SELECT * FROM Playlists
						
CREATE TABLE PlaylistSongs (PlaylistSongsID INT IDENTITY(1,1) PRIMARY KEY,
							SongID INT FOREIGN KEY REFERENCES Song(SongID),
							PlaylistsID INT FOREIGN KEY REFERENCES Playlists(PlaylistsID),
							DateCreated DATETIME DEFAULT GETDATE());
SELECT * FROM PlaylistSongs

--lights
CREATE TABLE ServiceLights (LightID INT IDENTITY(1,1) PRIMARY KEY,
                            LightDescription VARCHAR(200),
                            CreatedBy VARCHAR(100));
                            
INSERT INTO ServiceLights (LightDescription, CreatedBy)VALUES ('Colored party lights', 'John Doe');
SELECT * FROM ServiceLights

-- embalming price
CREATE TABLE EmbalmingPrice (EmbalmingPriceId INT PRIMARY KEY IDENTITY(1,1),
							 IncludedDays INT NOT NULL,
							 BasePrice DECIMAL(18, 2) NOT NULL,
							 AdditionalDayCharge DECIMAL(18, 2) NOT NULL,
							 CreatedDate DATETIME DEFAULT GETDATE());
INSERT INTO EmbalmingPrice (IncludedDays, BasePrice, AdditionalDayCharge)VALUES 
							(4, 5000.00, 5000.00);
SELECT * FROM EmbalmingPrice


--FOr PAckages
CREATE TABLE Package (PackageID INT IDENTITY(1,1) PRIMARY KEY,
					  PackageName VARCHAR(100) NOT NULL,
					  CasketID INT  FOREIGN KEY REFERENCES Casket(CasketID),
					  LightID INT FOREIGN KEY REFERENCES ServiceLights(LightID),
					  PlaylistsID INT FOREIGN KEY REFERENCES Playlists(PlaylistsID),
					  VehicleID INT  FOREIGN KEY REFERENCES Vehicle(VehicleID),
					  ArrangementID INT  FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
					  EmbalmingPriceId INT  FOREIGN KEY REFERENCES EmbalmingPrice(EmbalmingPriceId),
					  CasketName VARCHAR(100),
					  VehicleName VARCHAR(100),
					  FlowerArrangementName VARCHAR(200),
					  PlaylistsName VARCHAR(100),
					  EmbalmingDays INT,
					  TotalPrice DECIMAL(10, 2),
					  CreatedDate DATETIME DEFAULT GETDATE());

					  
INSERT INTO Package (PackageName, CasketID, LightID, PlaylistsID, VehicleID, ArrangementID, CasketName, VehicleName, FlowerArrangementName, EmbalmingDays, TotalPrice) VALUES 
					('Premium Package', 1, 1, 1, 1, 1, 'Classic Oak Casket', 'Luxury Hearse', 'White Sympathy Floor', 0, 5000.00);
INSERT INTO Package (PackageName, CasketID, LightID, PlaylistsID, VehicleID, ArrangementID, CasketName, VehicleName, FlowerArrangementName, EmbalmingDays, TotalPrice) VALUES 
					('Ordinary', 2, 1, 1, 1, 1, 'Stainless Steel Casket', 'Luxury Hearse', 'White Sympathy Floor', 0, 5195.00);

SELECT * FROM Package

CREATE TABLE CustomizePackage (CustomizePackageID INT IDENTITY(1,1) PRIMARY KEY,
							   PackageID INT  FOREIGN KEY REFERENCES Package(PackageID),
							   CasketID INT  FOREIGN KEY REFERENCES Casket(CasketID),
							   VehicleID INT  FOREIGN KEY REFERENCES Vehicle(VehicleID),
							   ArrangementID INT  FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
							   PlaylistSongsID INT FOREIGN KEY REFERENCES PlaylistSongs(PlaylistSongsID),
							   LightID INT FOREIGN KEY REFERENCES ServiceLights(LightID),
							   EmbalmingPriceId INT  FOREIGN KEY REFERENCES EmbalmingPrice(EmbalmingPriceId),
							   CasketName VARCHAR(100),
							   VehicleName VARCHAR(100),
							   FlowerArrangementName VARCHAR(200),
							   PlaylistsName VARCHAR(100),
							   EmbalmingDays INT,
							   TotalPrice DECIMAL(10, 2),
							   CreatedDate DATETIME DEFAULT GETDATE());
					  
SELECT * FROM CustomizePackage

CREATE TABLE DocumentType (DocumentTypeID INT IDENTITY(1,1) PRIMARY KEY,
						   DocumentTypeName VARCHAR(100) NOT NULL);

INSERT INTO DocumentType (DocumentTypeName)VALUES ('Death Certificate'),
												  ('Medical Certificate');
SELECT * FROM DocumentType

CREATE TABLE ServiceStatus (ServiceStatusID INT IDENTITY(1,1) PRIMARY KEY,
							StatusName VARCHAR(50) NOT NULL);
INSERT INTO ServiceStatus (StatusName) VALUES ('Pending'), 
											  ('In Progress'), 
											  ('Completed'), 
											  ('Cancelled');
CREATE TABLE Cemeteries (CemeteryID INT IDENTITY(1,1) PRIMARY KEY,
						 CemeteryName VARCHAR(200) NOT NULL,
						 Location VARCHAR(250),
						 CreatedBy VARCHAR(250),
						 CreationDate DATETIME DEFAULT GETDATE());
INSERT INTO Cemeteries (CemeteryName, Location, CreatedBy) VALUES ('Tarlac Cemetery', 'Tarlac City', 'Admin'),
																  ('Tarlac Cemetery 2', 'Tarlac city', 'Admin');



CREATE TABLE Chapel (ChapelID INT IDENTITY(1,1) PRIMARY KEY,
					 ChapelName VARCHAR(100) NOT NULL,
					 Capacity INT,
					 Location VARCHAR(200),
					 Price DECIMAL(10, 2));

INSERT INTO Chapel (ChapelName, Capacity, Location, Price)	VALUES ('Chapel 1', 100, 'dito', 4000.00),
														   ('Chapel 2', 50, 'dyan', 4000.00); 
SELECT * FROM Chapel

CREATE TABLE ServiceType (ServiceTypeID INT IDENTITY(1,1) PRIMARY KEY,
						  ServiceTypeName VARCHAR(100) NOT NULL);
						  
-- Insert predefined service types
INSERT INTO ServiceType (ServiceTypeName) VALUES ('Home Service'), 
												 ('Chapel Service');
SELECT * FROM ServiceType

CREATE TABLE ReservationStatus (ReservationStatusID INT IDENTITY(1,1) PRIMARY KEY,
								StatusName VARCHAR(50) NOT NULL);
								
INSERT INTO ReservationStatus (StatusName) VALUES ('Pending');
INSERT INTO ReservationStatus (StatusName) VALUES ('Confirmed');
INSERT INTO ReservationStatus (StatusName) VALUES ('Canceled');
INSERT INTO ReservationStatus (StatusName) VALUES ('Completed');

SELECT * FROM ReservationStatus

--not yet fixed
CREATE TABLE ChapelReservation (ReservationID INT IDENTITY(1,1) PRIMARY KEY,   
								ChapelID INT Null FOREIGN KEY REFERENCES Chapel(ChapelID),    
								ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
								ServiceTypeID INT NULL FOREIGN KEY REFERENCES ServiceType(ServiceTypeID),
								ReservationStatusID INT NULL FOREIGN KEY REFERENCES ReservationStatus(ReservationStatusID),
								ServiceTypeName VARCHAR(100) NULL,
								StartDate DATE NOT NULL,
								EndDate DATE NOT NULL,
								Location VARCHAR(200) NULL,
								ReservedBy VARCHAR(100)NOT NULL,
								DateCreated DATETIME DEFAULT GETDATE());
SELECT * FROM ChapelReservation



CREATE TABLE ServiceRequests (ServiceRequestID INT IDENTITY(1,1) PRIMARY KEY,    
							  UserID INT FOREIGN KEY REFERENCES Users(UserID),
							  ClientID INT FOREIGN KEY REFERENCES Clients(ClientID),
							  ServiceStatusID INT FOREIGN KEY REFERENCES ServiceStatus(ServiceStatusID),
							  ServiceTypeID INT FOREIGN KEY REFERENCES ServiceType(ServiceTypeID),
							  CemeteryID INT FOREIGN KEY REFERENCES Cemeteries(CemeteryID),
							  DocumentTypeID INT FOREIGN KEY REFERENCES DocumentType(DocumentTypeID),
							  ReservationID INT NULL FOREIGN KEY REFERENCES ChapelReservation(ReservationID),
							  
							  --package 
							  CopPackageID INT  FOREIGN KEY REFERENCES Package(PackageID),
							  CopCasketID INT FOREIGN KEY REFERENCES Casket(CasketID),
							  CopVehicleID INT FOREIGN KEY REFERENCES Vehicle(VehicleID),
							  CopArrangementID INT FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
							  CopSongID INT FOREIGN KEY REFERENCES Song(SongID),
							  CopLightID INT FOREIGN KEY REFERENCES ServiceLights(LightID),
						    
						      -- Service type 
						      ServiceType VARCHAR(100),
						      
							  -- Client and deceased information
							  ClientName VARCHAR(250),
							  DeceasedFName VARCHAR(100) NOT NULL, 
							  DeceasedLName VARCHAR(100) NOT NULL, 
							  DeceasedMInitial VARCHAR(50)NULL,

							  -- Package information
							  CasketName VARCHAR(100), 
							  VehicleName VARCHAR(100), 
							  FlowerArrangementName VARCHAR(200),
							  PlaylistName VARCHAR(100), 
							  ChapelName VARCHAR(100), 
							  ServiceLightsName VARCHAR(100),
							  PackageName VARCHAR(100), 
						    
							  -- Burial and service details
							  CemeteryLocation VARCHAR(200),
							  DateBurial DATE, 
							  TimeBurial TIME,  
							  Address VARCHAR(200),
							  
							  DocumentType VARCHAR(100),
							  DocumentImage IMAGE,
						    
							  -- Service specifics
							  EmbalmingDays INT,
							  TotalPrice DECIMAL(10, 2),
						    
							  -- Auditing details
							  CreationDate DATETIME DEFAULT GETDATE(), 
							  CreatedBy VARCHAR(250));

SELECT * FROM ServiceRequests
