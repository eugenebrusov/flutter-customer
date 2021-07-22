import 'package:customer/bloc/browse/browse_bloc.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:customer/ios/ui/browse/browse_category_widget.dart';
import 'package:customer/ios/ui/common/search_bar_widget.dart';
import 'package:customer/localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Stack(
            children: <Widget>[
              StreamBuilder<Resource<void>>(
                stream: Provider.of<BrowseBloc>(context, listen: false).favoriteRequestsStream,
                builder: (context, snapshot) {
                  // todo perhaps catch Resource.error and show snackbar saying adding to favorites failed
                  return Container();
                }
              ),
              _BrowseContent()
            ],
        )
    );
  }
}

class _BrowseContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBarWidget(
            placeholderText: AppLocalizations.of(context).searchPlaceholderProducts
        ),
        Expanded(
          child: StreamBuilder<Resource<List<BrowseCategoryUiModel>>>(
            stream: Provider.of<BrowseBloc>(context, listen: false).categoryUiModelsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Resource<List<BrowseCategoryUiModel>> resource = snapshot.data;
                if (resource is Success<List<BrowseCategoryUiModel>>) {
                  return _buildBrowseContentSuccess(context, resource.data);
                } else if (resource is Loading) {
                  return _buildBrowseContentLoading(context);
                } else if (resource is Error) {
                  return _buildBrowseContentError(context);
                }
              } else if (snapshot.hasError) {
                return _buildBrowseContentError(context);
              }

              return _buildBrowseContentLoading(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBrowseContentSuccess(BuildContext context, List<BrowseCategoryUiModel> uiModels) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        itemCount: uiModels.length,
        itemBuilder: (BuildContext context, int index) => BrowseCategoryWidget(
            uiModel: uiModels[index]
        ),
        separatorBuilder: (BuildContext context, int index) => Container(height: 25.0)
    );
  }

  Widget _buildBrowseContentError(BuildContext context) {
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
                Provider.of<BrowseBloc>(context, listen: false).reloadCategories();
              }
          ),
        )
      ],
    );
  }

  Widget _buildBrowseContentLoading(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(animating: true),
    );
  }
}