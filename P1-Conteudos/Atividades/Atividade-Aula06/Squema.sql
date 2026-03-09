insert into Evento (titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao)
values
(
 'Queimada próxima à rodovia',
 'Fogo em vegetação seca às margens da estrada.',
 '2025-11-10 16:00:00',
 'Ativo',
 (select idTipoEvento from TipoEvento where nome = 'Queimada'),
 (select idLocalizacao from Localizacao where cidade = 'Jacareí')
),
(
 'Enchente em avenida central',
 'Alagamento após chuva forte durante a tarde.',
 '2025-11-12 18:30:00',
 'Ativo',
 (select idTipoEvento from TipoEvento where nome = 'Enchente'),
 (select idLocalizacao from Localizacao where cidade = 'São Paulo')
);

select titulo, dataHora, status from Evento order by dataHora desc;

select titulo, dataHora, status from Evento order by dataHora desc limit 3;