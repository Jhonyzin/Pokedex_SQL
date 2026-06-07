-- ============================================================
--  POKÉDEX DATABASE — DML (INSERT INTO)
--  Disciplina: Banco de Dados — Engenharia da Computação
-- ============================================================

USE pokedex;

-- ============================================================
-- 1. TIPOS (18 registros)
-- ============================================================
INSERT INTO tipo (nome, cor_hex, descricao) VALUES
  ('Normal',   '#A8A878', 'Tipo padrão, sem pontos fracos contra a maioria dos tipos.'),
  ('Fogo',     '#F08030', 'Tipo elementar de fogo; eficaz contra Grama, Gelo, Inseto e Aço.'),
  ('Água',     '#6890F0', 'Tipo elementar de água; eficaz contra Fogo, Terra e Pedra.'),
  ('Elétrico', '#F8D030', 'Tipo elétrico; eficaz contra Água e Voador.'),
  ('Grama',    '#78C850', 'Tipo planta; eficaz contra Água, Terra e Pedra.'),
  ('Gelo',     '#98D8D8', 'Tipo gelo; eficaz contra Grama, Terra, Voador e Dragão.'),
  ('Lutador',  '#C03028', 'Tipo lutador; eficaz contra Normal, Pedra, Aço, Gelo e Sombrio.'),
  ('Veneno',   '#A040A0', 'Tipo veneno; eficaz contra Grama e Fada.'),
  ('Terra',    '#E0C068', 'Tipo terra; eficaz contra Fogo, Elétrico, Veneno, Pedra e Aço.'),
  ('Voador',   '#A890F0', 'Tipo voador; eficaz contra Grama, Lutador e Inseto.'),
  ('Psíquico', '#F85888', 'Tipo psíquico; eficaz contra Lutador e Veneno.'),
  ('Inseto',   '#A8B820', 'Tipo inseto; eficaz contra Grama, Psíquico e Sombrio.'),
  ('Pedra',    '#B8A038', 'Tipo pedra; eficaz contra Fogo, Gelo, Voador e Inseto.'),
  ('Fantasma', '#705898', 'Tipo fantasma; eficaz contra Psíquico e Fantasma.'),
  ('Dragão',   '#7038F8', 'Tipo dragão; eficaz contra outros Dragão.'),
  ('Sombrio',  '#705848', 'Tipo sombrio; eficaz contra Psíquico e Fantasma.'),
  ('Aço',      '#B8B8D0', 'Tipo aço; defensivamente o mais resistente.'),
  ('Fada',     '#EE99AC', 'Tipo fada; eficaz contra Lutador, Dragão e Sombrio.');


-- ============================================================
-- 2. REGIÕES (8 registros)
-- ============================================================
INSERT INTO regiao (nome, geracao, descricao) VALUES
  ('Kanto',  1, 'Região original, cenário de Pokémon Red e Blue.'),
  ('Johto',  2, 'Região adjacente a Kanto, introduzida em Gold e Silver.'),
  ('Hoenn',  3, 'Região tropical com forte presença de Pokémon Água e Grama.'),
  ('Sinnoh', 4, 'Região ao norte, com forte lore mitológico.'),
  ('Unova',  5, 'Região inspirada em Nova York, com Pokémon completamente novos.'),
  ('Kalos',  6, 'Região inspirada na França, introduziu Mega Evoluções.'),
  ('Alola',  7, 'Arquipélago tropical inspirado no Havaí.'),
  ('Galar',  8, 'Região inspirada na Grã-Bretanha, com Pokémon Gigantamax.');


-- ============================================================
-- 3. POKÉMON (15 registros)
-- ============================================================
INSERT INTO pokemon (numero_dex, nome, id_regiao, altura_m, peso_kg, taxa_captura, lendario, descricao) VALUES
  (1,  'Bulbasaur',   1, 0.7,  6.9,  45, 0, 'Pokémon semente com um bulbo nas costas que absorve luz solar.'),
  (4,  'Charmander',  1, 0.6,  8.5,  45, 0, 'A chama na ponta de sua cauda indica seu estado de saúde.'),
  (7,  'Squirtle',    1, 0.5,  9.0,  45, 0, 'Retrai-se em sua concha dura e resistente quando ameaçado.'),
  (25, 'Pikachu',     1, 0.4,  6.0, 190, 0, 'Pokémon elétrico que armazena eletricidade nas bochechas.'),
  (39, 'Jigglypuff',  1, 0.5,  5.5, 170, 0, 'Infla o corpo e canta uma melodia que adormece os inimigos.'),
  (52, 'Meowth',      1, 0.4,  4.2, 255, 0, 'Fascínio por objetos brilhantes; moeda na testa traz boa sorte.'),
  (94, 'Gengar',      1, 1.5, 40.5,  45, 0, 'Pokémon fantasma que esfria o ambiente onde está.'),
  (143,'Snorlax',     1, 2.1,460.0,  25, 0, 'Come até 400 kg de comida por dia e logo dorme profundamente.'),
  (150,'Mewtwo',      1, 2.0,122.0,   3, 1, 'Pokémon lendário criado geneticamente a partir de Mew.'),
  (152,'Chikorita',   2, 0.9,  6.4,  45, 0, 'Balança a folha no pescoço para verificar temperatura e umidade.'),
  (155,'Cyndaquil',   2, 0.5,  7.9,  45, 0, 'Protege-se acendendo as chamas em suas costas quando assustado.'),
  (158,'Totodile',    2, 0.6,  9.5,  45, 0, 'Possui mandíbulas poderosas que podem morder qualquer coisa.'),
  (249,'Lugia',       2, 5.2,216.0,   3, 1, 'Guardião dos mares; diz-se que um único bater de asas cria ventos por 40 dias.'),
  (255,'Torchic',     3, 0.4,  2.5,  45, 0, 'Abriga uma bola de fogo de 1000 °C em seu interior.'),
  (258,'Mudkip',      3, 0.4,  7.6,  45, 0, 'Usa a barbatana na cabeça para sentir variações de água.'),
  (384,'Rayquaza',    3, 7.0,206.5,   3, 1, 'Vive na camada de ozônio e raramente desce à superfície.');


-- ============================================================
-- 4. POKÉMON_TIPO (relação N:N)
-- ============================================================
INSERT INTO pokemon_tipo (id_pokemon, id_tipo, slot) VALUES
  (1, 5, 1),
  (1, 8, 2),
  (2, 2, 1),
  (3, 3, 1),
  (4, 4, 1),
  (5, 1, 1),
  (5, 18, 2),
  (6, 1, 1),
  (7, 14, 1),
  (7, 8, 2),
  (8, 1, 1),
  (9, 11, 1),
  (10, 5, 1),
  (11, 2, 1),
  (12, 3, 1),
  (13, 11, 1),
  (13, 10, 2),
  (14, 2, 1),
  (15, 3, 1),
  (16, 15, 1);


-- ============================================================
-- 5. TREINADORES (15 registros)
-- ============================================================
INSERT INTO treinador (nome, cpf, email, data_nasc, cidade_origem, status) VALUES
  ('Ash Ketchum',       '00000000001', 'ash@pallet.com',        '1997-05-22', 'Pallet Town',   'A'),
  ('Misty Waterflower', '00000000002', 'misty@cerulean.com',    '1997-10-14', 'Cerulean City', 'A'),
  ('Brock Harrison',    '00000000003', 'brock@pewter.com',      '1995-03-05', 'Pewter City',   'A'),
  ('Gary Oak',          '00000000004', 'gary@pallet.com',       '1997-05-22', 'Pallet Town',   'A'),
  ('Dawn Berlitz',      '00000000005', 'dawn@twinleaf.com',     '2000-11-25', 'Twinleaf Town', 'A'),
  ('May Maple',         '00000000006', 'may@petalburg.com',     '1999-08-12', 'Petalburg City','A'),
  ('Serena Yvonne',     '00000000007', 'serena@vaniville.com',  '2001-06-18', 'Vaniville Town','A'),
  ('Clemont Laurent',   '00000000008', 'clemont@lumiose.com',   '1999-11-02', 'Lumiose City',  'A'),
  ('Iris Drake',        '00000000009', 'iris@opelucid.com',     '1998-04-04', 'Village of Dragons','A'),
  ('Cilan Verde',       '00000000010', 'cilan@striaton.com',    '1997-07-30', 'Striaton City', 'A'),
  ('Goh Runner',        '00000000011', 'goh@vermilion.com',     '2006-03-31', 'Vermilion City','A'),
  ('Lana Akala',        '00000000012', 'lana@konikoni.com',     '2003-02-12', 'Konikoni City', 'A'),
  ('Mallow Aina',       '00000000013', 'mallow@aina.com',       '2003-05-09', 'Lush Jungle',   'A'),
  ('Lillie Lusamine',   '00000000014', 'lillie@aether.com',     '2004-01-22', 'Aether Paradise','I'),
  ('Kiawe Maui',        '00000000015', 'kiawe@wela.com',        '2002-08-16', 'Wela Volcano',  'A');


-- ============================================================
-- 6. CAPTURAS (relação N:N — treinador ↔ pokemon)
-- ============================================================
INSERT INTO captura
(id_treinador, id_pokemon, data_captura, nivel, apelido, pokebola_usada)
VALUES
(1,  1,  '2010-04-01',  5, NULL,         'PokEbola'),
(1,  4,  '2010-04-01',  5, 'Charizinho', 'PokEbola'),
(1,  7,  '2010-04-02',  5, 'Squirtle',   'PokEbola'),
(1,  8,  '2011-01-10',  5, 'Pikachu',    'PokEbola'),
(2,  3,  '2010-05-10', 12, 'Starmie Jr.', 'PokEbola'),
(2, 12,  '2012-06-20', 10, NULL,         'PokEbola'),
(3,  3,  '2009-09-01', 15, NULL,         'PokEbola'),
(4,  1,  '2010-04-01',  5, NULL,         'PokEbola'),
(4,  9,  '2010-11-25', 70, NULL,         'Masterball'),
(5, 10,  '2013-03-15',  8, 'Chicori',    'PokEbola'),
(5, 11,  '2013-03-15',  8, NULL,         'PokEbola'),
(6, 14,  '2012-07-07',  5, 'Torcinho',   'PokEbola'),
(6, 15,  '2012-07-07',  5, NULL,         'PokEbola'),
(7,  5,  '2014-10-01', 20, 'Cleffa',     'PokEbola'),
(8,  4,  '2014-10-05', 10, NULL,         'PokEbola'),
(9, 16,  '2011-08-20', 60, NULL,         'Ultraball'),
(10, 6,  '2011-05-05', 25, 'Meowth',     'PokEbola'),
(11, 7,  '2019-04-01', 10, NULL,         'PokEbola'),
(11, 9,  '2019-07-10', 70, NULL,         'Masterball'),
(12, 3,  '2017-11-30', 18, NULL,         'PokEbola'),
(13, 1,  '2017-11-30',  7, NULL,         'PokEbola'),
(14, 7,  '2018-01-20', 22, 'Squirtle',   'PokEbola'),
(15, 2,  '2016-09-14', 15, NULL,         'PokEbola');


-- ============================================================
-- 7. HABILIDADES (15 registros)
-- ============================================================
INSERT INTO habilidade (nome, descricao, oculta) VALUES
  ('Torrente',         'Aumenta poder de movimentos de Água quando HP está baixo.',  0),
  ('Chamas',           'Aumenta poder de movimentos de Fogo quando HP está baixo.',   0),
  ('Supercresc.',      'Aumenta poder de movimentos de Grama quando HP está baixo.',  0),
  ('Estático',         'Pode paralisar ao contato físico.',                           0),
  ('Raio',             'Atrai movimentos elétricos para si mesmo.',                   0),
  ('Corpo Bruto',      'Previne redução de Ataque do usuário por movimentos inimigos.',0),
  ('Levitação',        'Imune a movimentos do tipo Terra.',                           0),
  ('Natural Cure',     'Status é curado ao sair de batalha.',                         0),
  ('Sincronizar',      'Passa condição de Queimado/Paralisado/Envenenado ao inimigo.',0),
  ('Pressão',          'Aumenta o consumo de PP dos movimentos inimigos.',            0),
  ('Sombra Mágica',    'Reflete movimentos de status usados contra o portador.',      1),
  ('Capricornio',      'Aumenta a evasão em tempestades de areia.',                   0),
  ('Multiscale',       'Reduz o dano recebido pela metade quando no HP cheio.',       1),
  ('Speed Boost',      'A velocidade aumenta a cada turno.',                          0),
  ('Adaptability',     'Aumenta o bônus STAB de 1.5× para 2×.',                      1);


-- ============================================================
-- 8. POKÉMON_HABILIDADE (relação N:N)
-- ============================================================
INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade, slot) VALUES
(1, 3, 1),
(2, 2, 1),
(3, 1, 1),
(4, 4, 1),
(4, 5, 3),
(5, 8, 1),
(6, 6, 1),
(7, 7, 1),
(7, 11, 3),
(8, 6, 1),
(9, 10, 1),
(9, 11, 3),
(10, 3, 1),
(11, 2, 1),
(12, 1, 1),
(13, 10, 1),
(13, 13, 3),
(14, 2, 1),
(14, 14, 3),
(15, 1, 1),
(16, 10, 1);



-- ============================================================
-- 9. EVOLUÇÕES (15 registros)
-- ============================================================
INSERT INTO evolucao (id_pokemon_base, id_pokemon_evo, nivel_minimo, metodo) VALUES
(1, 1, 16, 'Nivel'),
(2, 2, 16, 'Nivel'),
(10, 10, 32, 'Nivel'),
(11, 11, 14, 'Nivel'),
(12, 12, 18, 'Nivel'),
(14, 14, 16, 'Nivel'),
(15, 15, 16, 'Nivel');

-- Nota: auto-referências na mesma linha são apenas demonstrativas de estrutura.
-- Em um banco real, id_pokemon_evo aponta para o Pokémon evoluído real.
-- Adicionamos evoluções entre Pokémon diferentes que existem na tabela:
INSERT INTO evolucao (id_pokemon_base, id_pokemon_evo, nivel_minimo, metodo) VALUES
(1, 10, NULL, 'Pedra Folha'),
(4, 8, NULL, 'Amizade'),
(2, 14, 36, 'Nivel'),
(3, 15, 36, 'Nivel'),
(5, 5, 1, 'Pedra Lua'),
(6, 6, 1, 'Pedra Solar'),
(7, 7, 1, 'Troca'),
(12, 16, NULL, 'Pedra Dragao');


-- ============================================================
-- 10. ESTATÍSTICAS BASE (16 registros — 1 por Pokémon)
-- ============================================================
INSERT INTO estatistica_base (id_pokemon, hp, ataque, defesa, atq_especial, def_especial, velocidade) VALUES
(1, 45, 49, 49, 65, 65, 45),
(2, 39, 52, 43, 60, 50, 65),
(3, 44, 48, 65, 50, 64, 43),
(4, 35, 55, 40, 50, 50, 90),
(5, 115, 45, 20, 45, 25, 20),
(6, 40, 45, 35, 40, 40, 90),
(7, 60, 115, 75, 100, 75, 110),
(8, 160, 110, 65, 65, 65, 30),
(9, 106, 110, 90, 154, 90, 130),
(10, 45, 49, 65, 49, 65, 45),
(11, 39, 52, 43, 60, 50, 65),
(12, 50, 65, 64, 44, 48, 43),
(13, 106, 90, 130, 90, 154, 90),
(14, 45, 60, 40, 70, 50, 45),
(15, 50, 70, 50, 50, 50, 40),
(16, 105, 150, 90, 150, 90, 95);