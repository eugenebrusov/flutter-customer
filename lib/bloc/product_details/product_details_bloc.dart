import 'package:customer/bloc/product_details/product_details_bloc_extension.dart';
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/data/source/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailsBloc {
  ProductDetailsBloc({
    @required this.context,
    @required this.repository,
    @required String productId
  }) : isDescriptionExpandedSubject = PublishSubject(),
        productDetailsUiModelStream = buildProductDetailsUiModelStream(productId);

  final BuildContext context;
  final Repository repository;
  final PublishSubject<bool> isDescriptionExpandedSubject;
  final Stream<Resource<ProductDetailsUiModel>> productDetailsUiModelStream;

  void dispose() {
    isDescriptionExpandedSubject.close();
  }
}