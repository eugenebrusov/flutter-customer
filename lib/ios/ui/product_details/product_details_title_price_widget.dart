
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductDetailsTitlePriceWidget extends StatelessWidget {
  ProductDetailsTitlePriceWidget({
    Key key,
    @required ProductDetailsTitlePriceItemUiModel uiModel
  }) : _uiModel = uiModel,
        super(key: key);

  final ProductDetailsTitlePriceItemUiModel _uiModel;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: 24.0,
      left: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeLeftInset,
      right: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeRightInset
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(_uiModel.title,
              style: Themes.CupertinoTheme.of(context).textTheme.title1TextStyleSet.label
          ),
        ),
        Text(_uiModel.price,
            style: Themes.CupertinoTheme.of(context).textTheme.caption1TextStyleSet.label.copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 0.27)
        )
      ],
    ),
  );
}