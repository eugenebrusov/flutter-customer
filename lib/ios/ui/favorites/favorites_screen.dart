
import 'package:customer/ios/bloc/tab_navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:customer/data/model/resource.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/bloc/favorites/favorites_bloc.dart';
import 'package:customer/ios/ui/common/product_widget.dart';
import 'package:customer/ios/ui/common/search_bar_widget.dart';
import 'package:customer/localizations/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Stack(
            children: <Widget>[
              StreamBuilder<Resource<void>>(
                  stream: Provider.of<FavoritesBloc>(context, listen: false).favoriteRequestsStream,
                  builder: (context, snapshot) {
                    // todo perhaps catch Resource.error and show snackbar saying adding to favorites failed
                    return Container();
                  }
              ),
              _FavoritesContent()
            ]
        )
    );
  }
}

class _FavoritesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      SearchBarWidget(
          placeholderText: AppLocalizations.of(context).searchPlaceholderFavorites
      ),
      Expanded(
        child: StreamBuilder<Resource<List<ProductUiModel>>>(
          stream: Provider.of<FavoritesBloc>(context, listen: false).productUiModelsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Resource<List<ProductUiModel>> resource = snapshot.data;
              if (resource is Success<List<ProductUiModel>>) {
                final List<ProductUiModel> uiModels = resource.data;
                if (uiModels.isNotEmpty) {
                  return _buildSuccessWidget(context, resource.data);
                } else {
                  return _buildEmptyListWidget(context);
                }
              } else if (resource is Loading) {
                return _buildLoadingWidget(context);
              } else if (resource is Error) {
                return _buildErrorWidget(context);
              }
            } else if (snapshot.hasError) {
              return _buildErrorWidget(context);
            }

            return _buildLoadingWidget(context);
          },
        ),
      ),
    ],
  );

  Widget _buildSuccessWidget(BuildContext context, List<ProductUiModel> uiModels) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 32.0,
            childAspectRatio: 0.66
        ),
        padding: const EdgeInsets.all(24.0),
        itemCount: uiModels.length,
        itemBuilder: (BuildContext context, int index) {
          ProductUiModel uiModel = uiModels[index];
          return ProductWidget(uiModel: uiModel);
        }
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            'Unknown error occurred!',
            style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.label
        ),
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: CupertinoButton(
              child: Text('Retry'),
              onPressed: () {
                Provider.of<FavoritesBloc>(context, listen: false).reload();
              }
          ),
        )
      ],
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(animating: true),
    );
  }

  Widget _buildEmptyListWidget(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No products added to favorites yet!',
          style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.label,
          textAlign: TextAlign.center,
        ),
      ),
      GestureDetector(
        onTap: () {
          Provider.of<NavigationBloc>(context, listen: false).switchTab(2);
        },
        child: Container(
          width: 112.0,
          height: 40.0,
          decoration: BoxDecoration(
            border: Border.all(color: Themes.CupertinoTheme.of(context).primaryColor),
          ),
          child: Container(
              alignment: Alignment.center,
              child: Text('Go to Browse'.toUpperCase(), style: Themes.CupertinoTheme.of(context).textTheme.caption1TextStyleSet.link)
          ),
        ),
      )
    ],
  );
}