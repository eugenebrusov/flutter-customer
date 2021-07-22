import 'package:customer/bloc/common/favorite_ui_model.dart';
import 'package:customer/bloc/common/product_ui_model.dart';
import 'package:customer/data/model/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductWidget extends StatelessWidget {
  ProductWidget({
    Key key,
    @required ProductUiModel uiModel
  }) : _uiModel = uiModel,
        super(key: key);

  final ProductUiModel _uiModel;

  Widget _buildProductImage(BuildContext context) => Stack(
    children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl: _uiModel.imageUrl
          ),
        ),
      ),
      Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder<Resource<FavoriteUiModel>>(
              stream: _uiModel.favoriteUiModelStream,
              builder: (context, snapshot) {
                if (snapshot.data is Success<FavoriteUiModel>) {
                  final FavoriteUiModel uiModel = (snapshot.data as Success<FavoriteUiModel>).data;
                  return GestureDetector(
                      onTap: uiModel.action,
                      child: ImageIcon(
                          AssetImage(uiModel.assetName),
                          color: Themes.CupertinoTheme.of(context).primaryContrastingColor
                      )
                  );
                }

                return Container();
              }
          )
      ),
    ],
  );

  Widget _buildProductDescription(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_uiModel.title,
          style: Themes.CupertinoTheme.of(context).textTheme.bodyTextStyleSet.label,
          overflow: TextOverflow.ellipsis,
        ),
        Text(_uiModel.supplierTitle, style: Themes.CupertinoTheme.of(context).textTheme.caption2TextStyleSet.secondaryLabel),
      ],
    ),
  );

  Widget _buildProductPriceInCart(BuildContext context) => Row(
    children: <Widget>[
      Text(_uiModel.price, style: Themes.CupertinoTheme.of(context).textTheme.caption1TextStyleSet.label.copyWith(fontSize: 20.0, fontWeight: FontWeight.normal, letterSpacing: -0.5)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
        margin: const EdgeInsets.only(left: 8.0, top: 1.0),
        decoration: BoxDecoration(
          border: Border.all(color: Themes.CupertinoTheme.of(context).primaryColor),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageIcon(AssetImage('assets/icons/cart.png'), color: Themes.CupertinoTheme.of(context).primaryColor),
              Container(
                  margin: const EdgeInsets.only(left: 3.0, right: 6.0),
                  child: Text('O', style: Themes.CupertinoTheme.of(context).textTheme.caption1TextStyleSet.link)
              )
            ]
        ),
      )
    ],
  );

  Widget build(BuildContext context) => CupertinoButton(
    onPressed: _uiModel.selectAction,
    padding: const EdgeInsets.all(0.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildProductImage(context),
        _buildProductDescription(context),
        _buildProductPriceInCart(context)
      ],
    ),
  );
}