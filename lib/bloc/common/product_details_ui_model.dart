
import 'dart:ui';

import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProductDetailsUiModel extends Equatable {
  const ProductDetailsUiModel({
    @required this.id,
    @required this.headerUiModel,
    @required this.itemUiModels
  });

  final String id;
  final ProductDetailsHeaderUiModel headerUiModel;
  final List<ProductDetailsItemUiModel> itemUiModels;

  List<Object> get props => [id, headerUiModel, itemUiModels];
}

class ProductDetailsHeaderUiModel extends Equatable {
  const ProductDetailsHeaderUiModel({
    @required this.imageUrl,
    @required this.titleText,
  });

  final String imageUrl;
  final String titleText;

  List<Object> get props => [imageUrl, titleText];
}

abstract class ProductDetailsItemUiModel extends Equatable {
  const ProductDetailsItemUiModel();
}

class ProductDetailsTitlePriceItemUiModel extends ProductDetailsItemUiModel {
  const ProductDetailsTitlePriceItemUiModel({
    @required this.title,
    @required this.price,
  }) : super();

  final String title;
  final String price;

  List<Object> get props => [title, price];
}

class ProductDetailsRatingItemUiModel extends ProductDetailsItemUiModel {
  const ProductDetailsRatingItemUiModel({
    @required this.ratingText,
  }) : super();

  final String ratingText;

  List<Object> get props => [ratingText];
}

class ProductDetailsDescriptionItemUiModel extends ProductDetailsItemUiModel {
  const ProductDetailsDescriptionItemUiModel({
    @required this.descriptionText,
    @required this.descriptionMaxLines,
    @required this.expandButtonText,
    @required this.expandButtonAction,
  }) : super();

  final String descriptionText;
  final int descriptionMaxLines;
  final String expandButtonText;
  final Function expandButtonAction;

  List<Object> get props => [descriptionText, expandButtonText];
}

class ProductDetailsLinkItemUiModel extends ProductDetailsItemUiModel {
  const ProductDetailsLinkItemUiModel({
    @required this.titleText,
    @required this.linkText,
  }) : super();

  final String titleText;
  final String linkText;

  List<Object> get props => [titleText, linkText];
}

class ProductDetailsInfoItemUiModel extends ProductDetailsItemUiModel {
  const ProductDetailsInfoItemUiModel({
    @required this.titleText,
    @required this.valueText,
  }) : super();

  final String titleText;
  final String valueText;

  List<Object> get props => [titleText, valueText];
}

class ProductDetailsActionItemUiModel extends ProductDetailsItemUiModel {
  const ProductDetailsActionItemUiModel({
    @required this.actionText,
    @required this.asset,
    @required this.topMargin,
  }) : super();

  final String actionText;
  final String asset;
  final double topMargin;

  List<Object> get props => [actionText, asset, topMargin];
}

class ProductDetailsSimilarProductsItemUiModel extends ProductDetailsItemUiModel {
  const ProductDetailsSimilarProductsItemUiModel({
    @required this.similarProductUiModels,
    @required this.containerWidgetHeight,
    @required this.productWidgetSize,
  }) : super();

  final List<ProductUiModel> similarProductUiModels;
  final double containerWidgetHeight;
  final Size productWidgetSize;

  List<Object> get props => [similarProductUiModels];
}