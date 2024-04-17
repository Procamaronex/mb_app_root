import 'dart:async';

import 'package:flutter/material.dart';

class Ejemplos extends StatefulWidget {
  const Ejemplos({super.key});

  @override
  State<Ejemplos> createState() => _EjemplosState();
}

class _EjemplosState extends State<Ejemplos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: ElevatedButton(
              onPressed: () => {realizarEjemplos()},
              child: const Text("LLamar metodo"),
            ))
          ],
        ),
      ),
    );
  }

  realizarEjemplos() async {
    //int y double son subtipos de num.
    // Enteros sin punto decimal, no mayores de 64bits.
    int x = 1;
    int hex = 0xDEADBEEF;
    // Números decimales, de 64bits.
    double y = 1.1;
    print(x + y);

    double exponents = 1.42e5;
    print(exponents);

    //Convertir una cadena a un número, y viceversa.
    var one = int.parse('1'); // de string a int
    var onePointOne = double.parse('1.1'); // de string a double
    String oneAsString = 1.toString(); // de int a string
    String piAsString = 3.14159.toStringAsFixed(2); // double a string

    print(one);
    print(onePointOne);
    var s1 = 'Las comillas simples funcionan bien para los literales';
    var s2 = "Las comillas dobles funcionan igual de bien";
    var s3 = 'El fácil escapar del delimitador de cadena con \n';
    var s4 = '''
             You can create multi-line strings like this one.
              ''';
    var s5 = """This is also a multi-line string.""";
    var datoConcatenado = '$one $s1';
    print(datoConcatenado);

    //booleans
    // Chequear una cadena vacía.
    var fullName = '';
    print(fullName.isEmpty); //true
    fullName = "Daniel";
    print(fullName.isEmpty); //false

    // Chequear cero.
    var hitPoints = 0;
    print(hitPoints <= 0); //true
    hitPoints = 9;
    print(hitPoints <= 0); //false

    // Chequear null.
    var unicorn;
    print(unicorn == null); // true
    unicorn = "Pony";
    print(unicorn == null); // false

    // Chequear NaN.
    var iMeantToDoThis = 0 / 0;
    print(iMeantToDoThis.isNaN); //true
    iMeantToDoThis = 8 / 2;
    print(iMeantToDoThis.isNaN); //false

    //listas
    var list = [1, 2, 3]; // lista simple que infiere el tipo List<int>
    print(list.length);
    print(list.length == 3);
    print(list[1] == 2);
    list[1] = 1;
    print(list[1] == 1);
    // Crea una lista constante en tiempo de compilación
    var constantList = const [1, 2, 3];
    print(constantList);
    //mapas
    print("mapas");

    // Se infiere el tipo Map<String,String>
    var gifts = {
      'first': 'partridge',
      'second': 'turtledoves',
      'fifth': 'golden rings'
    };
// Se infiere el tipo Map<int,String>
    var nobleGases = {
      2: 'helium',
      10: 'neon',
      18: 'argon',
    };
    var gifts2 = Map();
    gifts2['first'] = 'partridge';
    gifts2['second'] = 'turtledoves';
    gifts2['fifth'] = 'golden rings';
    var nobleGases2 = Map();
    nobleGases2[2] = 'helium';
    nobleGases2[10] = 'neon';
    nobleGases2[18] = 'argon';
    gifts2['fourth'] = 'calling birds'; // Agrega un par key-value
    print(gifts2['first']); // recupera el valor para la clave "first"

    print(gifts);
    print(nobleGases);
    print(gifts2);
    print(nobleGases2);

    voidFunction();
    // Instance of '_Future<void>
    print('Then myFunction call ended');
    await futureVoidFunction();
    print("Fin");
    var data = await crearOrdenMensaje();
    print(data);
  }

  void voidFunction() {
    print("Metodo que no retorna nada ");
  }

  Future<void> futureVoidFunction() async {
    // Demorar 2 segundos en la ejecucion
    await Future.delayed(Duration(seconds: 2));
    print('Tema');
  }

  Future<String> crearOrdenMensaje() async {
    var orden = await buscarOrdenUsuario();
    return 'Your order is: $orden';
  }

  Future<String> buscarOrdenUsuario() =>
      // Imagina que esto es un poco mas complejo y lento
      Future.delayed(
        Duration(seconds: 2),
        () => 'Cafe Americano',
      );
}
