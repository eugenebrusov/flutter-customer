
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:customer/bloc/product_details/product_details_bloc.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;
import 'package:customer/ios/ui/product_details/product_details_action_widget.dart';
import 'package:customer/ios/ui/product_details/product_details_description_widget.dart';
import 'package:customer/ios/ui/product_details/product_details_info_widget.dart';
import 'package:customer/ios/ui/product_details/product_details_link_widget.dart';
import 'package:customer/ios/ui/product_details/product_details_rating_widget.dart';
import 'package:customer/ios/ui/product_details/product_details_similar_products_widget.dart';
import 'package:customer/ios/ui/product_details/product_details_title_price_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/ui/common/nav_bar.dart' as custom;
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = 'productDetails';

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    child: StreamBuilder<Resource<ProductDetailsUiModel>>(
        stream: Provider.of<ProductDetailsBloc>(context, listen: false).productDetailsUiModelStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Resource<ProductDetailsUiModel> resource = snapshot.data;
            if (resource is Success<ProductDetailsUiModel>) {
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
        }),
  );

  Widget _buildSuccessWidget(BuildContext context, ProductDetailsUiModel uiModel) => CustomScrollView(
    slivers: <Widget>[
      custom.CupertinoSliverNavigationBar(
        title: uiModel.headerUiModel.titleText,
        imageUrl: uiModel.headerUiModel.imageUrl
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) =>
              _buildProductDetailsIndexedWidget(uiModel.itemUiModels[index]),
          childCount: uiModel.itemUiModels.length)
      ),
      SliverPadding(padding: const EdgeInsets.only(bottom: 44.0))
    ],
  );

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
                //
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

  Widget _buildProductDetailsIndexedWidget(ProductDetailsItemUiModel itemUiModel) {
    if (itemUiModel is ProductDetailsTitlePriceItemUiModel) {
      return ProductDetailsTitlePriceWidget(uiModel: itemUiModel);
    } else if (itemUiModel is ProductDetailsRatingItemUiModel) {
      return ProductDetailsRatingWidget(uiModel: itemUiModel);
    } else if (itemUiModel is ProductDetailsDescriptionItemUiModel) {
      return ProductDetailsDescriptionWidget(uiModel: itemUiModel);
    } else if (itemUiModel is ProductDetailsLinkItemUiModel) {
      return ProductDetailsLinkWidget(uiModel: itemUiModel);
    } else if (itemUiModel is ProductDetailsInfoItemUiModel) {
      return ProductDetailsInfoWidget(uiModel: itemUiModel);
    } else if (itemUiModel is ProductDetailsActionItemUiModel) {
      return ProductDetailsActionWidget(uiModel: itemUiModel);
    } else if (itemUiModel is ProductDetailsSimilarProductsItemUiModel) {
      return ProductDetailsSimilarProductsWidget(uiModel: itemUiModel);
    }
    assert(false, 'Unexpected item ui model $itemUiModel');
    return null;
//            if (index == 0) {
//              return ProductDetailsTitlePriceWidget();
//            } else if (index == 1) {
//              return ProductDetailsRatingWidget();
//            } else if (index == 2) {
//              return ProductDetailsDescriptionWidget();
//            } else if (index == 3) {
//              return ProductDetailsLinkWidget();
//            } else if (index == 4) {
//              return ProductDetailsInfoWidget(title: 'Category', value: 'Coffee');
//            } else if (index == 5) {
//              return ProductDetailsInfoWidget(title: 'Status', value: 'On stock');
//            } else if (index == 6) {
//              return ProductDetailsInfoWidget(title: 'Shipment', value: 'On request');
//            } else if (index == 7) {
//              return ProductDetailsActionWidget(action: 'Remove from favorites', asset: 'assets/icons/heart_checked.png', topMargin: 44.0);
//            } else if (index == 8) {
//              return ProductDetailsActionWidget(action: 'Add to short list', asset: 'assets/icons/short_list.png');
//            } else {
//              return ProductDetailsActionWidget(action: 'Add to cart', asset: 'assets/icons/cart_action.png');
//            }
  }
}