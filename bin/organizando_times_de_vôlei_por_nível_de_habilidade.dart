import 'dart:convert';
import 'package:http/http.dart';

void main() {

fetchPlayerAndMakeTeams();
  
}

fetchPlayerAndMakeTeams() async {
  String url =
      "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/players.json";
  Response response = await get(Uri.parse(url));
  //Decodifique o JSON com os dados dos jogadores:
  Map<String, dynamic> mapPlayers = json.decode(response.body);
  //Obtenha e registre a informação de quantas pessoas jogadoras há por times:
  int playersPerTeam = mapPlayers["rules"]["playersPerTeam"];
  //Obtenha a lista de pessoas jogadoras disponíveis:
  List<dynamic> listPlayers = mapPlayers["players"];
  //Ordene a lista para que os primeiros elementos sejam as pessoas que estão esperando a mais tempo:
  listPlayers.sort(
    (a, b) => (b["roundsWaiting"] as int).compareTo(a["roundsWaiting"]),
  );
  //Crie os dois times com base no tamanho da lista:
  List<dynamic> listFirstTeam = listPlayers.sublist(0, playersPerTeam);
  List<dynamic> listSecondTeam = listPlayers.sublist(
    playersPerTeam,
    playersPerTeam * 2,
  );
  //Mostre na tela os resultados:
  print("**Time A**");
  for (Map<String, dynamic> person in listFirstTeam) {
    print(person["name"]);
  }

  print("\n**Time B**");
  for (Map<String, dynamic> person in listSecondTeam) {
    print(person["name"]);
  }
}
