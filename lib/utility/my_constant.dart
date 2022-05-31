import 'package:flutter/material.dart';

class MyConstant {
  //field
  static Color primary = const Color.fromARGB(255, 22, 137, 152);
  static Color dart = const Color.fromARGB(255, 4, 24, 55);

  //method

  BoxDecoration basicBox() {
    return BoxDecoration(
      color: Colors.yellow.withOpacity(0.35),
    );
  }

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 48,
      color: dart,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 18,
      color: dart,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      color: dart,
      fontWeight: FontWeight.normal,
    );
  }

   TextStyle h3ActinvStyle() {
    return TextStyle(
      fontSize: 14,
      color: Colors.blue.shade500,
      fontWeight: FontWeight.normal,
    );
  }

   TextStyle h3ErrorStyle() {
    return TextStyle(
      fontSize: 14,
      color: Colors.red.shade700,
      fontWeight: FontWeight.w500,
    );
  }
}
