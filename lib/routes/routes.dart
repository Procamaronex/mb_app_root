import 'package:flutter/material.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:mb_app_root/pages/clientes.dart';
import 'package:mb_app_root/pages/gestion_estado_consultar_page.dart';
import 'package:mb_app_root/pages/gestion_estado_page.dart';
import 'package:mb_app_root/pages/obtener.dart';

import '../pages/honeywell_scanner_page.dart';

final Map<String, Widget Function(BuildContext)> appRoute = {
  'ruta1': (_) => const ruta1(),
  'clientes': (_) => const Clientes(),
  'gestion-estado': (_) =>const GestionEstadoPage(),
  "gestion-estado-consulta": (_) => GestionEstadoConsultarCajas(),
  'honeywell': (_) => const HoneywellScannerPage()
};
