# URL Shortener

Primeiro projeto desenvolvido pelo Elixir Salvador, grupo soteropolitano criado com o objetivo de aprender e popularizar a linguagem Elixir na cidade.

O objetivo é construir um encurtador de URLs.

Este código foi desenvolvido utilizando o modelo de coding dojo, que acontecerá a cada duas semanas.

## Uso 

A API existente pode ser executada através do comando `mix run --no-halt` (a flag [--no-halt](https://hexdocs.pm/mix/Mix.Tasks.Run.html) é usada para sistemas de execução duradoura).

Um link pode ser encurtado através de uma requisição **POST** com `Content-type: application/json` e body no seguinte formato:

```json
{
    "url": "URL_A_ENCURTAR"
}
```

A exemplo, com cURL:
```
curl -XPOST -H "Content-type: application/json" -d '{
"url":"URL A ENCURTAR"
}' 'URL DA API'
```

Para acessar uma URL encurtada, pode ser feita uma requisição **GET** (preferencialmente um acesso via browser) a `http://URL DA API/URL ENCURTADA`, vide:
`http://localhost:25565/c2aca968`.

## To-Do List
- [X] Criar keys para cada url;
- [X] Resgatar as URLs com base em suas keys;
- [X] ~~Conferir se a URL já existe no banco, retornar a key caso sim, inserir caso não;~~
- [X] Receber URLs e devolver keys por chamada HTTP;
- [X] Adicionar endpoint de ping;
- [X] Validação de entradas;
- [ ] Front-end

## Relatórios 

### 01 de fevereiro de 2020
* Foram desenvolvidos 3 módulos: um para gerar as keys, um para acesso ao banco (foi utilizado MongoDB) e um módulo principal para criação/resgate de URLs.  
* Para encurtar a URL, escolhemos pegar os 8 primeiros digitos de um UUID gerado e salvá-lo como a propriedade key, enquanto a nossa url será usada como a propriedade value. O módulo responsável por isso chama-se Generator 
* Para guardar os dados, utilizamos MongoDB pela facilidade de setup. Criamos um módulo chamado DBConnector e guardamos objetos com o modelo: 
```
 {
  "key": key,
  "url": url
 }
```
* Por fim, temos um módulo chamado UrlShortener, que utiliza os módulos anteriores para receber e resgatar URLs no banco de dados.

### 17 de fevereiro de 2020
* Foi adicionado um diretório `config/` relativo às configurações de ambiente, onde encontram-se os arquivos `dev.exs`, `prod.exs`, `test.exs` e `config.exs`, com os 3 primeiros contendo valores diferentes para a variável `port` e o último carregando o arquivo correspondente ao ambiente esperado;
* Foi adicionado o servidor HTTP Cowboy e o connection adapter Plug, inicializados no módulo Application;
* O MongoDB foi substituído em todo os usos pelo Redis, com auxílio da biblioteca _Redix_;
* Foi criado o módulo **Endpoint**, que é responsável pelo roteamento dos endpoints do server;
* O tratamento de erros, no geral, foi alterado, passando a trabalhar em cima de tuplas `{:ok, result}` ou `{:error, reason}`;
* Modelo de inserção foi repensado, não mais checando a existência no banco, visto que Redis não permite consulta performática por chave;
* Pausa de duas semanas (com próximo encontro em 14/03) devido à indisponibilidade de @CelsoBonutti.

### 13 de junho de 2020
Depois do dia 17 de fevereiro nos reunimos novamente, exatos 15 dias depois, em 13 de junho!
* Adicionado tratamento de erro em `DBConnector#insert_key` e `DBConnector#get_by_key`
* Retorno adequado das URLs esperadas em `URLShortener#get_url`
* Adequação da lógica esperada de fato em `Generator#generate_key`, removendo a verificação da existência de URL no banco (discussão revelou que é uma verificação desnecessária e que não podde ser realizada performáticamente usando Redis no dia 17 de fevereiro de 2020)
* Adicionado endpoint de redirecionamento por url encurtada
* Tratamento de erros mais adequado no geral
* Validação de URL
* Endpoint de ping
* Página de 404


