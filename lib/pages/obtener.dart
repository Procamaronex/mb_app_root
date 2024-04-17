import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mb_app_root/utils/app_colors.dart';
import 'package:mb_app_root/utils/constants.dart';
import 'package:mb_app_root/widget/appBarDrawer.dart';
import 'package:mb_app_root/widget/button_widget.dart';
import 'package:mb_app_root/widget/dialogCupertino.dart';
import 'package:mb_app_root/widget/texfield_widget.dart';

import '../routes/sideMenu.dart';

class ruta1 extends StatefulWidget {
  const ruta1({super.key});

  @override
  State<ruta1> createState() => _ruta1State();
}

class _ruta1State extends State<ruta1> {
  final textController = TextEditingController();
  final _searchQueryControl = TextEditingController();
  bool _isSearching = false;

  void _onSearchTextChanged(String newText) {
    /* * TODO: filter list */
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBarCustom(
          textScreen: AppConstantsTags.titlePagePrueba,
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text("Pistoleo!", style: TextStyle(fontSize: 16)),
            ),
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
                        onPressed: () {},
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
                        color: AppColors.btnWhite))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
