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
					Email VARCHAR(200) UNIQUE,
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

CREATE TABLE AccessLevelPermissions (AccessLevelPermissionID INT PRIMARY KEY IDENTITY(1,1),
									 AccessLevelID INT,
									 PermissionID INT,
									 FOREIGN KEY (AccessLevelID) REFERENCES AccessLevels(AccessLevelID),
									 FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID),);


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
INSERT INTO Users (Username, Password, FirstName, LastName, Email, Contact_No, StatusID)
VALUES ('admin', 'admin', 'John', 'A', 'admin@gmail.com', '09345678911', 1);

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
					  Email VARCHAR(100),
					  Address VARCHAR(200),
					  Contact_No Char(11),
					  DateCreated DATETIME DEFAULT GETDATE(),
					  CreatedBy VARCHAR(200),
					  FOREIGN KEY (UserID) REFERENCES Users (UserID));

SELECT * FROM Clients