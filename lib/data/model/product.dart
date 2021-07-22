
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.supplierTitle,
    @required this.price,
  });

  final String id;
  final String image;
  final String title;
  final String supplierTitle;
  final double price;

  @override
  List<Object> get props => [id, image, title, supplierTitle, price];
}