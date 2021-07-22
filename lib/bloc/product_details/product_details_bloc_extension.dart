
import 'package:customer/bloc/common/favorite_ui_model.dart';
import 'package:customer/bloc/common/favorites_request.dart';
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/bloc/product_details/product_details_bloc.dart';
import 'package:customer/data/model/product.dart';
import 'package:customer/data/model/product_details.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/ios/ui/product_details/product_details_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

extension ProductDetailsBlocExtension on ProductDetailsBloc {
  Stream<Resource<ProductDetailsUiModel>> buildProductDetailsUiModelStream(String productId) => repository
      .productDetailsStream(productId)
      .switchMap(_buildUiModelStream)
      .map((uiModel) => Resource.success(data: uiModel))
      .startWith(Resource.loading())
      .onErrorReturnWith((error) => Resource.error(error: error));

  Stream<ProductDetailsUiModel> _buildUiModelStream(ProductDetails productDetails) => Rx
      .combineLatestList([
        _buildHeaderUiModelFuture(productDetails).asStream(),
        _buildTitlePriceItemUiModelFuture(productDetails).asStream(),
        _buildRatingItemUiModelFuture(productDetails).asStream(),
        _buildDescriptionItemUiModelStream(productDetails),
        _buildSupplierLinkItemUiModelFuture(productDetails).asStream(),
        _buildCategoryInfoItemUiModelFuture(productDetails).asStream(),
        _buildStatusInfoItemUiModelFuture().asStream(),
        _buildShipmentInfoItemUiModelFuture().asStream(),
        _buildFavoritesActionItemUiModelFuture().asStream(),
        _buildShortListActionItemUiModelFuture().asStream(),
        _buildShoppingCartActionItemUiModelFuture().asStream(),
        _buildSimilarProductUiModelsStream(productDetails.categoryId),
      ])
      .map((values) => ProductDetailsUiModel(
        id: productDetails.id,
        headerUiModel: values[0],
        itemUiModels: List<ProductDetailsItemUiModel>.from(values.sublist(1)),
      ));

  Future<ProductDetailsHeaderUiModel> _buildHeaderUiModelFuture(ProductDetails productDetails) async {
    try {
      String imageUrl = await repository.productImageUrlFuture(productDetails.image);
      String titleText = productDetails.title;

      return ProductDetailsHeaderUiModel(
        imageUrl: imageUrl,
        titleText: titleText,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsTitlePriceItemUiModel> _buildTitlePriceItemUiModelFuture(ProductDetails productDetails) async {
    try {
      String titleText = productDetails.title;
      String price = '\$${productDetails.price}';

      return ProductDetailsTitlePriceItemUiModel(
        title: titleText,
        price: price,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsRatingItemUiModel> _buildRatingItemUiModelFuture(ProductDetails productDetails) async {
    try {
      return ProductDetailsRatingItemUiModel(
        ratingText: '4.8',
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Stream<ProductDetailsDescriptionItemUiModel> _buildDescriptionItemUiModelStream(ProductDetails productDetails) => isDescriptionExpandedSubject
    .startWith(false)
    .asyncMap((isDescriptionExpanded) async {
      try {
        String descriptionText = productDetails.description;
        int descriptionMaxLines = isDescriptionExpanded ? null : 3;
        String expandButtonText = isDescriptionExpanded ? 'less' : 'more';
        Function expandButtonAction = () {
          isDescriptionExpandedSubject.add(!isDescriptionExpanded);
        };

        return ProductDetailsDescriptionItemUiModel(
            descriptionText: descriptionText,
            descriptionMaxLines: descriptionMaxLines,
            expandButtonText: expandButtonText,
            expandButtonAction: expandButtonAction,
        );
      } catch (error) {
        // todo throw custom error
      }
    });

  Future<ProductDetailsLinkItemUiModel> _buildSupplierLinkItemUiModelFuture(ProductDetails productDetails) async {
    try {
      String titleText = 'Supplier';
      String linkText = productDetails.supplierTitle;

      return ProductDetailsLinkItemUiModel(
        titleText: titleText,
        linkText: linkText,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsInfoItemUiModel> _buildCategoryInfoItemUiModelFuture(ProductDetails productDetails) async {
    try {
      String titleText = 'Category';
      String valueText = productDetails.categoryTitle;

      return ProductDetailsInfoItemUiModel(
        titleText: titleText,
        valueText: valueText,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsInfoItemUiModel> _buildStatusInfoItemUiModelFuture() async {
    try {
      String titleText = 'Status';
      String valueText = 'On stock';

      return ProductDetailsInfoItemUiModel(
        titleText: titleText,
        valueText: valueText,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsInfoItemUiModel> _buildShipmentInfoItemUiModelFuture() async {
    try {
      String titleText = 'Shipment';
      String valueText = 'On request';

      return ProductDetailsInfoItemUiModel(
        titleText: titleText,
        valueText: valueText,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsActionItemUiModel> _buildFavoritesActionItemUiModelFuture() async {
    try {
      String actionText = 'Remove from favorites';
      String asset = 'assets/icons/heart_checked.png';
      double topMargin = 44.0;

      return ProductDetailsActionItemUiModel(
        actionText: actionText,
        asset: asset,
        topMargin: topMargin,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsActionItemUiModel> _buildShortListActionItemUiModelFuture() async {
    try {
      String actionText = 'Add to short list';
      String asset = 'assets/icons/short_list.png';
      double topMargin = 0.0;

      return ProductDetailsActionItemUiModel(
        actionText: actionText,
        asset: asset,
        topMargin: topMargin,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Future<ProductDetailsActionItemUiModel> _buildShoppingCartActionItemUiModelFuture() async {
    try {
      String actionText = 'Add to cart';
      String asset = 'assets/icons/cart_action.png';
      double topMargin = 0.0;

      return ProductDetailsActionItemUiModel(
        actionText: actionText,
        asset: asset,
        topMargin: topMargin,
      );
    } catch (error) {
      // todo throw custom error
    }
  }

  Stream<ProductDetailsSimilarProductsItemUiModel> _buildSimilarProductUiModelsStream(String categoryId) => repository
      .popularCategoryProductsStream(categoryId)
      .asyncMap((products) => Stream
        .fromIterable(products)
        .asyncMap((product) => _buildProductUiModelFuture(product))
        .toList())
      .map((similarProductUiModels) => ProductDetailsSimilarProductsItemUiModel(
        similarProductUiModels: similarProductUiModels,
        containerWidgetHeight: _calculateBrowseProductWidgetSize().height,
        productWidgetSize: _calculateBrowseProductWidgetSize(),
      ));

  Future<ProductUiModel> _buildProductUiModelFuture(Product product) async {
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
      //
    }
  }

  FavoriteUiModel _buildFavoriteUiModel(Product product, bool isFavorited) {
    try {
      String assetName = isFavorited
          ? 'assets/icons/heart_checked.png' : 'assets/icons/heart_unchecked.png';

      FavoritesRequest request = isFavorited
          ? FavoritesRequest.remove(product) : FavoritesRequest.add(product);

      Function action = () {
        //favoriteRequestsSubject.add(request);
      };

      return FavoriteUiModel(assetName: assetName, action: action);
    } catch (error) {
      //throw BrowseBlocInvalidFavoriteException();
    }
  }

  Size _calculateBrowseProductWidgetSize() {
    double width = (MediaQuery.of(context).size.width - 24.0 * 2 - 12.0)/2;
    double height = width/0.66;

    return Size(width, height);
  }
}