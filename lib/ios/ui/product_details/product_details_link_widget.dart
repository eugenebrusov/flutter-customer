
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductDetailsLinkWidget extends StatelessWidget {
  ProductDetailsLinkWidget({
    Key key,
    @required ProductDetailsLinkItemUiModel uiModel
  }) : _uiModel = uiModel,
        super(key: key);

  final ProductDetailsLinkItemUiModel _uiModel;

  @override
  Widget build(BuildContext context) => Container(
    height: 44.0,
    margin: EdgeInsets.only(
      top: 30.0,
      left: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeLeftInset,
      right: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeRightInset,
    ),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Themes.CupertinoTheme.of(context).navBarBorderColor))
    ),
    child: Row(
      children: <Widget>[
        Text(_uiModel.titleText,
            style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.secondaryLabel,
        ),
        Expanded(
          child: Text(
            _uiModel.linkText,
            textAlign: TextAlign.right,
            style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.link,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            CupertinoIcons.forward,
            size: 16.0,
          ),
        )
      ],
    ),
  );
}