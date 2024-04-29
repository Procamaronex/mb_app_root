import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mb_app_root/services/actividad_gestion_estado_service.dart';
import 'package:mb_app_root/view_models/validar_dispositivo.dart';
import 'package:vibration/vibration.dart';
import '../utils/loading_overlay.dart';
import '../utils/msj_toast.dart';

class ActividadGestionEstadoViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> escaneados = [];
  List<dynamic> consultaEscaneados = [];
  List<Map<String, dynamic>> listaEliminados = [];

  ActividadGestionEstadoViewModel._internal();
  static final ActividadGestionEstadoViewModel _instance =
      ActividadGestionEstadoViewModel._internal();
  factory ActividadGestionEstadoViewModel() => _instance;

  Future<void> guardarProducto(
      {required BuildContext contextA,
      required String cod,
      required String usr}) async {
    LoadingOverlay loadingOverlay = LoadingOverlay();
    try {
      loadingOverlay.show(contextA);
      Map<String, dynamic> body =
          await ActividadGestionEstadoService.guardarCod(cod, usr);
      Map<String, dynamic> data = {};
      loadingOverlay.hide();
      if (!body['success']) {
        contextA.read<ValidarDispositivo>().asignarMensaje(
              tipo: 'Error al realizar el proceso',
              msj: body['message'].toString().toUpperCase(),
              color: Colors.green,
            );
        notifyListeners();
        return;
      }
      data = body["data"];
      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: "producto guardado con exito".toString().toUpperCase(),
          tiempoespera: 5,
          type: ToastType.success,
          onChange: () {});
      escaneados.add(data);
      notifyListeners();
    } catch (e) {
      loadingOverlay.hide();
      contextA.read<ValidarDispositivo>().asignarMensaje(
          tipo: 'Error al realizar el proceso',
          msj: e.toString(),
          color: Colors.red);
      Vibration.vibrate();
    }
  }

  Future<void> cargarCodigos({required BuildContext contextB, required String usr}) async {
    LoadingOverlay loadingOverlay = LoadingOverlay();
    try {
      loadingOverlay.show(contextB);
      Map<String, dynamic> body =
          await ActividadGestionEstadoService.consultarCodsPorUsuario(usr);
      //List<Map<String, dynamic>> data = [];
      loadingOverlay.hide();
      if (!body['success']) {
        contextB.read<ValidarDispositivo>().asignarMensaje(
          tipo: 'Error al realizar el proceso',
          msj: body['message'].toString().toUpperCase(),
          color: Colors.green,
        );
        notifyListeners();
        return;
      }

      final data = body["data"];
      ToastMsjWidget.displayMotionToast(contextB,
          mensaje: "Se obtuvieron los codigos ingresados con exito".toString().toUpperCase(),
          tiempoespera: 5,
          type: ToastType.success,
          onChange: () {});
      consultaEscaneados= data;
      notifyListeners();
    } catch (e) {
      loadingOverlay.hide();
      contextB.read<ValidarDispositivo>().asignarMensaje(
          tipo: 'Error al realizar el proceso',
          msj: e.toString(),
          color: Colors.red);
      Vibration.vibrate();
    }
  }
  void asignarCodAListaEscaneado({required Map<String, dynamic> elemento}) {
    escaneados.add(elemento);
    notifyListeners();
  }

  void cargarListaEscaneados({required List<Map<String, dynamic>> elementos}) {
    escaneados = elementos;
    notifyListeners();
  }

  void eliminarCodEscaneado({required String cod}) {
    List<Map<String, dynamic>> lista = [];
    lista = escaneados.toList(growable: true);
    lista.removeWhere((list) => list["codigoBarra"] == cod);
    //listaEliminados.add();
    notifyListeners();
  }
}
