
import 'package:flutter/cupertino.dart';
import 'package:customer/ios/styles/themes.dart' as Themes;

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({
    Key key,
    @required String placeholderText
  }) : _placeholderText = placeholderText,
        super(key: key);

  final String _placeholderText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.0,
      margin: EdgeInsets.only(
          left: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeLeftInset,
          right: Themes.CupertinoTheme.of(context).dimensionsTheme.windowEdgeRightInset,
          top: 60.0,
          bottom: 24.0
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
                color: Color(0x190D3320),
                blurRadius: 20.0,
                offset: const Offset(0.0, 6.0)
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Row(
        children: <Widget>[
          ImageIcon(AssetImage('assets/icons/search.png'), color: Themes.CupertinoTheme.of(context).inactiveTabBarColor),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(_placeholderText, style: Themes.CupertinoTheme.of(context).textTheme.footnoteTextStyleSet.secondaryLabel)
              )
          ),
          ImageIcon(AssetImage('assets/icons/filter.png'), color: Themes.CupertinoTheme.of(context).inactiveTabBarColor),
        ],
      ),
    );
  }
}