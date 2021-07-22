
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class ProductDetails extends Equatable {
  ProductDetails({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.price,
    @required this.description,
    @required this.supplierTitle,
    @required this.categoryId,
    @required this.categoryTitle,
  });

  final String id;
  final String image;
  final String title;
  final double price;
  final String description;
  final String supplierTitle;
  final String categoryId;
  final String categoryTitle;

  @override
  List<Object> get props => [id, image, title, price, description, supplierTitle];
}