import 'package:flutter/material.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:mb_app_root/routes/sideMenu.dart';
import 'package:mb_app_root/utils/msj_toast.dart';
import 'package:mb_app_root/view_models/validar_dispositivo.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../view_models/actividad_gestion_estado_vm.dart';
import '../widget/appbar_drawer.dart';
import '../widget/button_widget.dart';
import '../widget/list_view_widget.dart';
import '../widget/seccion_inf_widget.dart';
import '../widget/texfield_widget.dart';

class GestionEstadoPage extends StatefulWidget {
  const GestionEstadoPage({super.key});

  @override
  State<GestionEstadoPage> createState() => _GestionEstadoPageState();
}

class _GestionEstadoPageState extends State<GestionEstadoPage>
    with WidgetsBindingObserver
    implements ScannerCallback {
  final textController = TextEditingController();
  final _searchQueryControl = TextEditingController();
  bool _isSearching = false;

  HoneywellScanner honeywellScanner = HoneywellScanner();
  ScannedData? scannedData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    honeywellScanner.scannerCallback = this;

    // microtask ejecuta luego de iniciar la pantalla
    Future.microtask(() {
      context.read<ValidarDispositivo>().asignarMensaje(tipo: "", msj: "");
      context.read<ActividadGestionEstadoViewModel>().cargarListaEscaneados(elementos: []);
    });
  }

  @override
  Widget build(BuildContext context) {
    //ActividadGestionEstadoViewModel provider = context.read<ActividadGestionEstadoViewModel>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBarCustom(
          textScreen: AppConstantsTags.titlePageMovProvider,
          onPressedIcon: (isSearching) {
            if (!isSearching) {
              _searchQueryControl.clear();
            }
            setState(() {
              _isSearching = isSearching;
            });
          },
          searchElement: _isSearching,
          showActions: false,
          backgroundColor: Colors.deepOrangeAccent,
          searchQueryController: _searchQueryControl,
          onSearchTextChanged: _onSearchTextChanged),
      body: Center(
          child: Scrollbar(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.only(top: 10)),
            const Center(
              child: Text("Ingrese o escanee el código", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width / 1.2,
                  child: TextFieldCustom(
                    isFocus: false,
                    focusText: null,
                    soloLectura: false,
                    textController: textController,
                    label: "Codigo De barra",
                    onPressed: () {
                      textController.clear();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
                width: size.width / 2.2,
                child: ButtonCustom(
                  fontColor: Colors.white,
                  color: AppColors.primaryBlue,
                  icon: Icons.search,
                  label: "Buscar",
                  isEnabled: true,
                  onPressed: () async {
                    if (textController.text.isEmpty) {
                      ToastMsjWidget.displayMotionToast(context,
                          mensaje: "Ingrese o escanee el código de barra",
                          tiempoespera: 5,
                          type: ToastType.warning,
                          onChange: () {});
                      return;
                    }
                    guardarInformacion(textController.text);
                  },
                )),
            showMsj(),
            showList()
          ])))),
    );
  }

  showMsj() {
    return Consumer<ValidarDispositivo>(builder: (context, item, child) {
      return item.mensaje.isNotEmpty
          ? SeccionInformativa(
              title: item.tipoMensaje,
              content: item.mensaje,
              color: Colors.red,
              onConfirm: () {
                item.asignarMensaje(
                  tipo: "",
                  msj: "",
                );
              },
            )
          : Container();
    });
  }

  showList() {
    return Consumer<ActividadGestionEstadoViewModel>(
        builder: (context, filtro, child) {
      ScrollController _scrollController = new ScrollController();
      final sizeLista = filtro.escaneados.length;
      final size = MediaQuery.of(context).size;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                  Icons.info, // Aquí puedes cambiar el icono a tu elección
                  color: Colors.blueGrey),
              Text(
                "Códigos escaneados ${sizeLista}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 20),
          filtro.escaneados.isNotEmpty?
          ListaProductoWidget(
              cont: context,
              scrollController: _scrollController,
              size: size,
              listas: filtro?.escaneados ?? []):Container(),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  void _onSearchTextChanged(String newText) {
    /* * TODO: filter list */
  }

  @override
  void onDecoded(ScannedData? scannedData) {
    final dataScan = scannedData?.code ?? "";
    if (dataScan.isNotEmpty) {
      guardarInformacion(scannedData!.code!);
    }
  }

  @override
  void onError(Exception error) {
    ValidarDispositivo validarProvider = context.read<ValidarDispositivo>();
    validarProvider.asignarMensaje(tipo: "Error", msj: error.toString());
  }

  void guardarInformacion(String value) {
    var actividadGestion = ActividadGestionEstadoViewModel();
    actividadGestion.guardarProducto(
        contextA: context, cod: value, usr: "dvega");
  }
}
