
import 'package:customer/ios/styles.dart';
import 'package:flutter/cupertino.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ProductListItem(index: index);
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      margin: EdgeInsets.only(left: 112.0),
      color: CupertinoColors.systemGrey4,
    );
  }
}

class ProductListItem extends StatelessWidget {
  ProductListItem({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117.0,
      margin: EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: (index > 0) ? _Divider() : null,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image(
                      width: 88.0,
                      height: 88.0,
                      fit: BoxFit.fitHeight,
                      image: AssetImage('graphics/coffee_${(index % 5)}.jpg')),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 25.0, right: 10.0, top: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 6.0),
                          child: Text('Cerrado Arabica', style: Styles.productListName),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2.0),
                          child: Text('Countrywide', style: Styles.productListSupplierName),
                        ),
                        Expanded(
                          child: Container(
                            alignment: AlignmentDirectional.bottomStart,
                            margin: EdgeInsets.only(bottom: 12.0),
                            child: Text('\$85', style: Styles.productListPrice),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
