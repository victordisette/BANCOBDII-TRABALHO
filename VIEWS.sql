CREATE VIEW vw_instrumentos_popularidade AS
SELECT i.*, 
       COUNT(DISTINCT mi.idMusico) AS qtd_musicos,
       COUNT(DISTINCT mo.idOrquestra) AS qtd_orquestras
FROM Instrumentos i
LEFT JOIN Musicos_Instrumentos mi ON i.idInstrumento = mi.idInstrumento
LEFT JOIN Musicos_Orquestras mo ON mi.idMusico = mo.idMusico AND mo.dataSaida IS NULL
GROUP BY i.idInstrumento;

CREATE VIEW vw_musicos_faixa_etaria AS
SELECT 
    CASE 
        WHEN idade < 25 THEN '18-24'
        WHEN idade BETWEEN 25 AND 35 THEN '25-35'
        WHEN idade BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS faixa,
    COUNT(*) AS qtd_musicos
FROM (
    SELECT TIMESTAMPDIFF(YEAR, dataNascimento, CURDATE()) AS idade
    FROM Musicos
) AS idades
GROUP BY faixa;

CREATE VIEW vw_eventos_por_regiao AS
SELECT es.nome AS estado, es.sigla,
       COUNT(e.idEvento) AS qtd_eventos
FROM Eventos e
JOIN Enderecos en ON e.idEndereco = en.idEndereco
JOIN Cidades ci ON en.idCidade = ci.idCidade
JOIN Estados es ON ci.idEstado = es.idEstado
GROUP BY es.idEstado;


CREATE VIEW vw_historico_musicos AS
SELECT m.nome AS musico, o.nome AS orquestra,
       mo.dataEntrada, mo.dataSaida, mo.salario
FROM Musicos m
JOIN Musicos_Orquestras mo ON m.idMusico = mo.idMusico
JOIN Orquestras o ON mo.idOrquestra = o.idOrquestra
ORDER BY m.nome, mo.dataEntrada;


CREATE VIEW vw_composicoes_por_periodo AS
SELECT 
    CASE 
        WHEN anoComposicao < 1750 THEN 'Barroco'
        WHEN anoComposicao BETWEEN 1750 AND 1820 THEN 'Clássico'
        WHEN anoComposicao BETWEEN 1820 AND 1900 THEN 'Romântico'
        ELSE 'Moderno'
    END AS periodo,
    COUNT(*) AS qtd_composicoes
FROM Sinfonias
GROUP BY periodo;


CREATE VIEW vw_patrocinios_ativos AS
SELECT p.*, o.nome AS orquestra
FROM Patrocinadores p
JOIN Orquestras o ON p.idOrquestra = o.idOrquestra
WHERE p.dataFim IS NULL OR p.dataFim >= CURDATE();

CREATE VIEW vw_eventos_futuros AS
SELECT e.nome, e.data, e.horario, ci.nome AS cidade, es.nome AS estado
FROM Eventos e
JOIN Enderecos en ON e.idEndereco = en.idEndereco
JOIN Cidades ci ON en.idCidade = ci.idCidade
JOIN Estados es ON ci.idEstado = es.idEstado
WHERE e.data >= CURDATE()
ORDER BY e.data;

CREATE VIEW vw_orquestras_por_cidade AS
SELECT ci.nome AS cidade, COUNT(o.idOrquestra) AS qtd_orquestras
FROM Orquestras o
JOIN Enderecos en ON o.idEndereco = en.idEndereco
JOIN Cidades ci ON en.idCidade = ci.idCidade
GROUP BY ci.idCidade
ORDER BY qtd_orquestras DESC;

CREATE VIEW vw_top_compositores AS
SELECT c.nome, COUNT(s.idSinfonia) AS qtd_composicoes
FROM Compositores c
LEFT JOIN Sinfonias s ON c.idCompositor = s.idCompositor
GROUP BY c.idCompositor
ORDER BY qtd_composicoes DESC
LIMIT 10;

CREATE VIEW vw_repertorio_por_orquestra AS
SELECT o.nome AS orquestra, s.nome AS sinfonia, c.nome AS compositor,
       COUNT(r.idSinfonia) AS vezes_executada
FROM Orquestras o
JOIN Eventos_Orquestras eo ON o.idOrquestra = eo.idOrquestra
JOIN Repertorios r ON eo.idEvento = r.idEvento
JOIN Sinfonias s ON r.idSinfonia = s.idSinfonia
JOIN Compositores c ON s.idCompositor = c.idCompositor
GROUP BY o.idOrquestra, s.idSinfonia
ORDER BY o.nome, vezes_executada DESC;




