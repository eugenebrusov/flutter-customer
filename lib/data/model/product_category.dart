
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProductCategory extends Equatable {
  final String id;
  final String title;
  final int productCount;

  ProductCategory({
    @required this.id,
    @required this.title,
    @required this.productCount,
  });

  @override
  List<Object> get props => [id, title, productCount];
}