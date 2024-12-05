-- Use the newly created database
USE RPG_Game;
GO

-- Drop Locations Table if it exists
IF OBJECT_ID('dbo.Locations', 'U') IS NOT NULL
    DROP TABLE dbo.Locations;
GO

-- Create Tables
CREATE TABLE CharacterTypes (
    CharacterTypeID INT PRIMARY KEY IDENTITY(1,1),
    CharacterTypeName NVARCHAR(50)
);

CREATE TABLE Locations (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    LocationName NVARCHAR(100),
    LocationDescription NVARCHAR(500)
);

CREATE TABLE Quests (
    QuestID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100),
    Description NVARCHAR(500)
);

CREATE TABLE QuestProgress (
    QuestProgressID INT PRIMARY KEY IDENTITY(1,1),
    PlayerID INT,
    QuestID INT,
    IsCompleted BIT DEFAULT 0,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID)
);

CREATE TABLE Story (
    StoryID INT PRIMARY KEY IDENTITY(1,1),
    QuestID INT,
    Narrative NVARCHAR(MAX),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID)
);

CREATE TABLE Players (
    PlayerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    CharacterType NVARCHAR(50),
    Health INT DEFAULT 100,
    Strength INT DEFAULT 10,
    CurrentLocationID INT DEFAULT 1
);

-- Insert Sample Character Types
INSERT INTO CharacterTypes (CharacterTypeName)
VALUES 
('Mercenary'),
('Master Blacksmith'),
('Prisoner of War'),
('Tarnished'),
('Hellscaped'),
('Regular Civilian');

-- Insert Sample Locations
INSERT INTO Locations (LocationName, LocationDescription)
VALUES 
('Kingdom Walls', 'The defensive walls surrounding the kingdom, where the battle is taking place.'),
('Blacksmith Shop', 'A local shop known for its strong and powerful weapons.'),
('Dungeon', 'A dark, damp place where prisoners are held captive by the enemy.');

-- Insert Sample Quests
INSERT INTO Quests (Title, Description)
VALUES 
('Defend the Kingdom', 'Help defend the kingdom from an incoming attack.'),
('Blacksmith’s Request', 'Craft a legendary sword for the blacksmith.'),
('Escape the Dungeon', 'Escape from the enemy dungeon and return home.');

-- Insert Sample Players
INSERT INTO Players (Name, CharacterType, Health, Strength, CurrentLocationID)
VALUES 
('Arthur', 'Mercenary', 100, 15, 1),
('Meredith', 'Master Blacksmith', 80, 12, 2),
('Gareth', 'Prisoner of War', 70, 8, 1),
('Eldric', 'Tarnished', 90, 14, 1),
('Thalia', 'Regular Civilian', 60, 7, 3);

-- Insert Sample Quest Stories
INSERT INTO Story (QuestID, Narrative)
VALUES 
(1, 'The kingdom is under siege. Your task is to join the defense and protect the civilians from the enemy forces.'),
(2, 'A famous blacksmith has requested your help in forging a sword that will defeat the dark lord. You must collect rare materials and create the perfect weapon.'),
(3, 'You’ve been captured by enemy forces. Your goal is to escape the dungeon and find a way back to freedom before the guards catch you.');

-- Insert Initial Quest Progress for Players
INSERT INTO QuestProgress (PlayerID, QuestID, IsCompleted)
VALUES 
(1, 1, 0),  -- Arthur is working on 'Defend the Kingdom'
(2, 2, 0),  -- Meredith is working on 'Blacksmith’s Request'
(3, 3, 0);  -- Gareth is working on 'Escape the Dungeon'
