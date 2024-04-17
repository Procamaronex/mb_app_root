import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';

class AppColors {
  static const MaterialColor primaryBlueMaterial = MaterialColor(
    _primaryBlueValue,
    <int, Color>{
      50: Color(0xFF7797F6),
      100: Color(0xFF6787E7),
      200: Color(0xFF4D69BC),
      300: Color(0xff1f73b4),
      400: Color(0xff1f73b4),
      500: Color(_primaryBlueValue),
      600: Color(0xFF183076),
      700: Color(0xFF122A73),
      800: Color(0xFF122A73),
      900: Color(0xFF122A73),
    },
  );
  // static const _primaryBlueValue = 0xff1e367c;
  static const _primaryBlueValue = 0xff1f73b4;

  // static const primaryBlue = Color(0xff1e367c);
  static const primaryBlue = Color(0xff1f73b4);

  // static const secondaryBlue = Color(0xFF27459C);
  static const secondaryBlue = Color.fromRGBO(32, 145, 236, 1);
  static const printer = Color.fromRGBO(241, 90, 56, 1);
  static const textosBlack = Color(0xff403f3b);
  static const btnBackground = Color(0xff0065b0);
  static const btnBackgroundDisabled = Color.fromARGB(255, 122, 157, 185);
  static const btnWhite = Color.fromARGB(255, 255, 255, 255);
  static const colorsHorario = [
    Color(0xffFFB6C1),
    Color(0xffE6E6FA),
    Color(0xff9CEEEF),
    Color(0xff9ACD32),
    Color(0xffF8A7F8),
    Color(0xffF9F0A0),
    Color(0xffFFD2AF),
    Color(0xffB0C4DE),
    Color(0xff7CFC00),
    Color(0xff7FFFD4),
    Color(0xff00BFFF),
    Color(0xffFF7F50),
    Color(0xffD8BFD8),
    Color(0xffFFA500),
    Color(0xff00FFFF),
    Color(0xffFFA07A),
    Color(0xffFF69B4),
    Color(0xffFF8C00),
    Color(0xffFFFF00),
    Color(0xff00FA9A),
    Color(0xff1E90FF),
  ];
  static const Color darkTextColor = Color(0xff171717);
  static const Color unSelectedTextColor = Color(0xffc9c9c9);
}
