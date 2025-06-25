SELECT m.nome AS Musico, COUNT(mi.idInstrumento) AS Qtd_Instrumentos
FROM Musicos m
JOIN Musicos_Instrumentos mi ON m.idMusico = mi.idMusico
GROUP BY m.idMusico
HAVING COUNT(mi.idInstrumento) > 1
ORDER BY Qtd_Instrumentos DESC;

SELECT o.nome AS Orquestra, COUNT(mo.idMusico) AS Total_Musicos
FROM Orquestras o
JOIN Musicos_Orquestras mo ON o.idOrquestra = mo.idOrquestra
WHERE mo.dataSaida IS NULL
GROUP BY o.idOrquestra
ORDER BY Total_Musicos DESC;

SELECT s.nome AS Sinfonia, c.nome AS Compositor, COUNT(r.idSinfonia) AS Execucoes
FROM Sinfonias s
JOIN Compositores c ON s.idCompositor = c.idCompositor
JOIN Repertorios r ON s.idSinfonia = r.idSinfonia
GROUP BY s.idSinfonia
ORDER BY Execucoes DESC
LIMIT 10;

SELECT m.nome AS Musico, COUNT(DISTINCT mo.idOrquestra) AS Qtd_Orquestras
FROM Musicos m
JOIN Musicos_Orquestras mo ON m.idMusico = mo.idMusico
GROUP BY m.idMusico
HAVING COUNT(DISTINCT mo.idOrquestra) > 1
ORDER BY Qtd_Orquestras DESC;

SELECT e.nome AS Evento, e.data, 
       SUM(e.precoIngresso * e.capacidade) AS Arrecadacao_Potencial,
       GROUP_CONCAT(DISTINCT o.nome SEPARATOR ', ') AS Orquestras
FROM Eventos e
JOIN Eventos_Orquestras eo ON e.idEvento = eo.idEvento
JOIN Orquestras o ON eo.idOrquestra = o.idOrquestra
GROUP BY e.idEvento
ORDER BY Arrecadacao_Potencial DESC;

SELECT o.nome AS Orquestra, m.nome AS Musico, mo.salario,
       i.nome AS Instrumento_Principal
FROM Orquestras o
JOIN Musicos_Orquestras mo ON o.idOrquestra = mo.idOrquestra
JOIN Musicos m ON mo.idMusico = m.idMusico
JOIN Musicos_Instrumentos mi ON m.idMusico = mi.idMusico AND mi.instrumentoPrincipal = TRUE
JOIN Instrumentos i ON mi.idInstrumento = i.idInstrumento
WHERE mo.dataSaida IS NULL
ORDER BY o.nome, mo.salario DESC;

SELECT 
    CASE 
        WHEN s.anoComposicao < 1750 THEN 'Barroco'
        WHEN s.anoComposicao BETWEEN 1750 AND 1820 THEN 'Clássico'
        WHEN s.anoComposicao BETWEEN 1820 AND 1900 THEN 'Romântico'
        ELSE 'Moderno'
    END AS Periodo,
    COUNT(*) AS Total_Sinfonias,
    GROUP_CONCAT(DISTINCT c.nome SEPARATOR ', ') AS Compositores
FROM Sinfonias s
JOIN Compositores c ON s.idCompositor = c.idCompositor
GROUP BY Periodo
ORDER BY MIN(s.anoComposicao);

SELECT 
    i.nome AS Instrumento,
    FLOOR(AVG(YEAR(CURDATE()) - YEAR(m.dataNascimento))) AS Media_Idade,
    COUNT(DISTINCT m.idMusico) AS Total_Musicos
FROM Instrumentos i
JOIN Musicos_Instrumentos mi ON i.idInstrumento = mi.idInstrumento
JOIN Musicos m ON mi.idMusico = m.idMusico
GROUP BY i.idInstrumento
ORDER BY Media_Idade DESC;

SELECT 
    i.nome AS Instrumento,
    FLOOR(AVG(YEAR(CURDATE()) - YEAR(m.dataNascimento))) AS Media_Idade,
    COUNT(DISTINCT m.idMusico) AS Total_Musicos
FROM Instrumentos i
JOIN Musicos_Instrumentos mi ON i.idInstrumento = mi.idInstrumento
JOIN Musicos m ON mi.idMusico = m.idMusico
GROUP BY i.idInstrumento
ORDER BY Media_Idade DESC;

SELECT o.nome AS Orquestra, COUNT(DISTINCT mi.idInstrumento) AS Diversidade_Instrumental
FROM Orquestras o
JOIN Musicos_Orquestras mo ON o.idOrquestra = mo.idOrquestra
JOIN Musicos_Instrumentos mi ON mo.idMusico = mi.idMusico
WHERE mo.dataSaida IS NULL
GROUP BY o.idOrquestra
ORDER BY Diversidade_Instrumental DESC;

SELECT 
    m.nome AS Musico,
    MIN(mo.salario) AS Salario_Inicial,
    MAX(mo.salario) AS Salario_Atual,
    ROUND((MAX(mo.salario) - MIN(mo.salario)) / MIN(mo.salario) * 100, 2) AS Percentual_Aumento
FROM Musicos m
JOIN Musicos_Orquestras mo ON m.idMusico = mo.idMusico
GROUP BY m.idMusico
HAVING COUNT(mo.idOrquestra) > 1
ORDER BY Percentual_Aumento DESC;


SELECT 
    e.nome AS Estado,
    c.nome AS Compositor,
    COUNT(DISTINCT r.idEvento) AS Total_Execucoes
FROM Compositores c
JOIN Sinfonias s ON c.idCompositor = s.idCompositor
JOIN Repertorios r ON s.idSinfonia = r.idSinfonia
JOIN Eventos ev ON r.idEvento = ev.idEvento
JOIN Enderecos en ON ev.idEndereco = en.idEndereco
JOIN Cidades ci ON en.idCidade = ci.idCidade
JOIN Estados e ON ci.idEstado = e.idEstado
GROUP BY e.idEstado, c.idCompositor
ORDER BY e.nome, Total_Execucoes DESC;


SELECT i.nome AS Instrumento, COUNT(DISTINCT mo.idMusico) AS Total_Musicos
FROM Instrumentos i
LEFT JOIN Musicos_Instrumentos mi ON i.idInstrumento = mi.idInstrumento
LEFT JOIN Musicos_Orquestras mo ON mi.idMusico = mo.idMusico AND mo.dataSaida IS NULL
GROUP BY i.idInstrumento
ORDER BY Total_Musicos ASC
LIMIT 5;

SELECT 
    MONTHNAME(e.data) AS Mes,
    COUNT(e.idEvento) AS Total_Eventos,
    SUM(e.precoIngresso * e.capacidade) AS Arrecadacao_Estimada
FROM Eventos e
GROUP BY Mes, MONTH(e.data)
ORDER BY MONTH(e.data);


SELECT m.nome AS Musico, c.nome AS Compositor
FROM Musicos m
JOIN Musicos_Orquestras mo ON m.idMusico = mo.idMusico
JOIN Eventos_Orquestras eo ON mo.idOrquestra = eo.idOrquestra
JOIN Repertorios r ON eo.idEvento = r.idEvento
JOIN Sinfonias s ON r.idSinfonia = s.idSinfonia
JOIN Compositores c ON s.idCompositor = c.idCompositor
GROUP BY m.idMusico, c.idCompositor
HAVING COUNT(DISTINCT s.idSinfonia) = (
    SELECT COUNT(*) 
    FROM Sinfonias 
    WHERE idCompositor = c.idCompositor
);


SELECT 
    o.nome AS Orquestra,
    COUNT(DISTINCT CASE WHEN mo.dataSaida IS NOT NULL THEN mo.idMusico END) AS Musicos_Saidos,
    COUNT(DISTINCT CASE WHEN mo.dataSaida IS NULL THEN mo.idMusico END) AS Musicos_Ativos,
    ROUND(COUNT(DISTINCT CASE WHEN mo.dataSaida IS NOT NULL THEN mo.idMusico END) / 
          NULLIF(COUNT(DISTINCT mo.idMusico), 0) * 100, 2) AS Percentual_Rotatividade
FROM Orquestras o
JOIN Musicos_Orquestras mo ON o.idOrquestra = mo.idOrquestra
GROUP BY o.idOrquestra
HAVING COUNT(DISTINCT mo.idMusico) > 10
ORDER BY Percentual_Rotatividade DESC;

SELECT 
    s.nome AS Sinfonia,
    s.duracao AS Duracao_Minutos,
    COUNT(r.idSinfonia) AS Frequencia_Eventos,
    ROUND(COUNT(r.idSinfonia) / s.duracao, 2) AS Frequencia_por_Minuto
FROM Sinfonias s
JOIN Repertorios r ON s.idSinfonia = r.idSinfonia
GROUP BY s.idSinfonia
ORDER BY Frequencia_por_Minuto DESC;

SELECT 
    m.nome AS Musico,
    GROUP_CONCAT(DISTINCT i.nome SEPARATOR ', ') AS Instrumentos_Incomuns
FROM Musicos m
JOIN Musicos_Instrumentos mi ON m.idMusico = mi.idMusico
JOIN Instrumentos i ON mi.idInstrumento = i.idInstrumento
WHERE i.idInstrumento IN (
    SELECT idInstrumento 
    FROM Musicos_Instrumentos
    GROUP BY idInstrumento
    HAVING COUNT(DISTINCT idMusico) < 3
)
GROUP BY m.idMusico
HAVING COUNT(DISTINCT mi.idInstrumento) > 0;




SELECT 
    DAYNAME(e.data) AS Dia_Semana,
    COUNT(e.idEvento) AS Total_Eventos,
    AVG(e.precoIngresso) AS Preco_Medio,
    AVG(e.capacidade) AS Lotacao_Media,
    ROUND(COUNT(e.idEvento) / (SELECT COUNT(*) FROM Eventos) * 100, 2) AS Percentual
FROM Eventos e
GROUP BY Dia_Semana, DAYOFWEEK(e.data)
ORDER BY DAYOFWEEK(e.data);

SELECT 
    s.nome AS Sinfonia,
    c.nome AS Compositor,
    CASE 
        WHEN MONTH(e.data) BETWEEN 3 AND 5 THEN 'Outono'
        WHEN MONTH(e.data) BETWEEN 6 AND 8 THEN 'Inverno'
        WHEN MONTH(e.data) BETWEEN 9 AND 11 THEN 'Primavera'
        ELSE 'Verão'
    END AS Temporada,
    COUNT(r.idSinfonia) AS Execucoes
FROM Sinfonias s
JOIN Compositores c ON s.idCompositor = c.idCompositor
JOIN Repertorios r ON s.idSinfonia = r.idSinfonia
JOIN Eventos e ON r.idEvento = e.idEvento
GROUP BY s.idSinfonia, Temporada
ORDER BY Temporada, Execucoes DESC;

SELECT 
    o.nome AS Orquestra,
    YEAR(CURDATE()) - o.anoCriacao AS Idade,
    AVG(eo.cache) AS Cache_Medio,
    COUNT(DISTINCT eo.idEvento) AS Total_Eventos,
    ROUND(AVG(e.precoIngresso), 2) AS Preco_Ingresso_Medio
FROM Orquestras o
JOIN Eventos_Orquestras eo ON o.idOrquestra = eo.idOrquestra
JOIN Eventos e ON eo.idEvento = e.idEvento
GROUP BY o.idOrquestra
ORDER BY Idade DESC;

SELECT m.nome, c.nome AS compositor
FROM Musicos m
JOIN Musicos_Orquestras mo ON m.idMusico = mo.idMusico
JOIN Eventos_Orquestras eo ON mo.idOrquestra = eo.idOrquestra
JOIN Repertorios r ON eo.idEvento = r.idEvento
JOIN Sinfonias s ON r.idSinfonia = s.idSinfonia
JOIN Compositores c ON s.idCompositor = c.idCompositor
GROUP BY m.idMusico, c.idCompositor
HAVING COUNT(DISTINCT s.idSinfonia) = (
    SELECT COUNT(*) FROM Sinfonias WHERE idCompositor = c.idCompositor
);



