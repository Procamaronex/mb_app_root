import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mb_app_root/services/cliente_service.dart';
import 'package:mb_app_root/utils/loading_overlay.dart';
import 'package:mb_app_root/utils/msj_toast.dart';

class clienteViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> clientes = [];

  List<Map<String, dynamic>> copiaClientes = [];

  //constructor privado - singleton
  clienteViewModel._internal();

  static final clienteViewModel _instance = clienteViewModel._internal();

  factory clienteViewModel() => _instance;

  void init({required BuildContext contextA}) async {
    consultarCliente(contextA: contextA);
  }

  void asignarClientes({required List<Map<String, dynamic>> c}) {
    clientes = c;
    copiaClientes = c;
    notifyListeners();
  }

  Future<void> consultarCliente({required BuildContext contextA}) async {
    LoadingOverlay loadingOverlay = LoadingOverlay();
    loadingOverlay.show(contextA);
    final Map<String, dynamic> body = await ClienteService.consultarClientes();
    loadingOverlay.hide();
    bool success = body["success"];
    dynamic response = body["body"];

    if (!success && response.runtimeType == String) {
      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: response.toString(),
          tiempoespera: 5,
          type: ToastType.error,
          onChange: () {});
      notifyListeners();
      return;
    }

    if (!success && response.runtimeType == Map) {
      Map<String, dynamic> mapResponse = response;

      String mensaje = mapResponse.containsKey("message")
          ? mapResponse["message"]
          : response.toString();

      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: mensaje.toString(),
          tiempoespera: 5,
          type: ToastType.error,
          onChange: () {});
      notifyListeners();
      return;
    }

    clientes = response;
    clientes = clientes.reversed.toList();
    copiaClientes = List<Map<String, dynamic>>.from(clientes);
    loadingOverlay.hide();
    notifyListeners();
  }
}
