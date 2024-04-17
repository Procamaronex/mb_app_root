import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    required this.textScreen,
    required this.onPressedIcon,
    required this.searchElement,
    required this.showActions,
    required this.backgroundColor,
    required this.searchQueryController,
    required this.onSearchTextChanged,
  });

  final String textScreen;
  final void Function(bool) onPressedIcon; //final VoidCallback? onPressedIcon;
  final bool searchElement;
  final bool showActions;
  final Color backgroundColor;
  final TextEditingController searchQueryController;
  final Function(String) onSearchTextChanged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu,
                color: Colors.white), // Color del icono de hamburguesa
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: _getElementTitle(),
      backgroundColor: backgroundColor,
      centerTitle: true,
      actions: showActions ? _buildCustomElevatedButton(context) : [],
    );
  }

  Widget _getElementTitle() {
    if (searchElement) {
      return TextField(
        controller: searchQueryController,
        autofocus: true,
        onChanged:
            onSearchTextChanged, // Llama a la función cuando cambia el texto,
        decoration: const InputDecoration(
          hintText: 'Buscar...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      );
    } else {
      return Text(
        textScreen,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }
  }

  List<Widget> _buildCustomElevatedButton(BuildContext contextA) {
    if (searchElement) {
      return [
        IconButton(
            onPressed: () {
              onPressedIcon(false);
            },
            icon: const Icon(Icons.close, color: Colors.white)),
        _buildCustomPadding()
      ];
    } else {
      return [
        IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              onPressedIcon(true);
            }),
        _buildCustomPadding()
      ];
    }
  }

  Padding _buildCustomPadding() {
    return const Padding(padding: EdgeInsets.only(right: 10));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/*
  [
  _buildCustomElevatedButton(),
  const Padding(padding: EdgeInsets.only(right: 10))
  ]
  */
/*ElevatedButton _buildCustomElevatedButton(){
    return searchElement? ElevatedButton(

    ):ElevatedButton(
      onPressed: onPressedIcon,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            // Cambiar el color del botón cuando está presionado
            if (states.contains(MaterialState.pressed)) {
              return backgroundColor;
            }
            // Mantener el color predeterminado cuando no está presionado
            return Colors.transparent;
          },
        ),
      ),
      child: const Icon(Icons.move_up_sharp, color: Colors.white),
    );
  }
*/

/*AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white), // Color del icono de hamburguesa
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text("Movimientos",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12)),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        actions: const [
          ElevatedButton(
            onPressed: null,
            child: Icon(Icons.alarm_add, color: Colors.white),
          ),
          Padding(padding: EdgeInsets.only(right: 10))
        ],
      ),*/
