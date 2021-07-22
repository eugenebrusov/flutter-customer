
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductDetailsActionWidget extends StatelessWidget {
  ProductDetailsActionWidget({
    Key key,
    @required ProductDetailsActionItemUiModel uiModel,
    bool showBorder = true
  }) : _uiModel = uiModel,
        _showBorder = showBorder,
        super(key: key);

  final ProductDetailsActionItemUiModel _uiModel;
  final bool _showBorder;

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.centerLeft,
    height: 44.0,
    margin: EdgeInsets.only(
        top: _uiModel.topMargin,
        left: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeLeftInset,
        right: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeRightInset,
    ),
    decoration: _showBorder ? BoxDecoration(
      border: Border(bottom: BorderSide(color: Themes.CupertinoTheme.of(context).navBarBorderColor))
    ) : null,
    child: Padding(
      padding: EdgeInsets.only(
        right: 6.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _uiModel.actionText,
              style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.link,
            ),
          ),
          ImageIcon(AssetImage(_uiModel.asset), size: 18.0)
        ],
      ),
    ),
  );
}