DROP TABLE IF EXISTS emprestimo_livro;
DROP TABLE IF EXISTS emprestimo;
DROP TABLE IF EXISTS livro;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS autor;
DROP TABLE IF EXISTS editora;

CREATE TABLE autor (
id_autor SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL
);
CREATE TABLE livro (
id_livro SERIAL PRIMARY KEY,
titulo VARCHAR(150) NOT NULL,
ano_publicacao INT,
id_autor INT REFERENCES autor(id_autor)
);
CREATE TABLE aluno (
id_aluno SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
curso VARCHAR(100) NOT NULL
);
CREATE TABLE emprestimo (
id_emprestimo SERIAL PRIMARY KEY,
data_emprestimo DATE NOT NULL,
id_aluno INT REFERENCES aluno(id_aluno)
);
CREATE TABLE emprestimo_livro (
id_emprestimo INT REFERENCES
emprestimo(id_emprestimo),
id_livro INT REFERENCES livro(id_livro),
PRIMARY KEY (id_emprestimo, id_livro)
);
INSERT INTO autor (nome) VALUES
('J. R. R. Tolkien'), ('Machado de Assis'),
('Clarice Lispector'), ('J.K. Rowling');
INSERT INTO livro (titulo, ano_publicacao,
id_autor) VALUES
('O Senhor dos Anéis', 1954, 1),
('Dom Casmurro', 1899, 2),
('A Hora da Estrela', 1977, 3),
('O Hobbit', 1937, 1);
INSERT INTO aluno (nome, curso) VALUES
('Ana Souza', 'Sistemas de Informação'),
('Bruno Silva', 'Engenharia de Software');
INSERT INTO emprestimo (data_emprestimo, id_aluno) VALUES
('2025-08-20', 1),
('2025-08-21', 2);
INSERT INTO emprestimo_livro (id_emprestimo, id_livro) VALUES
(1, 1), -- Ana Souza pegou O Senhor dos Anéis
(1, 2), -- Ana Souza pegou Dom Casmurro
(2, 3); -- Bruno Silva pegou A Hora da Estrela
CREATE TABLE editora (
id_editora SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cidade VARCHAR(100)
);
ALTER TABLE livro
ADD COLUMN id_editora INT;
ALTER TABLE livro
ADD CONSTRAINT fk_livro_editora
FOREIGN KEY (id_editora)
REFERENCES editora(id_editora);
INSERT INTO editora (nome, cidade) VALUES
('Companhia das Letras', 'São Paulo'),
('Saraiva', 'São Paulo'),
('Atlas', 'Rio de Janeiro');
UPDATE livro
SET id_editora = 1
WHERE titulo = 'O Senhor dos Anéis';
UPDATE livro
SET id_editora = 2
WHERE titulo = 'Dom Casmurro';
UPDATE livro
SET id_editora = 3
WHERE titulo = 'A Hora da Estrela';
UPDATE livro
SET id_editora = 1
WHERE titulo = 'O Hobbit';

ALTER TABLE livro
ADD COLUMN num_paginas INT;
UPDATE livro
SET num_paginas = 1568
WHERE titulo = 'O Senhor dos Anéis';
UPDATE livro
SET num_paginas = 208
WHERE titulo = 'Dom Casmurro';
UPDATE livro
SET num_paginas = 88
WHERE titulo = 'A Hora da Estrela';
UPDATE livro
SET num_paginas = 336
WHERE titulo = 'O Hobbit';

-- EXERCICIO 1 --
-- Consulta Escalar --
SELECT
        a.nome,
        (SELECT COUNT(*) FROM livro l WHERE a.id_autor = l.id_autor) AS quantidade_livros,
        (SELECT AVG(l.num_paginas) from livro l WHERE a.id_autor = l.id_autor) AS media_paginas
    FROM autor a;

-- CTE --

WITH estatisticas_autor AS (
    SELECT
        l.id_autor,
        COUNT(*) AS quantidade_livros,
        AVG(l.num_paginas) AS media_paginas
    FROM livro l
    GROUP BY l.id_autor
)
SELECT
    a.nome,
    ea.quantidade_livros AS quantidade_livros,
    ea.media_paginas AS media_paginas
FROM autor a
LEFT JOIN estatisticas_autor ea
    ON a.id_autor = ea.id_autor;

-- EXERCICIO 2 --

WITH livro_estatistica AS (
	SELECT l.id_autor, SUM(l.num_paginas) AS paginas_por_autor
	FROM livro l
	GROUP BY l.id_autor
)
SELECT a.nome, le.paginas_por_autor
FROM autor a
LEFT JOIN livro_estatistica le
ON a.id_autor = le.id_autor
WHERE le.paginas_por_autor > (SELECT AVG(num_paginas) FROM livro);

-- EXERCICIO 3 --

-- Listar as editoras que publicaram uma quantidade total de páginas maior do que a média geral de páginas publicadas por editora na biblioteca --

-- Subconsulta Correlacionada --
SELECT
    ed.nome,
    (
        SELECT SUM(l.num_paginas)
        FROM livro l
        WHERE l.id_editora = ed.id_editora
    ) AS paginas_por_editora
FROM editora ed
WHERE (
    SELECT SUM(l.num_paginas)
    FROM livro l
    WHERE l.id_editora = ed.id_editora
) > (
    SELECT AVG(total_paginas)
    FROM (
        SELECT SUM(l2.num_paginas) AS total_paginas
        FROM editora ed2
        LEFT JOIN livro l2 ON ed2.id_editora = l2.id_editora
        GROUP BY ed2.id_editora
    ) sub_media
);

-- CTE --
WITH soma AS (
    SELECT l.id_editora, SUM(l.num_paginas) AS soma
    FROM livro l
    GROUP BY l.id_editora
),
estatistica_geral AS (
    SELECT AVG(s.soma) AS media_total
    FROM soma s
)
SELECT
    ed.nome, s.soma
FROM editora ed
CROSS JOIN estatistica_geral eg
JOIN soma s ON ed.id_editora = s.id_editora
WHERE s.soma > eg.media_total;