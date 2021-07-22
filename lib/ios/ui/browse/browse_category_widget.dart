
import 'package:customer/bloc/browse/browse_bloc.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:customer/ios/ui/common/product_widget.dart';
import 'package:customer/ios/ui/product_list_screen.dart';
import 'package:flutter/cupertino.dart';

class BrowseCategoryWidget extends StatelessWidget {
  BrowseCategoryWidget({
    Key key,
    @required BrowseCategoryUiModel uiModel
  }) : _uiModel = uiModel,
        super(key: key);

  final BrowseCategoryUiModel _uiModel;

  GestureTapCallback _seeAllProductsCallback(BuildContext context) => () {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) {
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                previousPageTitle: 'Browse',
                middle: Text('Stub Title'),
              ),
              child: ProductListScreen()
          );
        }
    ));
  };

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _uiModel.productUiModelsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Resource<List<ProductUiModel>> resource = snapshot.data;
          if (resource is Success<List<ProductUiModel>>) {
            return _buildSuccessWidget(context, resource.data);
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
    );
  }

  Widget _buildSuccessWidget(BuildContext context, List<ProductUiModel> productUiModels) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 24.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_uiModel.title, style: Themes.CupertinoTheme.of(context).textTheme.title2TextStyleSet.label),
              Container(
                margin: const EdgeInsets.only(top: 2.0),
                child: CupertinoButton(
                    child: Text(_uiModel.seeAllButtonTitle, style: Themes.CupertinoTheme.of(context).textTheme.caption1TextStyleSet.link),
                    onPressed: _seeAllProductsCallback(context)
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: _uiModel.categoryWidgetHeight,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            itemCount: productUiModels.length,
            itemBuilder: (BuildContext context, int index) => SizedBox.fromSize(
              size: _uiModel.productWidgetSize,
              child: ProductWidget(
                uiModel: productUiModels[index],
              ),
            ),
            separatorBuilder: (BuildContext context, int index) => Container(
                width: 12.0
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      height: 300.0,
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(animating: true),
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
              onPressed: () { }
          ),
        )
      ],
    );
  }
}