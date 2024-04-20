import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mb_app_root/routes/sideMenu.dart';
import 'package:mb_app_root/utils/constants.dart';
import 'package:mb_app_root/view_models/client_view_model.dart';
import 'package:provider/provider.dart';

import '../widget/appbar_drawer.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  final _searchQueryControl = TextEditingController();
  bool _isSearching = false;

  void _onSearchTextChanged(String newText) {
    /* * TODO: filter list */
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      clienteViewModel iclienteViewModel = clienteViewModel();
      iclienteViewModel.init(contextA: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBarCustom(
        textScreen: AppConstantsTags.titlePageClient,
        onPressedIcon: (isSearching) {
          if (!isSearching) {
            _searchQueryControl.clear();
          }
          setState(() {
            _isSearching = isSearching;
          });
        },
        searchElement: _isSearching,
        showActions: true,
        backgroundColor: Colors.deepOrangeAccent,
        searchQueryController: _searchQueryControl,
        onSearchTextChanged: _onSearchTextChanged,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<clienteViewModel>(builder: (context, item, child) {
              return Container(
                width: size.width,
                height: size.height / 1.3,
                child: ListView.builder(
                  itemCount: item.clientes.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> cliente = item.clientes[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            cliente["nombres"],
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              );
            })
          ],
        ),
      )),
    );
  }
}
