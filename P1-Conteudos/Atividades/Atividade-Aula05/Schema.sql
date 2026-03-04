INSERT INTO TipoEvento (nome, descricao)
VALUES 
(
 'Queimada',
 'Incêndio de grandes proporções em áreas urbanas ou rurais.'
),
(
 'Enchente',
 'Transbordamento de rios ou acúmulo excessivo de água em áreas urbanas.'
),
(
 'Deslizamento',
 'Movimentação de terra em encostas causando risco a residências.'
);

INSERT INTO Localizacao (latitude, longitude, cidade, estado)
VALUES 
(
 -23.305,
 -45.965,
 'Jacareí',
 'SP'
),
(
 -23.5505,
 -46.6333,
 'São Paulo',
 'SP'
),
(
 -22.9068,
 -43.1729,
 'Rio de Janeiro',
 'RJ'
);

INSERT INTO Usuario (nome, email, senhaHash)
VALUES 
(
 'Maria Oliveira',
 'maria.oliveira@email.com',
 '2b6c7f64f76b09d0a7b9e...'
),
(
 'Carlos Mendes',
 'carlos.mendes@email.com',
 '8f14e45fceea167a5a36d...'
),
(
 'Ana Souza',
 'ana.souza@email.com',
 '45c48cce2e2d7fbdea1af...'
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
),
(
 'Alagamento na Marginal Tietê',
 'Vias parcialmente interditadas devido ao alto nível da água.',
 '2025-09-02 18:10:00',
 'Ativo',
 2,
 2
),
(
 'Deslizamento no Morro da Providência',
 'Queda de barreira após fortes chuvas na região.',
 '2025-10-11 09:15:00',
 'Ativo',
 3,
 3
);

INSERT INTO Relato
(texto, dataHora, idEvento, idUsuario)
VALUES 
(
 'Fumaça intensa e chamas visíveis a partir da rodovia.',
 '2025-08-15 15:10:00',
 1,
 1
),
(
 'Carros ilhados e trânsito completamente parado.',
 '2025-09-02 18:30:00',
 2,
 2
),
(
 'Casas próximas estão em risco e área foi isolada.',
 '2025-10-11 09:40:00',
 3,
 3
);

INSERT INTO Alerta
(mensagem, dataHora, nivel, idEvento)
VALUES 
(
 'Evacuação imediata da área próxima à represa.',
 '2025-08-15 15:20:00',
 'Crítico',
 1
),
(
 'Evitar a região da Marginal Tietê até normalização.',
 '2025-09-02 18:40:00',
 'Alto',
 2
),
(
 'Moradores devem procurar abrigo em local seguro.',
 '2025-10-11 09:50:00',
 'Crítico',
 3
);

SELECT idEvento, titulo, dataHora, status
FROM Evento;

SELECT idUsuario, nome, email
FROM Usuario;

SELECT titulo, dataHora
FROM Evento
WHERE status = 'Ativo';

SELECT mensagem, dataHora
FROM Alerta
WHERE nivel = 'Crítico';