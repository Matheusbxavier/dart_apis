//Primeiro, importe o pacote http a bibliotecadart:convert:
import 'dart:convert';
import 'package:http/http.dart';

void main() {
  //filtroReceitas();
}

//Em uma função assíncrona, que solicita por parâmetro a lista de ingredientes, faça uma requisição para a base de dados:
fetchRecipesAndFilter(List<String> listIngredients) async {
  String url =
      "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/recipes.json";
  Response response = await get(Uri.parse(url));
  List<dynamic> listRecipes = json.decode(response.body);

  List<String> listPossibleRecipes = [];

  for (dynamic recipeDyn in listRecipes) {
    Map<String, dynamic> recipe = recipeDyn as Map<String, dynamic>;
    List<dynamic> recipeIngredients = recipe["ingredients"];

    bool containsAllIngredients = listIngredients.every((ingredient) {
      bool isContainsIngredient = false;
      for (String recipeIngredient in recipeIngredients) {
        if (recipeIngredient.toLowerCase().contains(ingredient.toLowerCase())) {
          isContainsIngredient = true;
          break;
        }
      }
      return isContainsIngredient;
    });

    if (containsAllIngredients) {
      listPossibleRecipes.add(recipe["name"]);
    }
  }

  for (String recipe in listPossibleRecipes) {
    print("Receita: $recipe");
  }
}
