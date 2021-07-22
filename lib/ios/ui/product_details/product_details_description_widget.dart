
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductDetailsDescriptionWidget extends StatelessWidget {
  ProductDetailsDescriptionWidget({
    Key key,
    @required ProductDetailsDescriptionItemUiModel uiModel
  }) : _uiModel = uiModel,
        super(key: key);

  final ProductDetailsDescriptionItemUiModel _uiModel;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: 16.0,
      left: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeLeftInset,
      right: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeRightInset
    ),
    child: Stack(
      children: <Widget>[
        Text(
          _uiModel.descriptionText,
          style: Themes.CupertinoTheme.of(context).textTheme.bodyTextStyleSet.label,
          maxLines: _uiModel.descriptionMaxLines,
        ),
        Positioned(
          right: 0,
          bottom: 2,
          child: Container(
            width: 100.0,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0x00FFFFFF),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            child: CupertinoButton(
              padding: const EdgeInsets.all(0.0),
              minSize: 0.0,
              onPressed: _uiModel.expandButtonAction,
              child: Text(
                _uiModel.expandButtonText,
                style: Themes.CupertinoTheme.of(context).textTheme.subheadlineTextStyleSet.link,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}