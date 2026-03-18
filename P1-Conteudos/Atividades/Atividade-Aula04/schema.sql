CREATE DATABASE clima_alerta;

CREATE TABLE TipoEvento (
    idTipoEvento SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    descricao VARCHAR(255)
);

CREATE TABLE Localizacao (
    idLocalizacao SERIAL PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT,
    cidade VARCHAR(255),
    estado CHAR(2)
);

CREATE TABLE Usuario (
    idUsuario SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    senhaHash VARCHAR(255)
);

CREATE TABLE Evento (
    idEvento SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    descricao VARCHAR(255),
    dataHora TIMESTAMP,
    status VARCHAR(50),
    idTipoEvento INTEGER REFERENCES TipoEvento(idTipoEvento),
    idLocalizacao INTEGER REFERENCES Localizacao(idLocalizacao)
);

CREATE TABLE Relato (
    idRelato SERIAL PRIMARY KEY,
    texto VARCHAR(255),
    dataHora TIMESTAMP,
    idEvento INTEGER REFERENCES Evento(idEvento),
    idUsuario INTEGER REFERENCES Usuario(idUsuario)
);

CREATE TABLE Alerta (
    idAlerta SERIAL PRIMARY KEY,
    mensagem VARCHAR(255),
    dataHora TIMESTAMP,
    nivel VARCHAR(50),
    idEvento INTEGER REFERENCES Evento(idEvento)
);

INSERT INTO TipoEvento (nome, descricao)
VALUES 
(
 'Queimada',
 'Incêndio de grandes proporções em áreas urbanas ou rurais.'
);

INSERT INTO Localizacao (latitude, longitude, cidade, estado)
VALUES 
(
 -23.305,
 -45.965,
 'Jacareí',
 'SP'
);

INSERT INTO Usuario (nome, email, senhaHash)
VALUES 
(
 'Maria Oliveira',
 'maria.oliveira@email.com',
 '2b6c7f64f76b09d0a7b9e...'
);

INSERT INTO Evento
(titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
VALUES 
(
 'Queimada em área de preservação',
 'Fogo se alastrando na mata próxima à represa.',
 '2025-08-15 14:35:00',
 'Ativo',
 1,
 1
);

INSERT INTO Relato
(texto, dataHora, idEvento, idUsuario)
VALUES 
(
 'Fumaça intensa e chamas visíveis a partir da rodovia.',
 '2025-08-15 15:10:00',
 1,
 1
);

INSERT INTO Alerta
(mensagem, dataHora, nivel, idEvento)
VALUES 
(
 'Evacuação imediata da área próxima à represa.',
 '2025-08-15 15:20:00',
 'Crítico',
 1
);