import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mb_app_root/services/producto_service.dart';
import 'package:mb_app_root/utils/app_colors.dart';
import 'package:mb_app_root/utils/constants.dart';
import 'package:mb_app_root/widget/appbar_drawer.dart';
import 'package:mb_app_root/widget/button_widget.dart';
import 'package:mb_app_root/widget/dialogCupertino.dart';
import 'package:mb_app_root/widget/scanner_movil_widget.dart';
import 'package:mb_app_root/widget/texfield_widget.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:vibration/vibration.dart';
import '../routes/sideMenu.dart';
import '../utils/msj_toast.dart';

class ruta1 extends StatefulWidget {
  const ruta1({super.key});

  @override
  State<ruta1> createState() => _ruta1State();
}

class _ruta1State extends State<ruta1>
    with WidgetsBindingObserver
    implements ScannerCallback {
  List<Map<String, dynamic>> dataList = [];

  final textController = TextEditingController();
  final _searchQueryControl = TextEditingController();
  bool _isSearching = false;
  /*
  * Variables para el scanner
  */
  HoneywellScanner honeywellScanner = HoneywellScanner();
  ScannedData? scannedData;
  String? errorMessage;

  bool isDeviceSupported = false;
  bool scannerEnabled = false;
  bool scan1DFormats = true;
  bool scan2DFormats = true;

  TextEditingController textEditingValueController = TextEditingController();

  void _onSearchTextChanged(String newText) {
    /* * TODO: filter list */
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    honeywellScanner.scannerCallback = this;
    init();
  }

  Future<void> init() async {
    updateScanProperties();
    isDeviceSupported = await honeywellScanner.isSupported();
    if (mounted) setState(() {});
    if(isDeviceSupported) {
      honeywellScanner.startScanner();
    }
  }

  void updateScanProperties() {
    List<CodeFormat> codeFormats = [];
    if (scan1DFormats) codeFormats.addAll(CodeFormatUtils.ALL_1D_FORMATS);
    if (scan2DFormats) codeFormats.addAll(CodeFormatUtils.ALL_2D_FORMATS);
    Map<String, dynamic> properties = {
      ...CodeFormatUtils.getAsPropertiesComplement(codeFormats),
      'DEC_CODABAR_START_STOP_TRANSMIT': true,
      'DEC_EAN13_CHECK_DIGIT_TRANSMIT': true,
    };
    honeywellScanner.setProperties(properties);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBarCustom(
          textScreen: AppConstantsTags.titlePagePrueba,
          onPressedIcon: (isSearching) {
            // recibe el boolean para limpiar caja de texto de busqueda
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text("Pistoleo!", style: TextStyle(fontSize: 16)),
            ),
            !isDeviceSupported
                ? ScannerMovilWidget(codigoBarrController: textController)
                : Container(),
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: size.width / 2.2,
                    child: ButtonCustom(
                        fontColor: Colors.white,
                        color: AppColors.primaryBlue,
                        onPressed: () async {
                          getInformation(textController.text);
                        },
                        icon: Icons.search,
                        label: "Buscar",
                        isEnabled: true)),
                SizedBox(
                    width: size.width / 2.2,
                    child: ButtonCustom(
                        fontColor: Colors.black,
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomCupertinoDialog(
                                title: 'Confirmar',
                                content: '¿Seguro de Limpiar?',
                                confirmText: 'Si',
                                cancelText: 'No',
                                onConfirm: () {
                                  textController.clear();
                                  dataList.clear();
                                  setState(() {

                                  });
                                  /*
                                  Todo: clear data list
                                  */
                                },
                                onCancel: () {
                                  // Acción cuando se selecciona No
                                },
                              );
                            },
                          );
                        },
                        icon: Icons.cleaning_services,
                        label: "Limpiar",
                        isEnabled: true,
                        color: AppColors.btnWhite)),
                ],
            ),
            Expanded( // Usar Expanded para que el ListView ocupe el espacio restante
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final item = dataList[index];
                  return ListTile(
                    title: Center(child: Row(
                      children: [
                        Text("OP: "),
                        Text(item['opProduccion']),
                      ],
                    )),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text("TIPO: "),
                            Text(item['tipo']),
                          ],
                        ),
                        Row(
                          children: [
                            Text("CODIGO: "),
                            Text(item['codBarra']),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),)
          ],
        ),
      ),
    );
  }

  @override
  void onDecoded(ScannedData? scannedData) {
    // TODO: implement onDecoded
    setState(() {
      //this.scannedData = scannedData;
      /* textController.clear();
         textController.text = scannedData?.code ?? "";
      */
      final dataScan = scannedData?.code ?? "";
      if(dataScan.isNotEmpty){
        getInformation(scannedData!.code!);
      }
    });
  }


  @override
  void onError(Exception error) {
    // TODO: implement onError
    setState(() {
      errorMessage = error.toString();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        honeywellScanner.resumeScanner();
        break;
      case AppLifecycleState.inactive:
        honeywellScanner.pauseScanner();
        break;
      case AppLifecycleState
            .paused: //AppLifecycleState.paused is used as stopped state because deactivate() works more as a pause for lifecycle
        honeywellScanner.pauseScanner();
        break;
      case AppLifecycleState.detached:
        honeywellScanner.pauseScanner();
        break;
      default:
        break;
    }
  }

  Future<void> getInformation(String value) async {
    setState(() {});
    print(textController.text);
    try {
      final jsonData = await ProductService.obtenerDatosEtiqueta(value);
      //await ProductService.obtenerDatosDesdeJson();
      print(jsonData);

      bool existeCodigoBarra = false;
      existeCodigoBarra = dataList.any((element) => element['codBarra'] == jsonData["codBarra"]);
      if(!existeCodigoBarra) {
        dataList.add(jsonData);
        await Future.delayed(const Duration(microseconds: 2));
      }else{
        ToastMsjWidget.displayMotionToast(context,
            mensaje: 'Ya se encuentra ingresada',
            tiempoespera: 5,
            type: ToastType.warning,
            onChange: () {});
        Vibration.vibrate();

      }

      setState(() {

      });

    } catch (e) {
      ToastMsjWidget.displayMotionToast(context,
          mensaje: 'Error al cargar: $e',
          tiempoespera: 5,
          type: ToastType.warning,
          onChange: () {});
    }

  }
}
