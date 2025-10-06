//Primeiro, importe o pacote http a bibliotecadart:convert:
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  requisicaoLivros("Machado de Assis");
}

//Em uma função assíncrona que solicita uma pessoa autora por parâmetro, faça a requisição da base de dados:
requisicaoLivros(String author) async {
  String url =
      "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/books.json";

  Response response = await get(Uri.parse(url));
  //Em seguida, decodifique o JSON com os dados dos livros:
  List<dynamic> books = json.decode(response.body);

  //List<dynamic> booksByAuthor = listBooks.where((book) => book["author"] == author).toList();
  List<dynamic> booksByAuthor = books
      .where((book) => book["author"] == author)
      .toList();
  //Exiba os títulos dos livros encontrados:
  for (dynamic book in booksByAuthor) {
    print("Título: ${book["title"]}");
  }
}
