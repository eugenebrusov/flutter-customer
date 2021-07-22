import 'dart:ui';

import 'package:customer/bloc/browse/browse_bloc.dart';
import 'package:customer/bloc/browse/browse_bloc_exception.dart';
import 'package:customer/bloc/common/favorite_ui_model.dart';
import 'package:customer/bloc/common/favorites_request.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/data/model/product.dart';
import 'package:customer/data/model/product_category.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/ios/ui/product_details/product_details_screen.dart';
import 'package:customer/localizations/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

extension BrowseBlocExtension on BrowseBloc {
  Size calculateBrowseProductWidgetSize() {
    double width = (MediaQuery.of(context).size.width - 24.0 * 2 - 12.0)/2;
    double height = width/0.66;

    return Size(width, height);
  }

  Stream<Resource<List<BrowseCategoryUiModel>>> buildCategoryUiModelsStream() => reloadCategoriesSubject
    .startWith(null)
    .switchMap((_) {
      return repository
          .productCategoriesFuture()
          .then((productCategory) {
            return Stream.fromIterable(productCategory)
                .asyncMap((productCategory) => buildCategoryUiModelFuture(productCategory))
                .toList();
          })
          .asStream()
          .map((productCategoryUiModels) => Resource.success(data: productCategoryUiModels))
          .startWith(Resource.loading())
          .onErrorReturnWith((error) => Resource.error(error: error));
    })
    .shareReplay(maxSize: 1);

  Future<BrowseCategoryUiModel> buildCategoryUiModelFuture(ProductCategory productCategory) async {
    try {
      String id = productCategory.id;
      String title = productCategory.title;
      String seeAllButtonTitle = AppLocalizations.of(context).buttonTitleSeeAll(productCategory.productCount).toUpperCase();
      Size productWidgetSize = browseProductWidgetSize;
      double categoryWidgetHeight = productWidgetSize.height;

      Stream<Resource<List<ProductUiModel>>> productUiModelsStream = repository
        .popularCategoryProductsStream(productCategory.id)
        .asyncMap((products) {
          return Stream.fromIterable(products)
              .asyncMap((product) => buildProductUiModelFuture(product))
              .toList();
        })
        .map((productUiModels) => Resource.success(data: productUiModels))
        .startWith(Resource.loading())
        .onErrorReturn(Resource.error(error: BrowseBlocInvalidProductCategoryException()))
        .share()
        .publishReplay(maxSize: 1)
        .autoConnect();

      return BrowseCategoryUiModel(
          id: id,
          title: title,
          seeAllButtonTitle: seeAllButtonTitle,
          categoryWidgetHeight: categoryWidgetHeight,
          productWidgetSize: productWidgetSize,
          productUiModelsStream: productUiModelsStream
      );
    } catch (error) {
      throw BrowseBlocInvalidProductCategoryException();
    }
  }

  Future<ProductUiModel> buildProductUiModelFuture(Product product) async {
    try {
      String id = product.id;
      String imageUrl = await repository.productImageUrlFuture(product.image);
      String title = product.title;
      String supplierTitle = product.supplierTitle.toUpperCase();
      String price = '\$${product.price}';
      Stream<Resource<FavoriteUiModel>> favoriteUiModelStream = repository
        .isProductFavoritedStream(id)
        .map((isFavorited) => _buildFavoriteUiModel(product, isFavorited))
        .map((uiModel) => Resource.success(data: uiModel))
        .startWith(Resource.loading())
        .onErrorReturnWith((error) => Resource.error(error: error));
      Function selectAction = () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName, arguments: id);
      };

      return ProductUiModel(id: id,
          imageUrl: imageUrl,
          title: title,
          supplierTitle: supplierTitle,
          price: price,
          favoriteUiModelStream: favoriteUiModelStream,
          selectAction: selectAction);
    } catch (error) {
      throw BrowseBlocInvalidProductException();
    }
  }

  FavoriteUiModel _buildFavoriteUiModel(Product product, bool isFavorited) {
    try {
      String assetName = isFavorited
          ? 'assets/icons/heart_checked.png' : 'assets/icons/heart_unchecked.png';

      FavoritesRequest request = isFavorited
          ? FavoritesRequest.remove(product) : FavoritesRequest.add(product);

      Function action = () {
        favoriteRequestsSubject.add(request);
      };

      return FavoriteUiModel(assetName: assetName, action: action);
    } catch (error) {
      throw BrowseBlocInvalidFavoriteException();
    }
  }

  Stream<Resource<void>> buildFavoriteStream() => favoriteRequestsSubject
      .switchMap((request) => (request is AddToFavoritesRequest) ? _handleAddToFavoriteRequest(request) : _handleRemoveFromFavoriteRequest(request))
      .share()
      .publishReplay(maxSize: 1)
      .autoConnect();

  Stream<Resource<void>> _handleAddToFavoriteRequest(AddToFavoritesRequest request) => repository
      .addToFavorites(request.product)
      .asStream()
      .map((_) => Resource.success())
      .startWith(Resource.loading())
      .onErrorReturnWith((error) => Resource.error(error: error));

  Stream<Resource<void>> _handleRemoveFromFavoriteRequest(RemoveFromFavoritesRequest request) => repository
      .removeFromFavorites(request.product)
      .asStream()
      .map((_) => Resource.success())
      .startWith(Resource.loading())
      .onErrorReturnWith((error) => Resource.error(error: error));
}
