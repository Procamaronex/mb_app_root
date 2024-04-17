import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/menu.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final Map<String, Widget> iconos = HashMap();
  late List<Menu> menus = [];
  bool exito = false;

  @override
  void initState() {
    exito = false;
    iconos.addAll({"phone_iphone": const Icon(Icons.phone_iphone)});
    iconos.addAll(
        {"keyboard_arrow_right": const Icon(Icons.keyboard_arrow_right)});
    iconos.addAll({"barcode_reader": const Icon(Icons.barcode_reader)});
    iconos.addAll({"persona": const Icon(Icons.person)});
    iconos.addAll({"warehouse": const Icon(Icons.warehouse)});
    iconos.addAll({"ac_unit": const Icon(Icons.ac_unit)});
    iconos.addAll({"pageview": const Icon(Icons.pageview)});
    iconos.addAll({"widgets": const Icon(Icons.widgets)});
    iconos.addAll({"qr_code": const Icon(Icons.qr_code)});
    iconos.addAll({"info": const Icon(Icons.info)});
    cargarMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child:
          Image.asset('assets/images/gds_procamaronex.png')),
          Column(
            children: menus.map((menu) {
              return _buildMenuItem(menu);
            }).toList(),
          )
        ],
      ),
    );
  }

  //   @override
  // Widget build(BuildContext context) {
  //     final size = MediaQuery.of(context).size;
  //
  //     return Drawer(
  //     backgroundColor: Colors.white,
  //     child:  ListView(
  //       children: const [
  //         ListTile(
  //           title: Text("SideBar"),
  //         ),
  //         Column(
  //           children:menus.map((menu){
  //             return _buildMenuItem(menu);
  //           }).toList(),
  //         )
  //       ],
  //     ),
  //   );
  // }
  void cargarMenu() async {
    await rootBundle.loadString("lib/utils/json_rutas.json").then((v) async {
      menus = menuFromJson(v);
      setState(() {});
    });
  }

  Widget _buildMenuItem(Menu menu) {
    if (menu.children == null || menu.children!.isEmpty) {
      // No children, return ListTile
      return ListTile(
        leading: iconos["${menu.iconoLeading}"],
        trailing: iconos["${menu.iconoTrailing}"],
        title: Text(menu.opcion),
        onTap: () {
          Navigator.of(context).pushNamed(menu.ruta, arguments: true);
        },
      );
    } else {
      // Has children, return ExpansionTile
      return ExpansionTile(
        leading: iconos[
            "${menu.iconoLeading}"], //Icon(_getIconData(menu.iconoLeading)),
        //trailing: Icon(_getIconData(menu.iconoTrailing)),
        title: Text(menu.opcion),
        children: menu.children!
            .map((childMenu) => _buildMenuItem(childMenu))
            .toList(),
      );
    }
  }
}
