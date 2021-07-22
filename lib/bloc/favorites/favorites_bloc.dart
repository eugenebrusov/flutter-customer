import 'package:customer/bloc/common/favorites_request.dart';
import 'package:customer/bloc/favorites/favorites_bloc_extension.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/data/model/resource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:customer/data/source/repository.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc {
  FavoritesBloc({@required this.context, @required this.repository})
      : reloadSubject = PublishSubject(),
        favoriteRequestsSubject = PublishSubject(),
        productUiModelsStream = buildProductUiModelsStream(),
        favoriteRequestsStream = buildFavoriteStream();

  final BuildContext context;
  final Repository repository;
  final PublishSubject<void> reloadSubject;
  final PublishSubject<RemoveFromFavoritesRequest> favoriteRequestsSubject;
  final Stream<Resource<List<ProductUiModel>>> productUiModelsStream;
  final Stream<Resource<void>> favoriteRequestsStream;

  void dispose() {
    reloadSubject.close();
    favoriteRequestsSubject.close();
  }

  void reload() {
    reloadSubject.add(null);
  }
}
