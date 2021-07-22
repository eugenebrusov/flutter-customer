
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductDetailsRatingWidget extends StatelessWidget {
  ProductDetailsRatingWidget({
    Key key,
    @required ProductDetailsRatingItemUiModel uiModel
  }) : _uiModel = uiModel,
        super(key: key);

  final ProductDetailsRatingItemUiModel _uiModel;
  
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      left: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeLeftInset,
      right: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeRightInset
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ImageIcon(AssetImage('assets/icons/full_star.png'), size: 15.0),
        ImageIcon(AssetImage('assets/icons/full_star.png'), size: 15.0),
        ImageIcon(AssetImage('assets/icons/full_star.png'), size: 15.0),
        ImageIcon(AssetImage('assets/icons/full_star.png'), size: 15.0),
        ImageIcon(AssetImage('assets/icons/semi_star.png'), size: 15.0),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
              _uiModel.ratingText,
              style: Themes.CupertinoTheme.of(context).textTheme.caption2TextStyleSet.link
          ),
        )
      ],
    ),
  );
}