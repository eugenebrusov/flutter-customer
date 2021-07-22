import 'package:customer/bloc/browse/browse_bloc_extension.dart';
import 'package:customer/bloc/common/favorites_request.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/data/source/repository.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/style/dimensions_theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BrowseBloc {
  BrowseBloc({
    @required this.context,
    @required this.repository,
    DimensionsThemeData dimensionsTheme
  }) : browseProductWidgetSize = calculateBrowseProductWidgetSize(),
        reloadCategoriesSubject = PublishSubject(),
        favoriteRequestsSubject = PublishSubject(),
        categoryUiModelsStream = buildCategoryUiModelsStream(),
        favoriteRequestsStream = buildFavoriteStream();

  final BuildContext context;
  final Repository repository;
  final Size browseProductWidgetSize;
  final PublishSubject<void> reloadCategoriesSubject;
  final PublishSubject<FavoritesRequest> favoriteRequestsSubject;
  final Stream<Resource<List<BrowseCategoryUiModel>>> categoryUiModelsStream;
  final Stream<Resource<void>> favoriteRequestsStream;

  void reloadCategories() {
    reloadCategoriesSubject.add(null);
  }

  void dispose() {
    reloadCategoriesSubject.close();
    favoriteRequestsSubject.close();
  }

//    final categories = <String>[
//      'Coffee',
//      'Meat',
//      'Poultry',
//      'Packaging',
//      'Seafood',
//      'Vegetables',
//      'Bakery',
//      'Dry Food',
//      'Spices',
//      'Frozen Food',
//      'Cocoa - Vamilla',
//      'Beverage',
//      'Disposables',
//      'Machines & Equipment',
//      'Furnitures',
//      'Construction',
//      'Communications'
//    ];
}

class BrowseCategoryUiModel {
  final String id;
  final String title;
  final String seeAllButtonTitle;
  final double categoryWidgetHeight;
  final Size productWidgetSize;
  final Stream<Resource<List<ProductUiModel>>> productUiModelsStream;

  BrowseCategoryUiModel({
    @required this.id,
    @required this.title,
    @required this.seeAllButtonTitle,
    @required this.categoryWidgetHeight,
    @required this.productWidgetSize,
    @required this.productUiModelsStream
  });
}
