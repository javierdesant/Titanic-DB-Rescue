CREATE DATABASE SpaceTitanicDB;
USE SpaceTitanicDB;

CREATE TABLE passengers
(
    passengerId       INT PRIMARY KEY AUTO_INCREMENT,
    name              VARCHAR(100) NOT NULL,
    age               INT          NOT NULL,
    birthPlanet       VARCHAR(100) NOT NULL,
    destinationPlanet VARCHAR(100) NOT NULL,
    birthSystem       VARCHAR(100) NOT NULL,
    destinationSystem VARCHAR(100) NOT NULL,
    tutorId           INT,
    cabinNumber       INT          NOT NULL,
    side              CHAR(1)      NOT NULL,
    letter            CHAR(1)      NOT NULL,
    isVIP             BOOLEAN      NOT NULL DEFAULT FALSE,
    isCryoSleep       BOOLEAN      NOT NULL DEFAULT FALSE,
    isMissing         BOOLEAN      NOT NULL DEFAULT FALSE,
    FOREIGN KEY (tutorId) REFERENCES passengers (passengerId)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (birthPlanet, birthSystem) REFERENCES planets (planetName, systemName)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (destinationPlanet, destinationSystem) REFERENCES planets (planetName, systemName)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (cabinNumber, side, letter) REFERENCES cabins (cabinNumber, side, letter)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

# FIXME: expenses referential structure is not clear
CREATE TABLE expenses
(
    passengerId INT,
    facility    VARCHAR(100),
    amount      DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (passengerId, facility),
    FOREIGN KEY (passengerId) REFERENCES passengers (passengerId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (facility) REFERENCES entertainment (facility)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE cabins
(
    cabinNumber INT             NOT NULL,
    side        ENUM ('P', 'S') NOT NULL,
    letter      CHAR(1)         NOT NULL,
    robotId     INT,
    PRIMARY KEY (cabinNumber, side, letter),
    FOREIGN KEY (letter) REFERENCES decks (letter)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (robotId) REFERENCES robots (robotId)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE decks
(
    letter CHAR(1) PRIMARY KEY,
    class  ENUM ('Primera', 'Segunda', 'Tercera') NOT NULL
);

CREATE TABLE robots
(
    robotId INT PRIMARY KEY AUTO_INCREMENT,
    design  VARCHAR(100) NOT NULL
);

CREATE TABLE mechanics
(
    mechanicId INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(100) NOT NULL
);

CREATE TABLE breakdowns
(
    robotId    INT  NOT NULL,
    mechanicId INT  NOT NULL,
    date       DATE NOT NULL,
    PRIMARY KEY (robotId, mechanicId, date),
    FOREIGN KEY (robotId) REFERENCES robots (robotId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (mechanicId) REFERENCES mechanics (mechanicId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE planets
(
    planetName VARCHAR(100),
    systemName VARCHAR(100),
    mass       DECIMAL(20, 5) NOT NULL,
    radius     DECIMAL(20, 5) NOT NULL,
    PRIMARY KEY (planetName, systemName)
);

CREATE TABLE satellites
(
    satelliteName VARCHAR(100),
    planetName    VARCHAR(100),
    systemName    VARCHAR(100),
    PRIMARY KEY (satelliteName, planetName, systemName),
    FOREIGN KEY (planetName, systemName) REFERENCES planets (planetName, systemName)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE elements
(
    elementName VARCHAR(100) PRIMARY KEY,
    symbol      CHAR(2)        NOT NULL,
    weight      DECIMAL(10, 5) NOT NULL
);

CREATE TABLE atmospheres
(
    elementName VARCHAR(100),
    planetName  VARCHAR(100),
    systemName  VARCHAR(100),
    PRIMARY KEY (elementName, planetName, systemName),
    FOREIGN KEY (elementName) REFERENCES elements (elementName)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (planetName, systemName) REFERENCES planets (planetName, systemName)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE staff
(
    staffId  INT PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    facility VARCHAR(100),
    bossId   INT,
    FOREIGN KEY (facility) REFERENCES entertainment (facility)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (bossId) REFERENCES staff (staffId)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE entertainment
(
    facility VARCHAR(100) PRIMARY KEY
);
