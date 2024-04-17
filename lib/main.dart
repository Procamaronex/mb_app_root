import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mb_app_root/pages/ejemplos.dart';
import 'package:mb_app_root/pages/obtener.dart';
import 'package:mb_app_root/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:mb_app_root/utils/app_theme.dart';
import 'package:mb_app_root/view_models/client_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      ChangeNotifierProvider(
        create:(_)=>
            clienteViewModel(), //QRScan //ShowMasterProvider //ProductoViewModel
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Procamaronex',
      theme: AppThemeData.light,
      /*theme: ThemeData(
        //primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),*/
      routes: appRoute,
      initialRoute: 'ruta1',//Ejemplos(), //const MyHomePage(title: 'Bases'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
