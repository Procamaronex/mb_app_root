import 'package:flutter/material.dart';
import 'package:mb_app_root/view_models/actividad_gestion_estado_vm.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../routes/sideMenu.dart';
import '../utils/constants.dart';
import '../view_models/validar_dispositivo.dart';
import '../widget/appbar_drawer.dart';
import '../widget/list_view_widget.dart';

class GestionEstadoConsultarCajas extends StatefulWidget {
  GestionEstadoConsultarCajas({Key? key}) : super(key: key);

  @override
  State<GestionEstadoConsultarCajas> createState() =>
      _GestionEstadoConsultarCajasState();
}

class _GestionEstadoConsultarCajasState
    extends State<GestionEstadoConsultarCajas> {
  final textController = TextEditingController();
  final _searchQueryControl = TextEditingController();
  bool _isSearching = false;

  bool isFromBottomSheet = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFromBottomSheet = ModalRoute.of(context)!.settings.arguments as bool;
      setState(() {});
    });
    Future.microtask(() {
      context.read<ValidarDispositivo>().asignarMensaje(tipo: "", msj: "");
      context.read<ActividadGestionEstadoViewModel>().cargarListaEscaneados(elementos: []);
      var actividadGestion = ActividadGestionEstadoViewModel();
      actividadGestion.cargarCodigos(contextB: context,usr: "dvega");
    });
  }

  @override
  Widget build(BuildContext contextA) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: isFromBottomSheet
          ? AppBarCustom(
              textScreen: AppConstantsTags.titleDetalles,
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
              onSearchTextChanged: _onSearchTextChanged)
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ActividadGestionEstadoViewModel>(
                builder: (context, filtro, child) {
              return consultaPorTipo(
                  registros: filtro.consultaEscaneados!.length,
                  context: contextA,
                  scrollController: _scrollController,
                  provider: filtro,
                  typeStateBloc: false);
            })
          ],
        ),
      ),
    );
  }

  void _onSearchTextChanged(String newText) {
    /* * TODO: filter list */
  }

  static Widget consultaPorTipo(
      {required int registros,
      required BuildContext context,
      required ScrollController scrollController,
      required ActividadGestionEstadoViewModel? provider,
      required bool typeStateBloc}) {
    final size = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info, // Aquí puedes cambiar el icono a tu elección
              color: Colors.blueGrey),
          Text(
            "Códigos escaneados $registros",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blueGrey, fontSize: 13),
          ),
        ],
      ),
      const SizedBox(height: 20),
      SizedBox(
        height: size.height /1.5,
        child: ListaProductoWidget(
            cont: context,
            scrollController: scrollController,
            size: size,
            listas: provider?.consultaEscaneados ?? []),
      ),
      const SizedBox(height: 20),
    ]);
  }
}
