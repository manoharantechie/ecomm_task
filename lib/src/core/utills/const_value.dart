import 'package:flutter/material.dart';

class ConstantValues {

  static const double defaultPadding = 16.0;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  String baseURl="https://fakestoreapi.com/";
}