# URL Shortener

Primeiro projeto desenvolvido pelo Elixir Salvador, grupo soteropolitano criado com o objetivo de aprender e popularizar a linguagem Elixir na cidade.

O objetivo é construir um encurtador de URLs.

Este código foi desenvolvido utilizando o modelo de coding dojo, que acontecerá a cada duas semanas.

To-Do List
- [X] Criar keys para cada url;
- [X] Resgatar as URLs com base em suas keys;
- [X] Conferir se a URL já existe no banco, retornar a key caso sim, inserir caso não;
- [ ] Receber URLs e devolver keys por chamada HTTP;
- [ ] Validação de entradas;
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
* Por fim, temos um módulo chamado Ele se chama UrlShortener, que utiliza os módulos anteriores para receber e resgatar URLs no banco de dados.
