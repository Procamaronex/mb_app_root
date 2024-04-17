import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/cliente_map.dart';

class ClienteService {
  static String urlApi = "";
  static initializate() {
    final apiurl = dotenv.env["LOCAL_JSON"];
    urlApi = apiurl.toString();
  }

  static Future<Map<String, dynamic>> consultarClientes() async {
    await initializate();
    String url1 = "${urlApi}/clientes";
    var url = Uri.parse(url1);
    Map<String, dynamic> mapResponse = {};
    /* var dio = Dio();
    dio.interceptors.add(CustomInterceptor()); */
    try {
      var headers = {
        'Content-Type': 'application/json',
        //"Authorization":"Bearer $token"
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        mapResponse.addAll({"success": true});
        mapResponse
            .addAll({"body": ClienteMap.clienteMapConverter(response.body)});
        return mapResponse;
      }

      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": response.body});
      return mapResponse;
    } catch (ex, e) {
      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": ex.toString()});
    }
    return mapResponse;
  }
}
