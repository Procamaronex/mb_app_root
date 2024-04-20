import 'package:flutter/cupertino.dart';

class ProductosViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> productos = [];

  ProductosViewModel._internal();
  static final ProductosViewModel _instance = ProductosViewModel._internal();
  factory ProductosViewModel() => _instance;
  void asignarElementoALista({required Map<String,dynamic> elemento}){
    productos.add(elemento);
    notifyListeners();
  }
  void asignarLista({required List<Map<String, dynamic>> elementos}){
    productos = elementos;
    notifyListeners();
  }
}