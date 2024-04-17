import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/cliente_map.dart';

class ProductService {
  static String urlApi = "";
  static initializate() {
    final apiurl = dotenv.env["PRODUCTO"];
    urlApi = apiurl.toString();
  }

  static Future<Map<String, dynamic>> consultarProductoCodBar() async {
    initializate();
    String uri = "$urlApi +/clientes";
    var url = Uri.parse(uri);
    Map<String, dynamic> mapResponse = {};

    try {
      var headers = {
        'Content-Type': 'application/json',
        //"Authorization":"Bearer $token"
      };

      final response = await http.get(
        url,
        headers: headers,
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 400) {
        mapResponse.addAll({"success": true});
        //mapResponse.addAll({"body": ClienteMap.clienteMapConverter(response.body)});
      }else{
        mapResponse.addAll({"success": false});
      }
      mapResponse.addAll({"body": response.body});

      return mapResponse;
    } catch (ex, e) {
      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": ex.toString()});
      return mapResponse;
    }
  }
}
