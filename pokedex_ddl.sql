-- ============================================================
--  POKÉDEX DATABASE — DDL (CREATE DATABASE + CREATE TABLE)
--  Disciplina: Banco de Dados — Engenharia da Computação
-- ============================================================

CREATE DATABASE IF NOT EXISTS pokedex
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE pokedex;

-- ============================================================
-- TABELA 1: tipo
-- Representa os tipos elementais (Fogo, Água, Grama, etc.)
-- ============================================================
CREATE TABLE tipo (
  id_tipo       INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(20) NOT NULL UNIQUE,
  cor_hex       CHAR(7)     NOT NULL DEFAULT '#CCCCCC',
  descricao     TEXT,
  CONSTRAINT ck_tipo_cor CHECK (cor_hex REGEXP '^#[0-9A-Fa-f]{6}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 2: regiao
-- Regiões do mundo Pokémon (Kanto, Johto, Hoenn, etc.)
-- ============================================================
CREATE TABLE regiao (
  id_regiao     INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(40) NOT NULL UNIQUE,
  geracao       TINYINT     NOT NULL,
  descricao     TEXT,
  CONSTRAINT ck_regiao_geracao CHECK (geracao BETWEEN 1 AND 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 3: pokemon
-- Entidade central do sistema: cada Pokémon cadastrado
-- ============================================================
CREATE TABLE pokemon (
  id_pokemon    INT AUTO_INCREMENT PRIMARY KEY,
  numero_dex    SMALLINT    NOT NULL UNIQUE,
  nome          VARCHAR(60) NOT NULL UNIQUE,
  id_regiao     INT         NOT NULL,
  altura_m      DECIMAL(4,1) NOT NULL,
  peso_kg       DECIMAL(5,1) NOT NULL,
  taxa_captura  TINYINT UNSIGNED NOT NULL DEFAULT 45,
  lendario      TINYINT(1)  NOT NULL DEFAULT 0,
  descricao     TEXT,
  CONSTRAINT fk_pokemon_regiao FOREIGN KEY (id_regiao)
    REFERENCES regiao(id_regiao)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_pokemon_altura  CHECK (altura_m  > 0),
  CONSTRAINT ck_pokemon_peso    CHECK (peso_kg   > 0),
  CONSTRAINT ck_pokemon_captura CHECK (taxa_captura BETWEEN 1 AND 255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 4: pokemon_tipo  [N:N — pokemon ↔ tipo]
-- Um Pokémon pode ter 1 ou 2 tipos; um tipo aparece em muitos
-- ============================================================
CREATE TABLE pokemon_tipo (
  id_pokemon    INT      NOT NULL,
  id_tipo       INT      NOT NULL,
  slot          TINYINT  NOT NULL DEFAULT 1,
  PRIMARY KEY (id_pokemon, id_tipo),
  CONSTRAINT fk_pt_pokemon FOREIGN KEY (id_pokemon)
    REFERENCES pokemon(id_pokemon)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_pt_tipo FOREIGN KEY (id_tipo)
    REFERENCES tipo(id_tipo)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_pt_slot CHECK (slot IN (1, 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 5: treinador
-- Treinadores que possuem Pokémon
-- ============================================================
CREATE TABLE treinador (
  id_treinador  INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(80) NOT NULL,
  cpf           CHAR(11)    NOT NULL UNIQUE,
  email         VARCHAR(120) NOT NULL UNIQUE,
  data_nasc     DATE        NOT NULL,
  cidade_origem VARCHAR(60) NOT NULL,
  status        CHAR(1)     NOT NULL DEFAULT 'A',
  CONSTRAINT ck_treinador_status CHECK (status IN ('A', 'I'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 6: captura  [N:N — treinador ↔ pokemon]
-- Registra quais Pokémon cada treinador capturou
-- ============================================================
CREATE TABLE captura (
  id_captura    INT AUTO_INCREMENT PRIMARY KEY,
  id_treinador  INT          NOT NULL,
  id_pokemon    INT          NOT NULL,
  data_captura  DATE         NOT NULL,
  nivel         TINYINT UNSIGNED NOT NULL DEFAULT 1,
  apelido       VARCHAR(60),
  pokebola_usada VARCHAR(30) NOT NULL DEFAULT 'PokEbola',
  CONSTRAINT fk_captura_treinador FOREIGN KEY (id_treinador)
    REFERENCES treinador(id_treinador)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_captura_pokemon FOREIGN KEY (id_pokemon)
    REFERENCES pokemon(id_pokemon)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_captura_nivel CHECK (nivel BETWEEN 1 AND 100),
  UNIQUE KEY uq_captura (id_treinador, id_pokemon)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 7: habilidade
-- Habilidades passivas dos Pokémon (ex.: Torrente, Chamas)
-- ============================================================
CREATE TABLE habilidade (
  id_habilidade INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(60)  NOT NULL UNIQUE,
  descricao     TEXT         NOT NULL,
  oculta        TINYINT(1)   NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 8: pokemon_habilidade  [N:N — pokemon ↔ habilidade]
-- Cada Pokémon pode ter até 3 habilidades; uma habilidade pode
-- pertencer a vários Pokémon
-- ============================================================
CREATE TABLE pokemon_habilidade (
  id_pokemon    INT      NOT NULL,
  id_habilidade INT      NOT NULL,
  slot          TINYINT  NOT NULL DEFAULT 1,
  PRIMARY KEY (id_pokemon, id_habilidade),
  CONSTRAINT fk_ph_pokemon FOREIGN KEY (id_pokemon)
    REFERENCES pokemon(id_pokemon)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_ph_habilidade FOREIGN KEY (id_habilidade)
    REFERENCES habilidade(id_habilidade)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_ph_slot CHECK (slot IN (1, 2, 3))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 9: evolucao
-- Cadeia evolutiva: qual Pokémon evolui para qual
-- ============================================================
CREATE TABLE evolucao (
  id_evolucao     INT AUTO_INCREMENT PRIMARY KEY,
  id_pokemon_base INT NOT NULL,
  id_pokemon_evo  INT NOT NULL,
  nivel_minimo    TINYINT UNSIGNED,
  metodo          VARCHAR(60) NOT NULL DEFAULT 'Nivel',
  CONSTRAINT fk_evo_base FOREIGN KEY (id_pokemon_base)
    REFERENCES pokemon(id_pokemon)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_evo_resultado FOREIGN KEY (id_pokemon_evo)
    REFERENCES pokemon(id_pokemon)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT ck_evo_nivel CHECK (nivel_minimo IS NULL OR nivel_minimo BETWEEN 1 AND 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABELA 10: estatistica_base
-- Stats de batalha (HP, Ataque, Defesa, etc.) de cada Pokémon
-- ============================================================
CREATE TABLE estatistica_base (
  id_estatistica INT AUTO_INCREMENT PRIMARY KEY,
  id_pokemon     INT          NOT NULL UNIQUE,
  hp             SMALLINT UNSIGNED NOT NULL,
  ataque         SMALLINT UNSIGNED NOT NULL,
  defesa         SMALLINT UNSIGNED NOT NULL,
  atq_especial   SMALLINT UNSIGNED NOT NULL,
  def_especial   SMALLINT UNSIGNED NOT NULL,
  velocidade     SMALLINT UNSIGNED NOT NULL,
  CONSTRAINT fk_estat_pokemon FOREIGN KEY (id_pokemon)
    REFERENCES pokemon(id_pokemon)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT ck_estat_hp     CHECK (hp         BETWEEN 1 AND 255),
  CONSTRAINT ck_estat_ataque CHECK (ataque      BETWEEN 1 AND 255),
  CONSTRAINT ck_estat_def    CHECK (defesa      BETWEEN 1 AND 255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
