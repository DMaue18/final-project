-- Create Database
CREATE DATABASE IF NOT EXISTS CIMS;
USE CIMS;

-- Create Incidents Table
CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY,
    Type VARCHAR(255),
    Description TEXT,
    AffectedAreas VARCHAR(255),
    Timestamp DATETIME,
    Status VARCHAR(50)
);

-- Create RootCauses Table
CREATE TABLE RootCauses (
    RootCauseID INT PRIMARY KEY,
    IncidentID INT,
    RootCauseDescription TEXT,
    Vulnerabilities TEXT,
    ImpactLevel VARCHAR(50),
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Measures Table
CREATE TABLE Measures (
    MeasureID INT PRIMARY KEY,
    IncidentID INT,
    CorrectiveMeasures TEXT,
    PreventiveMeasures TEXT,
    ImplementationDate DATE,
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Indexes
CREATE INDEX idx_AffectedAreas ON Incidents(AffectedAreas);
CREATE INDEX idx_Timestamp ON Incidents(Timestamp);

-- Insert Sample Data
INSERT INTO Incidents VALUES (1, 'Phishing', 'Email phishing attack', 'Email system, User accounts', '2023-01-15 09:30:00', 'Open');
INSERT INTO Incidents VALUES (2, 'Malware', 'Ransomware attack', 'Servers, Workstations', '2023-02-10 14:45:00', 'Open');
INSERT INTO Incidents VALUES (3, 'Data Breach', 'Unauthorized access to sensitive data', 'Database server', '2023-03-05 08:00:00', 'Open');


INSERT INTO RootCauses VALUES (102, 2, 'Exploited software vulnerability', 'Outdated antivirus software', 'Medium');
INSERT INTO RootCauses VALUES (103, 3, 'Weak database access controls', 'Insufficient encryption', 'High');
INSERT INTO RootCauses VALUES (101, 1, 'Social engineering', 'Weak user awareness', 'High');

INSERT INTO Measures VALUES (201, 1, 'User training on identifying phishing emails', 'Implement email filtering system', '2023-02-01');
INSERT INTO Measures VALUES (202, 2, 'Apply security patches', 'Regularly update antivirus software', '2023-02-15');
INSERT INTO Measures VALUES (203, 3, 'Enhance database access controls', 'Implement data encryption', '2023-03-10');