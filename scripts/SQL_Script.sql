
CREATE TABLE Comunidad (
    ID_Comunidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100)
);

CREATE TABLE Provincia (
    ID_Provincia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_Comunidad INT,
    Nombre VARCHAR(100),
    FOREIGN KEY (ID_Comunidad) REFERENCES Comunidad(ID_Comunidad)
);

CREATE TABLE Partido (
    ID_Partido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Siglas VARCHAR(20)
);

CREATE TABLE Elecciones (
    ID_Elecciones INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Anio INT,
    Tipo VARCHAR(50)
);

CREATE TABLE Resultados (
    ID_Elecciones INT,
    ID_Provincia INT,
    ID_Partido INT,
    Votos INT,
    PRIMARY KEY (ID_Elecciones, ID_Provincia, ID_Partido),
    FOREIGN KEY (ID_Elecciones) REFERENCES Elecciones(ID_Elecciones),
    FOREIGN KEY (ID_Provincia) REFERENCES Provincia(ID_Provincia),
    FOREIGN KEY (ID_Partido) REFERENCES Partido(ID_Partido)
);

CREATE TABLE Diputados (
    ID_Elecciones INT,
    ID_Partido INT,
    Diputados INT,
    PRIMARY KEY (ID_Elecciones, ID_Partido),
    FOREIGN KEY (ID_Elecciones) REFERENCES Elecciones(ID_Elecciones),
    FOREIGN KEY (ID_Partido) REFERENCES Partido(ID_Partido)
);

CREATE TABLE Votantes (
    ID_Elecciones INT,
    ID_Provincia INT,
    Poblacion INT,
    Numero_Mesas INT,
    Censo_Sin_CERA INT,
    Censo_CERA INT,
    Total_Censo_Electoral INT,
    Solicitudes_CERA_Aceptadas INT,
	Total_Votantes_CER INT,
	Total_Votantes_CERA INT,
    Total_Votantes INT,
    Votos_Validos INT,
    Votos_Candidaturas INT,
    Votos_Blanco INT,
    Votos_Nulos INT,
    PRIMARY KEY (ID_Elecciones, ID_Provincia),
    FOREIGN KEY (ID_Elecciones) REFERENCES Elecciones(ID_Elecciones),
    FOREIGN KEY (ID_Provincia) REFERENCES Provincia(ID_Provincia)
);


