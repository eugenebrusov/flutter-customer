
import 'package:customer/bloc/common/favorite_ui_model.dart';
import 'package:customer/bloc/common/favorites_request.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/bloc/favorites/favorites_bloc.dart';
import 'package:customer/bloc/favorites/favorites_bloc_exception.dart';
import 'package:customer/data/model/product.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/ios/ui/product_details/product_details_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

extension FavoritesBlocExtension on FavoritesBloc {
    Stream<Resource<List<ProductUiModel>>> buildProductUiModelsStream() => reloadSubject
        .startWith(null)
        .switchMap((_) {
          return repository
              .favoritedProductsStream()
              .asyncMap((products) {
                return Stream.fromIterable(products)
                    .asyncMap((product) => buildProductUiModelFuture(product))
                    .toList();
              })
              .switchMap(instantUnfavoriteStream)
              .map((productUiModels) => Resource.success(data: productUiModels))
              .startWith(Resource.loading())
              .onErrorReturnWith((error) => Resource.error(error: error));
        })
        .shareReplay(maxSize: 1);

    Stream<List<ProductUiModel>> instantUnfavoriteStream(List<ProductUiModel> uiModels) => favoriteRequestsSubject
        .startWith(null)
        .map((request) => (request != null) ? uiModels.where((uiModel) => uiModel.id != request.product.id).toList() : uiModels);

    Future<ProductUiModel> buildProductUiModelFuture(Product product) async {
      try {
        String id = product.id;
        String imageUrl = await repository.productImageUrlFuture(product.image);
        String title = product.title;
        String supplierTitle = product.supplierTitle.toUpperCase();
        String price = '\$${product.price}';
        Stream<Resource<FavoriteUiModel>> favoriteUiModelStream = repository
            .isProductFavoritedStream(id)
            .asyncMap((isFavorited) {
              return buildFavoriteUiModel(product, isFavorited);
            })
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
        throw FavoritesBlocInvalidProductException();
      }
    }

    Future<FavoriteUiModel> buildFavoriteUiModel(Product product, bool isFavorited) async {
      try {
        String assetName = isFavorited
            ? 'assets/icons/heart_checked.png' : 'assets/icons/heart_unchecked.png';

        FavoritesRequest request = FavoritesRequest.remove(product);

        Function action = () {
          favoriteRequestsSubject.add(request);
        };

        return FavoriteUiModel(assetName: assetName, action: action);
      } catch (error) {
        throw FavoritesBlocInvalidFavoriteException();
      }
    }

    Stream<Resource<void>> buildFavoriteStream() => favoriteRequestsSubject
        .switchMap(_handleRemoveFromFavoriteRequest)
        .share()
        .publishReplay(maxSize: 1)
        .autoConnect();

    Stream<Resource<void>> _handleRemoveFromFavoriteRequest(RemoveFromFavoritesRequest request) => repository
        .removeFromFavorites(request.product)
        .asStream()
        .map((_) => Resource.success())
        .startWith(Resource.loading())
        .onErrorReturnWith((error) => Resource.error(error: error));
}