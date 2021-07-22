
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductDetailsInfoWidget extends StatelessWidget {
  ProductDetailsInfoWidget({
    Key key,
    @required ProductDetailsInfoItemUiModel uiModel,
    bool showBorder = true
  }) : _uiModel = uiModel,
        _showBorder = showBorder,
        super(key: key);

  final ProductDetailsInfoItemUiModel _uiModel;
  final bool _showBorder;

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.centerLeft,
    height: 44.0,
    margin: EdgeInsets.only(
      left: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeLeftInset,
      right:  Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeRightInset,
    ),
    decoration: _showBorder ? BoxDecoration(
      border: Border(bottom: BorderSide(color: Themes.CupertinoTheme.of(context).navBarBorderColor))
    ) : null,
    child: Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Row(
        children: <Widget>[
          Text(_uiModel.titleText,
              style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.secondaryLabel,
          ),
          Expanded(
            child: Text(
              _uiModel.valueText,
              textAlign: TextAlign.right,
              style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.label,
            ),
          )
        ],
      ),
    ),
  );
}