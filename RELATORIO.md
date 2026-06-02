# Pokédex Database — Relatório Técnico

**Disciplina:** Banco de Dados  
**Curso:** Engenharia da Computação  
**Semestre:** 1º/2026  
**Integrantes:** João Paulo Santos Botelho · Juan Sobral Costa 
**Data de entrega:** 02 de julho de 2026

\---

## 1\. Resumo Executivo

Este projeto implementa um banco de dados relacional denominado **Pokédex Database**, que modela o universo do jogo Pokémon de forma estruturada e normalizada. O sistema permite cadastrar e consultar Pokémon, seus tipos, habilidades, estatísticas de batalha e cadeias evolutivas, bem como registrar treinadores e suas capturas.

O banco foi desenvolvido exclusivamente em SQL para MySQL, contemplando 10 tabelas inter-relacionadas, com relacionamentos 1:1, 1:N e N:N, normalização até a Terceira Forma Normal (3FN) e massa de dados realista extraída das informações canônicas do jogo. As consultas cobrem desde listagens simples com filtros até análises agregadas com múltiplos JOINs, subconsultas e LEFT/RIGHT JOIN.

\---

## 2\. Domínio e Regras de Negócio

### Cenário

O sistema modela a Pokédex — enciclopédia eletrônica do mundo Pokémon — integrando dados de criaturas, treinadores e capturas. Inspirado nas mecânicas dos jogos originais da Game Freak, o banco reflete as principais entidades do universo.

### Regras de Negócio

|Regra|Descrição|
|-|-|
|RN01|Um Pokémon pertence a exatamente uma região de origem.|
|RN02|Um Pokémon pode ter 1 ou 2 tipos elementais (slots 1 e 2).|
|RN03|Um tipo pode aparecer em muitos Pokémon.|
|RN04|Cada Pokémon possui exatamente um conjunto de estatísticas base (HP, Ataque, Defesa, Ataque Especial, Defesa Especial, Velocidade).|
|RN05|Um Pokémon pode ter até 3 habilidades (slots 1, 2 e 3 — sendo o slot 3 sempre uma habilidade oculta).|
|RN06|Um treinador pode capturar vários Pokémon; cada captura é única por treinador+pokémon.|
|RN07|Um mesmo Pokémon pode ser capturado por vários treinadores.|
|RN08|A taxa de captura varia entre 1 (lendários) e 255 (muito comum).|
|RN09|Treinadores podem estar ativos ('A') ou inativos ('I').|
|RN10|Cada captura registra a Pokébola utilizada, o nível no momento da captura e um apelido opcional.|

\---

## 3\. Diagrama de Classes / DER

```
!\[alt text](image.png)
> \*\*Legenda:\*\* 1──N = um para muitos | N──N = muitos para muitos (via tabela associativa)

---

## 4. Dicionário de Dados

### Tabela `tipo`
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_tipo | INT AUTO\_INCREMENT | PK | Identificador único do tipo |
| nome | VARCHAR(20) | NOT NULL, UNIQUE | Nome do tipo (ex.: Fogo, Água) |
| cor\_hex | CHAR(7) | NOT NULL, DEFAULT '#CCCCCC', CHECK (regexp) | Cor HTML representativa |
| descricao | TEXT | — | Descrição das características do tipo |

### Tabela `regiao`
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_regiao | INT AUTO\_INCREMENT | PK | Identificador único da região |
| nome | VARCHAR(40) | NOT NULL, UNIQUE | Nome da região (ex.: Kanto) |
| geracao | TINYINT | NOT NULL, CHECK (1–10) | Geração do jogo correspondente |
| descricao | TEXT | — | Contexto narrativo da região |

### Tabela `pokemon`
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_pokemon | INT AUTO\_INCREMENT | PK | Identificador interno |
| numero\_dex | SMALLINT | NOT NULL, UNIQUE | Número nacional na Pokédex |
| nome | VARCHAR(60) | NOT NULL, UNIQUE | Nome canônico do Pokémon |
| id\_regiao | INT | NOT NULL, FK → regiao | Região de origem |
| altura\_m | DECIMAL(4,1) | NOT NULL, CHECK > 0 | Altura em metros |
| peso\_kg | DECIMAL(5,1) | NOT NULL, CHECK > 0 | Peso em quilogramas |
| taxa\_captura | TINYINT UNSIGNED | NOT NULL, DEFAULT 45, CHECK (1–255) | Dificuldade de captura |
| lendario | TINYINT(1) | NOT NULL, DEFAULT 0 | 0 = comum, 1 = lendário |
| descricao | TEXT | — | Texto da Pokédex |

### Tabela `pokemon\_tipo` (associativa N:N)
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_pokemon | INT | PK, FK → pokemon | Pokémon referenciado |
| id\_tipo | INT | PK, FK → tipo | Tipo referenciado |
| slot | TINYINT | NOT NULL, DEFAULT 1, CHECK IN (1,2) | Posição do tipo (1º ou 2º) |

### Tabela `treinador`
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_treinador | INT AUTO\_INCREMENT | PK | Identificador único |
| nome | VARCHAR(80) | NOT NULL | Nome completo |
| cpf | CHAR(11) | NOT NULL, UNIQUE | CPF sem formatação |
| email | VARCHAR(120) | NOT NULL, UNIQUE | E-mail de contato |
| data\_nasc | DATE | NOT NULL | Data de nascimento |
| cidade\_origem | VARCHAR(60) | NOT NULL | Cidade natal |
| status | CHAR(1) | NOT NULL, DEFAULT 'A', CHECK IN ('A','I') | Ativo ou Inativo |

### Tabela `captura` (associativa N:N)
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_captura | INT AUTO\_INCREMENT | PK | Identificador único |
| id\_treinador | INT | NOT NULL, FK → treinador | Treinador que capturou |
| id\_pokemon | INT | NOT NULL, FK → pokemon | Pokémon capturado |
| data\_captura | DATE | NOT NULL | Data da captura |
| nivel | TINYINT UNSIGNED | NOT NULL, DEFAULT 1, CHECK (1–100) | Nível no momento da captura |
| apelido | VARCHAR(60) | NULL | Apelido opcional dado pelo treinador |
| pokebola\_usada | VARCHAR(30) | NOT NULL, DEFAULT 'Pokébola' | Tipo de Pokébola utilizada |

### Tabela `habilidade`
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_habilidade | INT AUTO\_INCREMENT | PK | Identificador único |
| nome | VARCHAR(60) | NOT NULL, UNIQUE | Nome da habilidade |
| descricao | TEXT | NOT NULL | Efeito em batalha |
| oculta | TINYINT(1) | NOT NULL, DEFAULT 0 | 0 = normal, 1 = oculta |

### Tabela `pokemon\_habilidade` (associativa N:N)
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_pokemon | INT | PK, FK → pokemon | Pokémon referenciado |
| id\_habilidade | INT | PK, FK → habilidade | Habilidade referenciada |
| slot | TINYINT | NOT NULL, DEFAULT 1, CHECK IN (1,2,3) | Slot da habilidade |

### Tabela `evolucao`
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_evolucao | INT AUTO\_INCREMENT | PK | Identificador único |
| id\_pokemon\_base | INT | NOT NULL, FK → pokemon | Pokémon pré-evolução |
| id\_pokemon\_evo | INT | NOT NULL, FK → pokemon | Pokémon resultante |
| nivel\_minimo | TINYINT UNSIGNED | NULL, CHECK (1–100) | Nível exigido (NULL se outro método) |
| metodo | VARCHAR(60) | NOT NULL, DEFAULT 'Nível' | Método evolutivo |

### Tabela `estatistica\_base`
| Campo | Tipo | Restrições | Descrição |
|-------|------|-----------|-----------|
| id\_estatistica | INT AUTO\_INCREMENT | PK | Identificador único |
| id\_pokemon | INT | NOT NULL, UNIQUE, FK → pokemon | Pokémon (1:1) |
| hp | SMALLINT UNSIGNED | NOT NULL, CHECK (1–255) | Pontos de vida |
| ataque | SMALLINT UNSIGNED | NOT NULL, CHECK (1–255) | Ataque físico |
| defesa | SMALLINT UNSIGNED | NOT NULL, CHECK (1–255) | Defesa física |
| atq\_especial | SMALLINT UNSIGNED | NOT NULL | Ataque especial |
| def\_especial | SMALLINT UNSIGNED | NOT NULL | Defesa especial |
| velocidade | SMALLINT UNSIGNED | NOT NULL | Velocidade |

---

## 5. Justificativa da Normalização

### Primeira Forma Normal (1FN)
Todas as tabelas possuem apenas atributos atômicos (sem grupos repetidos). Os tipos de um Pokémon, que poderiam ser armazenados como lista em uma coluna, foram separados na tabela `pokemon\_tipo`, garantindo atomicidade.

### Segunda Forma Normal (2FN)
Todas as tabelas com chave primária composta (`pokemon\_tipo`, `pokemon\_habilidade`, `captura`) têm seus atributos não-chave dependentes da chave completa — não de parte dela. Por exemplo, `slot` em `pokemon\_tipo` depende do par `(id\_pokemon, id\_tipo)`, não apenas de um dos componentes.

### Terceira Forma Normal (3FN)
Nenhum atributo não-chave depende transitivamente de outro atributo não-chave. Exemplo de decomposição realizada:

\*\*Antes (anomalia transitiva):\*\*
```

pokemon(id\_pokemon, nome, nome\_regiao, geracao\_regiao, ...)

```
Aqui, `geracao\_regiao` dependia de `nome\_regiao`, que dependia de `id\_pokemon` — dependência transitiva.

\*\*Depois (3FN):\*\*
```

pokemon(id\_pokemon, nome, id\_regiao, ...)
regiao(id\_regiao, nome, geracao, ...)

```
A informação de geração agora pertence exclusivamente à tabela `regiao`.

---

## 6. Catálogo de Consultas

### Q01 — Pokémon lendários ordenados por número
\*\*Pergunta:\*\* Quais Pokémon da base são considerados lendários?  
\*\*Recursos:\*\* SELECT, WHERE, ORDER BY, INNER JOIN  
\*\*Saída esperada:\*\* Mewtwo (150), Lugia (249), Rayquaza (384)

### Q02 — Pokémon com 'a' no nome e peso entre 5 e 50 kg
\*\*Pergunta:\*\* Quais Pokémon leves têm 'a' no nome?  
\*\*Recursos:\*\* LIKE, BETWEEN, ORDER BY

### Q03 — Top 5 com maior taxa de captura
\*\*Pergunta:\*\* Quais são os mais fáceis de capturar?  
\*\*Recursos:\*\* ORDER BY DESC, LIMIT

### Q04 — Treinadores ativos com cidade de origem
\*\*Pergunta:\*\* Quais treinadores estão ativos?  
\*\*Recursos:\*\* WHERE, ORDER BY

### Q05 — Tipos distintos de Pokébola usados
\*\*Pergunta:\*\* Quais tipos de Pokébola foram utilizados?  
\*\*Recursos:\*\* DISTINCT

### Q06 — Habilidades ocultas
\*\*Pergunta:\*\* Quais habilidades são exclusivamente ocultas?  
\*\*Recursos:\*\* WHERE, ORDER BY

### Q07 — Pokémon com seus tipos (3 tabelas)
\*\*Pergunta:\*\* Qual a combinação de tipos de cada Pokémon?  
\*\*Recursos:\*\* INNER JOIN ×2, GROUP\_CONCAT, GROUP BY

### Q08 — Estatísticas médias por região (3 tabelas)
\*\*Pergunta:\*\* Qual região tem maior poder médio de ataque?  
\*\*Recursos:\*\* INNER JOIN ×2, AVG, MAX, MIN, GROUP BY, HAVING

### Q09 — Histórico de capturas por treinador (3 tabelas)
\*\*Pergunta:\*\* Qual o histórico de capturas de cada treinador?  
\*\*Recursos:\*\* INNER JOIN ×2, COALESCE, ORDER BY

### Q10 — Treinadores com 2+ capturas
\*\*Pergunta:\*\* Quais treinadores têm coleção significativa?  
\*\*Recursos:\*\* INNER JOIN, GROUP BY, HAVING, COUNT, MAX, MIN

### Q11 — Pokémon e habilidades com LEFT JOIN
\*\*Pergunta:\*\* Existem Pokémon sem habilidades registradas?  
\*\*Recursos:\*\* LEFT JOIN ×2, COALESCE

### Q12 — Pokémon com ataque acima da média (subconsulta)
\*\*Pergunta:\*\* Quais Pokémon são ofensivamente acima da média?  
\*\*Recursos:\*\* Subconsulta com AVG, INNER JOIN, WHERE

### Q13 — Total de stats por Pokémon e geração (3 tabelas)
\*\*Pergunta:\*\* Qual geração tem os Pokémon mais poderosos?  
\*\*Recursos:\*\* INNER JOIN ×2, expressão aritmética, ORDER BY

### Q14 — Tipos sem Pokémon cadastrado (RIGHT JOIN — BÔNUS)
\*\*Pergunta:\*\* Existem tipos sem nenhum Pokémon na base?  
\*\*Recursos:\*\* RIGHT JOIN, GROUP BY, COUNT

---

## 7. Instruções de Execução

### Pré-requisitos
- MySQL 8.0 ou superior instalado
- MySQL Workbench (opcional, mas recomendado)

### Passo a passo

```bash
# 1. Acesse o MySQL via terminal
mysql -u root -p

# 2. Execute o script DDL
source /caminho/para/pokedex\_ddl.sql

# 3. Execute o script DML (dados)
source /caminho/para/pokedex\_dml.sql

# 4. Execute as consultas
source /caminho/para/pokedex\_consultas.sql
```

Ou, via MySQL Workbench:

1. Abra o Workbench e conecte-se ao servidor local.
2. `File > Open SQL Script` → selecione `pokedex\_ddl.sql` → clique em Execute (⚡).
3. Repita para `pokedex\_dml.sql` e `pokedex\_consultas.sql`.
4. Selecione o banco: `USE pokedex;` ou escolha no painel lateral.

\---

## 8\. Considerações Finais

A escolha do tema Pokédex mostrou-se rica semanticamente, permitindo explorar todos os tipos de relacionamento exigidos (1:1, 1:N e N:N), além de oferecer dados canônicos bem conhecidos que facilitam a validação da consistência.

A maior dificuldade esteve na modelagem do auto-relacionamento da tabela `evolucao`, que referencia a própria tabela `pokemon` com dois papéis distintos (base e resultado). A solução com duas chaves estrangeiras distintas (`id\_pokemon\_base` e `id\_pokemon\_evo`) resolveu o problema de forma elegante.

**Possíveis evoluções do sistema:**

* Adicionar tabela de movimentos (`movimento`) com relação N:N com `pokemon`.
* Incluir tabela `batalha` para registrar confrontos entre treinadores.
* Implementar tabela `item` para equipamentos e itens evolutivos.
* Criar views para facilitar consultas frequentes (ex.: `v\_pokemon\_completo`).

\---

## 9\. Referências Bibliográficas

* ELMASRI, R.; NAVATHE, S. B. **Sistemas de Banco de Dados**. 7. ed. São Paulo: Pearson, 2019.
* DATE, C. J. **Introdução a Sistemas de Banco de Dados**. 8. ed. Rio de Janeiro: Elsevier, 2004.
* MySQL Documentation. **MySQL 8.0 Reference Manual**. Disponível em: https://dev.mysql.com/doc/refman/8.0/en/. Acesso em: maio 2026.
* Bulbapedia — The Pokémon Encyclopedia. Disponível em: https://bulbapedia.bulbagarden.net. Acesso em: maio 2026.

