import 'package:flutter/cupertino.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';

class ValidarDispositivo extends ChangeNotifier {
  bool isDeviceSupported = false;
  HoneywellScanner honeywellScanner = HoneywellScanner();

  String mensaje="";
  String tipoMensaje="";
  Color? backgroundNotificacion;

  ValidarDispositivo._internal();
  static final ValidarDispositivo _instance = ValidarDispositivo._internal();
  factory ValidarDispositivo() => _instance;
  Future<void> validarDispositivo() async {
    isDeviceSupported = await honeywellScanner.isSupported();
    //honeywell = valor;
    notifyListeners();
  }
  void asignarMensaje({required String tipo,required String msj, Color? color}){
    tipoMensaje = tipo;
    mensaje =  msj;
    backgroundNotificacion = color;
    notifyListeners();
  }
}
