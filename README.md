# Sistema de Pedidos de Venda
Um sistema de gerenciamento de pedidos de venda desenvolvido em Delphi, utilizando conceitos de POO, MVC, e práticas de Clean Code, com integração ao banco de dados MySQL.

## Licença
Este projeto está licenciado sob a [MIT License](https://github.com/jamil-campeao/SistemaPedidosVenda/blob/main/LICENSE)

## Funcionalidades
O sistema foi projetado para atender as seguintes funcionalidades:
- Cadastro e consulta de pedidos de venda:
  - Seleção de cliente por código.
  - Adição de produtos ao pedido com quantidade e valor unitário.
  - Visualização em um grid com totalização automática do pedido.
  - Alteração e exclusão de itens diretamente no grid.
  - Gravação do pedido com controle transacional e validações.

- Manipulação de pedidos já gravados:
  - Carregar pedidos por número.
  - Cancelar pedidos, removendo dados das tabelas relacionadas.

- Outros Recursos: 
  - Totalização dinâmica do pedido.
  - Sequenciamento automático para número do pedido.
  - Navegação intuitiva pelo grid com suporte a teclas (Seta para cima/baixo, Enter, DEL).
  - Configuração dinâmica para conexão ao banco de dados via arquivo .ini.
 
## Tecnologias Utilizadas
- Linguagem: Delphi
- Framework de acesso a banco: FireDAC
- Banco de Dados: MySQL
- Biblioteca nativa do banco: MySQL Connector .dll

## Estrutura do Banco de Dados
O sistema utiliza as seguintes tabelas no banco de dados MySQL:
* Cliente

Tabela responsável pelo armazenamento das informações dos clientes.

| Campo            | Tipo         | Descrição                  |
|-------------------|--------------|----------------------------|
| CLIENTE_CODIGO    | INT (PK)     | Código único do cliente.(AUTO_INCREMENT).   |
| CLIENTE_NOME      | VARCHAR(80)  | Nome completo do cliente.  |
| CLIENTE_CIDADE    | VARCHAR(80)  | Cidade do cliente.         |
| CLIENTE_UF        | CHAR(2)      | Estado (UF) do cliente.    |

* Produto

Tabela que armazena os produtos disponíveis para venda.
| Campo            | Tipo         | Descrição                  |
|-------------------|--------------|----------------------------|
| PRODUTO_CODIGO    | INT (PK)     | Código único do produto (AUTO_INCREMENT).   |
| PRODUTO_DESCRICAO      | VARCHAR(80)  | Descrição do produto.  |
| PRODUTO_PRECOVENDA    | VARCHAR(80)  | Preço de venda do produto.         |

* Pedidos

Tabela que armazena os produtos disponíveis para venda.
| Campo            | Tipo         | Descrição                  |
|-------------------|--------------|----------------------------|
| PEDIDO_NUMERO    | INT (PK)     | Número único do pedido.   |
| CLIENTE_CODIGO      | INT (FK)  | Código do cliente (chave estrangeira para cliente). |
| PEDIDO_DATAEMISSAO    | DATE  | Data de emissão do pedido. |
| PEDIDO_VALORTOTAL    | DECIMAL(14,2)  | Valor total do pedido. |

  Relações: FK: CLIENTE_CODIGO -> cliente.CLIENTE_CODIGO.


* Pedidos_produtos

Tabela que armazena os produtos disponíveis para venda.
| Campo            | Tipo         | Descrição                  |
|-------------------|--------------|----------------------------|
| PEDIDO_CODIGOITEM    | INT (PK)     | Identificador único do item (AUTO_INCREMENT).   |
| PEDIDO_NUMERO      | INT (FK)  | Número do pedido (chave estrangeira para pedidos). |
| PRODUTO_CODIGO   | INT (FK)  | Código do produto (chave estrangeira para produto). |
| PEDIDOPRODUTO_QUANT    | DECIMAL(6,2)  | Quantidade do produto no pedido. |
| PEDIDOPRODUTO_VLRUNIT    | DECIMAL(6,2)  | Valor unitário do produto. |
| PEDIDOPRODUTO_VLRTOTAL    | DECIMAL(15,2)  | Valor total do item. |

Relações:
 - FK: PEDIDO_NUMERO -> pedidos.PEDIDO_NUMERO.
 - FK: PRODUTO_CODIGO -> produto.PRODUTO_CODIGO.

## Relacionamentos
- Cliente e Pedidos:
  - Um cliente pode ter vários pedidos.
  - Relacionamento: cliente.CLIENTE_CODIGO -> pedidos.CLIENTE_CODIGO.

- Pedidos e Produtos do Pedido:
  - Um pedido pode conter vários produtos.
  - Relacionamento: pedidos.PEDIDO_NUMERO -> pedidos_produtos.PEDIDO_NUMERO.

- Produtos e Produtos do Pedido:
  - Um produto pode estar em vários pedidos.
  - Relacionamento: produto.PRODUTO_CODIGO -> pedidos_produtos.PRODUTO_CODIGO.
 
  ## Considerações Técnicas
- Todas as tabelas estão configuradas com InnoDB como o mecanismo de armazenamento.
- As chaves primárias (PK) e estrangeiras (FK) estão devidamente configuradas.
- Índices foram criados para otimizar as consultas:
  - fk_PEDIDOS_CLIENTE_idx: Índice para ligação de pedidos com cliente.
  - fk_PEDIDOS_PRODUTOS_PRODUTO1_idx: Índice para ligação de pedidos_produtos com produto.
  - fk_PEDIDOS_PRODUTOS_PEDIDOS1_idx: Índice para ligação de pedidos_produtos com pedidos.

## Como Executar
### Pré-requisitos
1. Banco de Dados:
- MySQL instalado
- Importar o arquivo [ScriptCriacaoBanco.sql](https://github.com/jamil-campeao/SistemaPedidosVenda/blob/main/Aplicacao/ScriptCriacaoBanco.sql) para criar e popular as tabelas

2. Configuração do Banco de Dados
- Atualize o arquivo config.ini com os detalhes da conexão:
```bash
[Database]
Server=localhost
Port=3306
Database=NomeDoBanco
Username=SeuUsuario
Password=SuaSenha
LibPath=Path/para/mysql.dll
````

## Passos para execução
1. Faça download do projeto
2. Importe o banco de dados:
  - Utilize o cliente MySQL de sua preferência para importar o arquivo [ScriptCriacaoBanco.sql](https://github.com/jamil-campeao/SistemaPedidosVenda/blob/main/Aplicacao/ScriptCriacaoBanco.sql)
3. Configure o arquivo config.ini com os parâmetros adequados
4. Execute o sistema

## Estrutura do Repositório
- /Aplicacao: Executável do sistema, config.ini, dlls necessárias e script de criação das tabelas.
- /Fontes: Código fonte do sistema.

## Autor
- Desenvolvido por [Jamil Luiz Campeão](https://github.com/jamil-campeao)
- Linkedin: https://www.linkedin.com/in/jamilcampeao/
