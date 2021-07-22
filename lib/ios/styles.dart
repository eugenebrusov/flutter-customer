
import 'package:flutter/cupertino.dart';

abstract class Styles {
  static const TextStyle categoryName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 22,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle productName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productPrice = TextStyle(
    color: Color.fromRGBO(93, 161, 163, 1.0),
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle supplierName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.6),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productListName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productListPrice = TextStyle(
    color: Color.fromRGBO(93, 161, 163, 1.0),
    fontSize: 22,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle productListSupplierName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.6),
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
}