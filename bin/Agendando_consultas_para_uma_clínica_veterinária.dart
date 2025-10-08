import 'dart:convert';
import 'package:http/http.dart';

void main() {
  fetchVetAndSchedule("Dra. Patrícia Gomes");
}

fetchVetAndSchedule(String veterinarian) async {
  String url =
      "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/vet.json";
  Response response = await get(Uri.parse(url));

  List<dynamic> listAppointments = json.decode(response.body);
  //Filtre as consultas por veterinário e ordene por horário:
  List<dynamic> vetAppointments = listAppointments
      .where((appointment) => appointment["veterinarian"] == veterinarian)
      .toList();
  //Ordene por horário convertendo sempre o valor para DateTime para ter uma comparação consistente:
  vetAppointments.sort(
    (a, b) => DateTime.parse(
      a["appointment"],
    ).compareTo(DateTime.parse(b["appointment"])),
  );
  //Exiba as consultas organizadas:
  print("Consultas Agendadas para $veterinarian:");
  for (Map<String, dynamic> appointment in vetAppointments) {
    print(
      "Pet: ${appointment["pet_name"]} - Horário: ${appointment["appointment"]}",
    );
  }
}
