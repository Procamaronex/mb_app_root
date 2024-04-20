import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/cliente_map.dart';

class ProductService {
  static String urlApi = "";
  static initializate() {
    final apiurl = dotenv.env["MANTENEDOR"];
    urlApi = apiurl.toString();
  }

  static Future<Map<String, dynamic>> obtenerDatosEtiqueta(String cod) async {
    initializate();
    final String uri = "$urlApi/csetqCodigosxOrden/obtenerDatosEtiqueta?cod=$cod";

    final response = await http.get(Uri.parse(uri));
    print(uri);
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

  static Future<Map<String, dynamic>> obtenerDatosDesdeJson() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    // Parsear el JSON a un mapa
    final jsonData = json.decode(jsonString);
    if (jsonData['success'] == true) {
      // Retornar los datos del campo "data"
      return jsonData['data'];
    } else {
      throw Exception(jsonData['message']);
    }
  }
}
