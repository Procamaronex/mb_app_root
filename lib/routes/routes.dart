import 'package:flutter/material.dart';
import 'package:mb_app_root/pages/clientes.dart';
import 'package:mb_app_root/pages/obtener.dart';

final Map<String, Widget Function(BuildContext)> appRoute = {
  'ruta1': (_) => const ruta1(),
  'clientes': (_) => const Clientes()

};
