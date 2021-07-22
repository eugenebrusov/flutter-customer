
import 'package:customer/bloc/common/product_details_ui_model.dart';
import 'package:customer/ios/ui/common/product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class ProductDetailsSimilarProductsWidget extends StatelessWidget {
  ProductDetailsSimilarProductsWidget({
    Key key,
    @required ProductDetailsSimilarProductsItemUiModel uiModel,
    bool showBorder = true
  }) : _uiModel = uiModel,
        super(key: key);

  final ProductDetailsSimilarProductsItemUiModel _uiModel;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 44.0, left: 24.0, right: 10.0),
        alignment: Alignment.centerLeft,
        child: Text(
            'Compare with',
            style: Themes.CupertinoTheme.of(context).textTheme.calloutTextStyleSet.label
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: _uiModel.containerWidgetHeight,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            itemCount: _uiModel.similarProductUiModels.length,
            itemBuilder: (BuildContext context, int index) => SizedBox.fromSize(
              size: _uiModel.productWidgetSize,
              child: ProductWidget(
                uiModel: _uiModel.similarProductUiModels[index],
              ),
            ),
            separatorBuilder: (BuildContext context, int index) => Container(
                width: 12.0
            ),
          ),
        ),
      )
    ],
  );
}