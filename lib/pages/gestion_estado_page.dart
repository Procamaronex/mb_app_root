import 'package:flutter/material.dart';
import 'package:mb_app_root/routes/sideMenu.dart';
import 'package:mb_app_root/utils/msj_toast.dart';
import 'package:provider/provider.dart';
import '../services/producto_service.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../view_models/productos_view_model.dart';
import '../widget/appbar_drawer.dart';
import '../widget/button_widget.dart';
import '../widget/texfield_widget.dart';

class GestionEstadoPage extends StatefulWidget {
  const GestionEstadoPage({super.key});

  @override
  State<GestionEstadoPage> createState() => _GestionEstadoPageState();
}

class _GestionEstadoPageState extends State<GestionEstadoPage> {
  final textController = TextEditingController();
  final _searchQueryControl = TextEditingController();
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    ProductosViewModel provider = context.read<ProductosViewModel>();
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
            const Center(
              child: Text("GESTION DE ESTADO!", style: TextStyle(fontSize: 16)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width / 1.5,
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
                    onPressed: () async {
                      if (textController.text.isEmpty) {
                        ToastMsjWidget.displayMotionToast(context,
                            mensaje: "Ingrese o escanee el código de barra",
                            tiempoespera: 5,
                            type: ToastType.warning,
                            onChange: () {});
                        return;
                      }

                      try {
                        final jsonData =
                            await ProductService.obtenerDatosEtiqueta(
                                textController.text);
                        print(jsonData);
                        provider.asignarElementoALista(elemento: jsonData);
                        setState(() {});
                      } catch (e) {
                        ToastMsjWidget.displayMotionToast(context,
                            mensaje: 'Error al cargar: $e',
                            tiempoespera: 5,
                            type: ToastType.error,
                            onChange: () {});
                      }
                    },
                    icon: Icons.search,
                    label: "Buscar",
                    isEnabled: true)),
          ])))),
    );
  }

  void _onSearchTextChanged(String newText) {
    /* * TODO: filter list */
  }
}
