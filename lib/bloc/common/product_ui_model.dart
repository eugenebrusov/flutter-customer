
import 'package:flutter/foundation.dart';
import 'package:customer/bloc/common/favorite_ui_model.dart';
import 'package:customer/data/model/resource.dart';

class ProductUiModel {
  const ProductUiModel({
    @required this.id,
    @required this.imageUrl,
    @required this.title,
    @required this.supplierTitle,
    @required this.price,
    @required this.favoriteUiModelStream,
    @required this.selectAction,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String supplierTitle;
  final String price;
  final Stream<Resource<FavoriteUiModel>> favoriteUiModelStream;
  final Function selectAction;
}