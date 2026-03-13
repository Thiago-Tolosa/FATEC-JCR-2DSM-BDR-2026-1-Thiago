select count(idUsuario) as Quant_Usuarios
from Usuario;

select te.nome , count(e.idEvento) as Quant_Eventos
from Evento e, TipoEvento te
where e.idTipoEvento = te.idTipoEvento
group by te.nome;

select min(dataHora) as eventoMaisAntigo, max(dataHora) as eventoMaisRecente
from Evento;

select avg(quant) as mediaPorCidade
from (
select l.cidade, count(e.idEvento) as quant
from localizacao l, evento e
where l.idLocalizacao = e.idLocalizacao
group by l.cidade ) as quantPorCidade;