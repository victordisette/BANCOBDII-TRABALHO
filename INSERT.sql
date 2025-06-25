
-- Estados
INSERT INTO Estados (nome, sigla) VALUES
('Pernambuco', 'PE'),
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Paraná', 'PR'),
('Rio Grande do Sul', 'RS'),
('Amazonas', 'AM'),
('Distrito Federal', 'DF'),
('Santa Catarina', 'SC'),
('Goiás', 'GO'),
('Pará', 'PA'),
('Espírito Santo', 'ES'),
('Rio Grande do Norte', 'RN');

-- Cidades
INSERT INTO Cidades (nome, idEstado) VALUES
('Recife', 1),
('Olinda', 1),
('Caruaru', 1),
('São Paulo', 2),
('Campinas', 2),
('Rio de Janeiro', 3),
('Niterói', 3),
('Belo Horizonte', 4),
('Uberlândia', 4),
('Salvador', 5),
('Fortaleza', 6),
('Curitiba', 7),
('Porto Alegre', 8),
('Manaus', 9),
('Brasília', 10),
('Florianópolis', 11),
('Goiânia', 12),
('Belém', 13),
('Vitória', 14),
('Natal', 15);

-- Endereços
INSERT INTO Enderecos (rua, numero, complemento, bairro, cep, idCidade) VALUES
('Av. Boa Viagem', '1000', NULL, 'Boa Viagem', '51020-000', 1),
('Rua da Aurora', '500', 'Apto 201', 'Santo Amaro', '50050-000', 1),
('Rua Quinze', '45', NULL, 'Centro', '55000-000', 3),
('Av. Paulista', '1500', 'Bloco A', 'Bela Vista', '01311-000', 4),
('Rua das Flores', '320', NULL, 'Centro', '13050-000', 5),
('Rua das Laranjeiras', '200', NULL, 'Laranjeiras', '22240-060', 6),
('Av. Roberto Silveira', '654', 'Sala 3', 'Icaraí', '24230-000', 7),
('Rua da Bahia', '300', 'Fundos', 'Centro', '30160-010', 8),
('Av. Rondon Pacheco', '900', NULL, 'Santa Mônica', '38408-000', 9),
('Av. Sete de Setembro', '700', NULL, 'Campo Grande', '40060-110', 10),
('Av. Beira Mar', '410', NULL, 'Meireles', '60165-000', 11),
('Rua XV de Novembro', '980', NULL, 'Centro', '80020-000', 12),
('Av. Ipiranga', '777', NULL, 'Centro Histórico', '90035-000', 13),
('Av. Djalma Batista', '222', NULL, 'Chapada', '69050-001', 14),
('Eixo Monumental', '100', NULL, 'Asa Norte', '70040-000', 15),
('Rua Felipe Schmidt', '123', 'Sala 501', 'Centro', '88010-000', 16),
('Av. Tocantins', '456', NULL, 'Setor Oeste', '74110-110', 17),
('Travessa Quintino Bocaiúva', '789', NULL, 'Reduto', '66035-190', 18),
('Rua José Marcelino', '321', NULL, 'Centro', '29010-060', 19),
('Av. Nevaldo Rocha', '654', NULL, 'Tirol', '59015-350', 20);

-- Compositores
INSERT INTO Compositores (nome, dataNascimento, dataFalecimento, nacionalidade, biografia) VALUES
('Ludwig van Beethoven', '1770-12-17', '1827-03-26', 'Alemã', 'Compositor alemão, figura crucial na transição entre as eras clássica e romântica.'),
('Wolfgang Amadeus Mozart', '1756-01-27', '1791-12-05', 'Austríaca', 'Prodígio musical que compôs mais de 600 obras em sua curta vida.'),
('Johann Sebastian Bach', '1685-03-31', '1750-07-28', 'Alemã', 'Compositor barroco conhecido por sua complexidade técnica e profundidade intelectual.'),
('Heitor Villa-Lobos', '1887-03-05', '1959-11-17', 'Brasileira', 'Maior expoente da música erudita brasileira, com obras que incorporam elementos folclóricos.'),
('Antonio Vivaldi', '1678-03-04', '1741-07-28', 'Italiana', 'Compositor barroco conhecido por "As Quatro Estações".'),
('Franz Schubert', '1797-01-31', '1828-11-19', 'Austríaca', 'Compositor romântico conhecido por suas canções (lieder) e sinfonias.'),
('Johannes Brahms', '1833-05-07', '1897-04-03', 'Alemã', 'Compositor romântico que combinou tradição clássica com inovação.'),
('Frédéric Chopin', '1810-03-01', '1849-10-17', 'Polonesa', 'Compositor e pianista conhecido por suas obras para piano solo.'),
('Piotr Ilyich Tchaikovsky', '1840-05-07', '1893-11-06', 'Russa', 'Compositor romântico conhecido por balés como "O Lago dos Cisnes".'),
('Claude Debussy', '1862-08-22', '1918-03-25', 'Francesa', 'Pioneiro do impressionismo musical.'),
('Carlos Gomes', '1836-07-11', '1896-09-16', 'Brasileira', 'Maior compositor de óperas brasileiro, autor de "O Guarani".'),
('Igor Stravinsky', '1882-06-17', '1971-04-06', 'Russa', 'Compositor revolucionário do século XX, autor de "A Sagração da Primavera".'),
('Richard Wagner', '1813-05-22', '1883-02-13', 'Alemã', 'Compositor conhecido por suas óperas e pelo conceito de "obra de arte total".'),
('Gustav Mahler', '1860-07-07', '1911-05-18', 'Austríaca', 'Compositor romântico tardio conhecido por suas grandiosas sinfonias.'),
('Sergei Rachmaninoff', '1873-04-01', '1943-03-28', 'Russa', 'Compositor e pianista conhecido por suas obras virtuosísticas para piano.');

-- Instrumentos
INSERT INTO Instrumentos (nome, tipo, descricao, dataCriacao) VALUES
('Violino', 'Cordas', 'Instrumento de cordas friccionadas com quatro cordas.', '1500-01-01'),
('Violoncelo', 'Cordas', 'Instrumento de cordas friccionadas, maior que o violino, tocado entre as pernas.', '1500-01-01'),
('Piano', 'Teclas', 'Instrumento de teclas que produz som por meio de martelos que batem nas cordas.', '1700-01-01'),
('Flauta Transversal', 'Sopro', 'Instrumento de sopro feito de metal ou madeira, tocado horizontalmente.', '1500-01-01'),
('Trompete', 'Metais', 'Instrumento de sopro de metal com três pistões.', '1500-01-01'),
('Tímpano', 'Percussão', 'Tipo de tambor com pele esticada sobre uma grande calota de cobre.', '1600-01-01'),
('Oboé', 'Sopro', 'Instrumento de sopro de palheta dupla, feito de madeira.', '1600-01-01'),
('Clarinete', 'Sopro', 'Instrumento de sopro de palheta simples, com corpo cilíndrico.', '1700-01-01'),
('Contrabaixo', 'Cordas', 'Maior e mais grave dos instrumentos de cordas da família do violino.', '1600-01-01'),
('Harpa', 'Cordas Dedilhadas', 'Instrumento de cordas pinçadas com uma estrutura triangular.', '1500-01-01'),
('Fagote', 'Sopro', 'Instrumento de sopro de palheta dupla, com tubo longo dobrado.', '1600-01-01'),
('Trombone', 'Metais', 'Instrumento de sopro de metal com vara deslizante para alterar a altura.', '1500-01-01'),
('Violão', 'Cordas Dedilhadas', 'Instrumento de cordas dedilhadas, similar à guitarra.', '1700-01-01');

-- Músicos
INSERT INTO Musicos (nome, dataNascimento, telefone, email, idEndereco, genero, status, foto) VALUES
('Ana Lúcia', '1990-07-12', '81999990000', 'ana.lucia@email.com', 2, 'Feminino', 'Ativo', NULL),
('Carlos Silva', '1985-03-22', '81988880000', 'carlos.silva@email.com', 1, 'Masculino', 'Ativo', NULL),
('Maria Souza', '1992-11-10', '81977770000', 'maria.souza@email.com', 3, 'Feminino', 'Ativo', NULL),
('João Pereira', '1980-01-05', '81966660000', 'joao.pereira@email.com', 1, 'Masculino', 'Ativo', NULL),
('Fernanda Alves', '1988-06-18', '81955550000', 'fernanda.alves@email.com', 2, 'Feminino', 'Inativo', NULL),
('Paulo Santos', '1995-09-30', '81944440000', 'paulo.santos@email.com', 3, 'Masculino', 'Ativo', NULL),
('Lucas Oliveira', '1987-04-12', '81933330000', 'lucas.oliveira@email.com', 2, 'Masculino', 'Ativo', NULL),
('Juliana Costa', '1991-02-25', '81922220000', 'juliana.costa@email.com', 3, 'Feminino', 'Ativo', NULL),
('Marcos Lima', '1983-12-15', '81911110000', 'marcos.lima@email.com', 1, 'Masculino', 'Ativo', NULL),
('Patrícia Gomes', '1994-08-08', '81900000000', 'patricia.gomes@email.com', 2, 'Feminino', 'Ativo', NULL);

-- Orquestras
INSERT INTO Orquestras (nome, anoCriacao, dataFundacao, idEndereco, email, ativo, website) VALUES
('Orquestra Sinfônica de Pernambuco', 1980, '1980-05-20', 1, 'contato@sinfpe.com', 'Sim', 'www.sinfpe.com'),
('Orquestra Filarmônica de São Paulo', 1970, '1970-08-15', 4, 'contato@ofilsp.com', 'Sim', 'www.ofilsp.com'),
('Orquestra Jovem do Recife', 1995, '1995-03-10', 2, 'contato@ojr.com', 'Sim', 'www.ojr.com'),
('Orquestra de Câmara do Rio', 1985, '1985-06-25', 6, 'contato@ocri.com', 'Sim', 'www.ocri.com'),
('Orquestra Brasileira de Música', 2000, '2000-11-05', 3, 'contato@obm.com', 'Sim', 'www.obm.com');

-- Músicos_Instrumentos
INSERT INTO Musicos_Instrumentos (idMusico, idInstrumento, instrumentoPrincipal, dataInicio, nivelProficiencia) VALUES
(1, 1, TRUE, '2005-01-01', 'Avançado'),
(2, 3, TRUE, '2003-05-15', 'Intermediário'),
(3, 4, FALSE, '2010-03-20', 'Básico'),
(4, 2, TRUE, '2000-07-10', 'Avançado'),
(5, 5, FALSE, '2012-11-01', 'Intermediário'),
(6, 1, TRUE, '2015-09-25', 'Básico'),
(7, 6, FALSE, '2018-06-15', 'Intermediário'),
(8, 7, TRUE, '2011-04-12', 'Avançado'),
(9, 8, FALSE, '2013-10-30', 'Básico'),
(10, 9, TRUE, '2016-01-05', 'Avançado');

-- Músicos_Orquestras
INSERT INTO Musicos_Orquestras (idMusico, idOrquestra, dataEntrada, dataSaida, cargo, salario) VALUES
(1, 1, '2010-01-01', NULL, 'Violinista', 3500.00),
(2, 2, '2005-03-20', '2015-12-31', 'Pianista', 4000.00),
(3, 3, '2012-07-15', NULL, 'Flautista', 3200.00),
(4, 4, '2000-08-10', '2010-06-30', 'Cellista', 3700.00),
(5, 1, '2013-09-05', NULL, 'Trompetista', 3000.00),
(6, 2, '2016-02-20', NULL, 'Violinista', 3300.00),
(7, 3, '2018-07-10', NULL, 'Timpanista', 2900.00),
(8, 4, '2011-05-18', NULL, 'Oboísta', 3100.00),
(9, 5, '2014-10-22', NULL, 'Clarinete', 2800.00),
(10, 1, '2017-01-11', NULL, 'Contrabaixista', 3600.00);

-- Sinfonias
INSERT INTO Sinfonias (nome, anoComposicao, duracao, idCompositor, dificuldade) VALUES
('Sinfonia nº 5', 1808, 33, 1, 'Alta'),
('As Quatro Estações', 1725, 42, 5, 'Média'),
('Concerto para Piano nº 21', 1785, 30, 2, 'Alta'),
('Bach: Suíte para Violoncelo', 1720, 25, 3, 'Média'),
('Bach: Tocata e Fuga', 1704, 15, 3, 'Alta'),
('Villa-Lobos: Bachianas Brasileiras', 1930, 35, 4, 'Alta'),
('Sinfonia nº 9', 1824, 70, 1, 'Muito Alta'),
('Sinfonia nº 40', 1788, 35, 2, 'Alta'),
('Concerto para Violino em D Maior', 1775, 28, NULL, 'Média');

-- Eventos
INSERT INTO Eventos (nome, data, horario, idEndereco, descricao, precoIngresso, capacidade, classificacaoEtaria) VALUES
('Concerto de Primavera', '2025-09-21', '19:00', 1, 'Concerto clássico com orquestra sinfônica.', 50.00, 500, 'Livre'),
('Festival de Música Brasileira', '2025-10-10', '20:30', 2, 'Evento com foco em compositores brasileiros.', 40.00, 300, 'Livre'),
('Noite do Jazz', '2025-11-05', '21:00', 3, 'Jazz e música instrumental.', 60.00, 400, '16+'),
('Concerto de Natal', '2025-12-24', '20:00', 1, 'Concerto temático de natal.', 55.00, 450, 'Livre'),
('Festival Internacional de Música', '2026-01-15', '18:00', 4, 'Evento com orquestras internacionais.', 80.00, 600, 'Livre');

-- Eventos_Compositores
INSERT INTO Eventos_Compositores (idEvento, idCompositor) VALUES
(1, 1),
(1, 2),
(2, 4),
(3, 10),
(4, 4),
(5, 12);

-- Eventos_Orquestras
INSERT INTO Eventos_Orquestras (idEvento, idOrquestra, cache) VALUES
(1, 1, 5000.00),
(2, 3, 3000.00),
(3, 2, 4000.00),
(4, 1, 4500.00),
(5, 4, 6000.00);

-- Repertórios
INSERT INTO Repertorios (idEvento, idSinfonia, ordemExecucao, maestro) VALUES
(1, 1, 1, 'Carlos Eduardo'),
(1, 2, 2, 'Carlos Eduardo'),
(2, 6, 1, 'Fernanda Lima'),
(3, 10, 1, 'João Silva'),
(4, 4, 1, 'Maria Santos'),
(5, 7, 1, 'Pedro Henrique');

-- Prêmios
INSERT INTO Premios (nome, ano, idCompositor, descricao) VALUES
('Prêmio Melhor Compositor', 2019, 4, 'Reconhecimento pelo trabalho inovador na música brasileira.'),
('Prêmio Internacional de Música Clássica', 2015, 1, 'Premiação por excelência em composição.'),
('Prêmio Jovem Talento', 2020, 2, 'Reconhecimento a jovens compositores.');

-- Patrocinadores
INSERT INTO Patrocinadores (nome, valorPatrocinio, idOrquestra, dataInicio, dataFim) VALUES
('Banco do Brasil', 50000.00, 1, '2020-01-01', '2025-12-31'),
('Petrobras', 75000.00, 2, '2018-06-01', '2023-06-01'),
('Vale', 60000.00, 3, '2019-03-15', '2024-03-15');
