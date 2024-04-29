import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ActividadGestionEstadoService {
  static String urlApi = "";
  static initializate() {
    final apiurl = dotenv.env["API_TUTORIAS"];
    urlApi = apiurl.toString();
  }

  static Future<Map<String, dynamic>> guardarCod(String cod, String usr) async {
    initializate();
    final String uri = "$urlApi/tutorias/saveCodBarra?codBarra=$cod&user=$usr";

    final response = await http.get(Uri.parse(uri));

    final jsonResponse = json.decode(response.body);
    Map<String, dynamic> mapResponse = {};
    // Validar el código de estado HTTP
    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON

      // Validar el campo "success"
      if (jsonResponse['success'] == true) {
        // Retornar los datos del campo "data"
        mapResponse.addAll({"data": jsonResponse['data']});
        mapResponse.addAll({"success": jsonResponse['success']});
        return mapResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      if (!jsonResponse.containsKey("success")) {
        String error = jsonResponse['error'];
        throw Exception(
            'Error en la solicitud - ${'$error (${response.statusCode}) \n En la url: $uri'} ');
      }
      mapResponse.addAll({"message": jsonResponse['message']});
      mapResponse.addAll({"success": jsonResponse['success']});
      return mapResponse;
    }
  }

  static Future<Map<String, dynamic>> consultarCodsPorUsuario(
      String usr) async {
    initializate();
    final String uri = "$urlApi/tutorias/ConsultaCodBarra?user=$usr";
    final response = await http.get(Uri.parse(uri));
    final jsonResponse = json.decode(response.body);
    Map<String, dynamic> mapResponse = {};
    // Validar el código de estado HTTP
    if (response.statusCode == 200) {
      if (jsonResponse['success'] == true) {
        mapResponse.addAll({"data": jsonResponse['data']});
        mapResponse.addAll({"success": jsonResponse['success']});
        return mapResponse;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      if (!jsonResponse.containsKey("success")) {
        String error = jsonResponse['error'];
        throw Exception(
            'Error en la solicitud - ${'$error (${response.statusCode}) \n En la url: $uri'} ');
      }
      mapResponse.addAll({"message": jsonResponse['message']});
      mapResponse.addAll({"success": jsonResponse['success']});
      return mapResponse;
    }
  }

  static Future<Map<String, Object>> eliminarCodPorUsuario(String cod) async {
    initializate();
    final String uri = "$urlApi/tutorias/eliminarCodBarra?codBarra=$cod";
    final response = await http.get(Uri.parse(uri));
    // Validar el código de estado HTTP
    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON
      final jsonResponse = json.decode(response.body);

      // Validar el campo "success"
      if (jsonResponse['success'] == true) {
        // Retornar los datos del campo "data"
        return jsonResponse['data'];
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }
}
